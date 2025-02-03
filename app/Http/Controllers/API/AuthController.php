<?php

namespace App\Http\Controllers\API;

use App\Models\User;
use App\Models\Profile;
use App\Models\Seeking;
use Illuminate\Support\Str;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Auth\Events\Registered;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;
use PHPOpenSourceSaver\JWTAuth\Facades\JWTAuth;
use PHPOpenSourceSaver\JWTAuth\Exceptions\JWTException;

class AuthController extends Controller
{
    /**
     * User registration.
     */
    public function register(Request $request)
    {
        try {
            // Start a database transaction
            DB::beginTransaction();

            // Validate basic fields first
            $validator = Validator::make($request->all(), [
                'name' => 'required|string|max:255',
                'username' => 'required|string|max:50|unique:users',
                'email' => 'required|string|email|max:255|unique:users',
                'password' => 'required|string|min:6|confirmed|max:100',
                'ismatchmaker' => 'required|boolean',
                'privacypolicy' => 'required|boolean',
                'termsofuse' => 'required|boolean',
                'age' => 'nullable|integer|min:18|max:100', // Assuming age is required for all users
                'city' => 'required|string|max:255',
                'state' => 'required|string|max:255',
                'country' => 'required|string|max:255',
                'phone_number' => 'required|string|max:255',
            ]);

            if ($validator->fails()) {
                return response()->json([
                    'success' => false,
                    'message' => 'Validation error',
                    'errors' => $validator->errors()
                ], 422);
            }

            // Create user
            $user = User::create([
                'name' => $request->name,
                'username' => $request->username,
                'email' => $request->email,
                'phone_number' => $request->phone_number,
                'phone_verified' => false,
                'password' => Hash::make($request->password),
                'role' => $request->boolean('ismatchmaker') ? 'candidate' : 'client',
                // Add other fields if necessary
            ]);

            // Prepare common profile data
            $profileData = [
                'user_id' => $user->id,
                'name' => $request->name, // Including name in profileData
                'city' => $request->city,
                'state' => $request->state,
                'country' => $request->country,
                'age' => $request->age, // Dynamic age assignment
            ];

            if ($request->boolean('ismatchmaker')) {
                // Additional validation for matchmaker
                $matchmakerValidator = Validator::make($request->all(), [
                    'profile_image1' => 'required|image|mimes:jpeg,png,jpg,gif|max:2048',
                    'profile_image2' => 'required|image|mimes:jpeg,png,jpg,gif|max:2048',
                    'yearsexperience' => 'required|integer|min:0',
                    'bio' => 'required|string',
                ]);

                if ($matchmakerValidator->fails()) {
                    DB::rollBack();
                    return response()->json([
                        'success' => false,
                        'message' => 'Validation error',
                        'errors' => $matchmakerValidator->errors()
                    ], 422);
                }

                // Add matchmaker specific data
                $profileData = array_merge($profileData, [
                    'yearsexperience' => $request->yearsexperience,
                    'bio' => $request->bio,
                ]);
            } else {
               $seekingData = [
                'user_id' => $user->id,
               ];
               $seeking = Seeking::create($seekingData);
            }
            
            // Create the profile
            $profile = Profile::create($profileData);

            // Commit the transaction
            DB::commit();

            // Now handle image uploads after transaction commits
            if ($request->boolean('ismatchmaker')) {
                $this->handleImageUploads($request, $user, $profile);
            }

            // Trigger verification email
            event(new Registered($user));

            return response()->json([
                'success' => true,
                'message' => 'Registration successful! Please check your email for verification.',
                'data' => $user
            ], 201);

        } catch (\Exception $e) {
            // Rollback transaction in case of any failure
            DB::rollBack();

            // Log the error details
            Log::error('Registration failed: ' . $e->getMessage());
            Log::error('Stack trace: ' . $e->getTraceAsString());

            // Determine response based on exception type
            if ($e instanceof \Illuminate\Database\QueryException) {
                return response()->json([
                    'success' => false,
                    'message' => 'Database error occurred.',
                    'error' => 'A database error occurred while processing your request.'
                ], 500);
            }

            if ($e instanceof \Illuminate\Validation\ValidationException) {
                return response()->json([
                    'success' => false,
                    'message' => 'Validation failed',
                    'errors' => $e->errors()
                ], 422);
            }

            return response()->json([
                'success' => false,
                'message' => 'Registration failed',
                'error' => $e->getMessage(),
                'trace' => $e->getTraceAsString() // Optional: Remove in production
            ], 500);
        }
    }

    /**
     * Handle image uploads for matchmakers.
     *
     * @param \Illuminate\Http\Request $request
     * @param \App\Models\User $user
     * @param \App\Models\Profile $profile
     * @return void
     */
    private function handleImageUploads(Request $request, $user, $profile)
    {
        try {
            // Ensure the storage directory exists
            $storagePath = storage_path('app/public/profiles/' . $user->id);
            if (!file_exists($storagePath)) {
                mkdir($storagePath, 0755, true);
                Log::info('Created storage directory at: ' . $storagePath);
            }

            $profileDataToUpdate = [];

            // Handle profile_image1
            if ($request->hasFile('profile_image1')) {
                $file = $request->file('profile_image1');
                if ($file->isValid()) {
                    $profileDataToUpdate['profile_image1'] = $this->uploadImage($file, $user->id);
                    Log::info('Profile image 1 uploaded successfully for user ' . $user->id);
                } else {
                    Log::error('Invalid file for profile_image1: ' . $file->getErrorMessage());
                }
            }

            // Handle profile_image2
            if ($request->hasFile('profile_image2')) {
                $file = $request->file('profile_image2');
                if ($file->isValid()) {
                    $profileDataToUpdate['profile_image2'] = $this->uploadImage($file, $user->id);
                    Log::info('Profile image 2 uploaded successfully for user ' . $user->id);
                } else {
                    Log::error('Invalid file for profile_image2: ' . $file->getErrorMessage());
                }
            }

            // Update profile with image paths if any images were uploaded
            if (!empty($profileDataToUpdate)) {
                $profile->update($profileDataToUpdate);
                Log::info('Profile updated with new image paths for user ' . $user->id);
            }

            // Create symbolic link if it doesn't exist
            $this->ensureStorageLink();

        } catch (\Exception $e) {
            Log::error('Image upload failed for user ID ' . $user->id . ': ' . $e->getMessage());
            Log::error('Stack trace: ' . $e->getTraceAsString());
            throw new \Exception('Failed to upload images: ' . $e->getMessage());
        }
    }

    /**
     * Upload image and return its storage path.
     *
     * @param \Illuminate\Http\UploadedFile $file
     * @param int $userId
     * @return string
     * @throws \Exception
     */
    private function uploadImage($file, $userId)
    {
        try {
            // Generate a unique filename
            $fileName = Str::uuid() . '.' . $file->getClientOriginalExtension();

            // Store the file in the public disk under the user's directory
            $result = $file->storeAs('profiles/' . $userId, $fileName, 'public');

            if (!$result) {
                throw new \Exception('Failed to store file');
            }

            // Log the file path for debugging
            Log::info('File stored at: ' . $result);

            // Return the URL that will be accessible after storage:link
            return '/storage/profiles/' . $userId . '/' . $fileName;

        } catch (\Exception $e) {
            Log::error('Image upload failed: ' . $e->getMessage());
            Log::error('Stack trace: ' . $e->getTraceAsString());
            throw new \Exception('Failed to upload image: ' . $e->getMessage());
        }
    }

    /**
     * Ensure the storage symbolic link exists.
     *
     * @return void
     */
    private function ensureStorageLink()
    {
        $publicPath = public_path('storage');
        $storagePath = storage_path('app/public');

        if (!file_exists($publicPath)) {
            try {
                symlink($storagePath, $publicPath);
                Log::info('Storage symbolic link created successfully');
            } catch (\Exception $e) {
                Log::error('Failed to create storage symbolic link: ' . $e->getMessage());
            }
        }
    }

    /**
     * User login and token generation.
     */
    public function login(Request $request)
    {
        // Define validation rules
        $validator = Validator::make($request->all(), [
            'username' => 'required|string',
            'password' => 'required|string',
        ]);

        // Check for validation failures
        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'message' => 'Validation Error',
                'errors' => $validator->errors(),
            ], 422);
        }

        // Extract credentials
        $credentials = $request->only('username', 'password');

        try {
            // Attempt to authenticate and generate token
            if (!$token = JWTAuth::attempt($credentials)) {
                return response()->json([
                    'success' => false,
                    'message' => 'Invalid username or password.',
                ], 401);
            }
        } catch (JWTException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Could not create token.',
            ], 500);
        }

        // Retrieve authenticated user and their profile
        $user = Auth::user();
        $profile = $user->profile;

        // Check if email is verified
        if (!$user->hasVerifiedEmail()) {
            return response()->json([
                'success' => false,
                'message' => 'Please verify your email before logging in.',
            ], 403);
        }

        // Set the token in an HttpOnly cookie (7 days)
        $cookie = cookie(
            'token',             // Cookie name
            $token,              // Cookie value
            60 * 24 * 7,         // Duration in minutes (7 days)
            '/',                 // Path
            'connectyed.com',    // Domain - Replace with your domain
            true,                // Secure (HTTPS only)
            true,                // HttpOnly
            false,               // Raw
            'Strict'             // SameSite policy
        );

        // Successful authentication response with HttpOnly cookie
        return response()->json([
            'success' => true,
            'message' => 'Authorized',
            'data' => compact('user', 'profile'),
            'authorization' => [
                'token' => $token,
                'type' => 'bearer',
            ]
        ])->cookie($cookie);
    }

    /**
     * User logout.
     */
    public function logout()
    {
        try {
            // Invalidate the token
            JWTAuth::invalidate(JWTAuth::getToken());

            // Clear the 'token' cookie by setting its expiration to the past
            $cookie = cookie(
                'token',    // Cookie name
                null,       // Cookie value
                -1,         // Duration in minutes (negative to expire)
                '/',        // Path
                'connectyed.com', // Domain - Replace with your domain
                true,       // Secure (HTTPS only)
                true,       // HttpOnly
                false,      // Raw
                'Strict'    // SameSite policy
            );

            return response()->json([
                'success' => true,
                'message' => 'Successfully logged out',
                'data' => null
            ])->cookie($cookie);
        } catch (JWTException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to logout, please try again.',
            ], 500);
        }
    }

    /**
     * Refresh JWT token.
     */
    public function refresh()
    {
        try {
            $newToken = JWTAuth::refresh(JWTAuth::getToken());
        } catch (JWTException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Token refresh failed',
            ], 401);
        }

        $user = Auth::user();
        $profile = $user->profile;

        // Optionally, set the new token in a new HttpOnly cookie
        $cookie = cookie(
            'token',             // Cookie name
            $newToken,           // Cookie value
            60 * 24 * 7,         // Duration in minutes (7 days)
            '/',                 // Path
            'connectyed.com',    // Domain - Replace with your domain
            true,                // Secure (HTTPS only)
            true,                // HttpOnly
            false,               // Raw
            'Strict'             // SameSite policy
        );

        return response()->json([
            'success' => true,
            'message' => 'Token refreshed successfully',
            'data' => compact('user', 'profile'),
            'authorization' => [
                'token' => $newToken,
                'type' => 'bearer',
            ]
        ])->cookie($cookie);
    }

    /**
     * Introspect token and return user info.
     */
    public function introspect()
    {
        $user = Auth::user();
        if ($user) {
            $profile = $user->profile;
            $seeking = $user->seeking;

            // Add package information
            $packageInfo = [
                'purchased_package' => $user->purchased_package,
                'criteria_limit' => $user->criteria_limit,
                'package_purchased_at' => $user->package_purchased_at,
                'criteria' => $user->criteria
            ];

            return response()->json([
                'success' => true,
                'message' => 'Authorized',
                'data' => [
                    'user' => array_merge($user->toArray(), $packageInfo),
                    'profile' => $profile,
                    'seeking' => $seeking
                ]
            ]);
        } else {
            return response()->json([
                'success' => false,
                'message' => 'Unauthenticated'
            ], 401);
        }
    }

    /**
     * Resend verification email.
     */
    public function resendVerificationEmail(Request $request)
    {
        $user = $request->user();

        if ($user->hasVerifiedEmail()) {
            return response()->json([
                'success' => true,
                'message' => 'Email already verified.',
            ], 200);
        }

        $user->sendEmailVerificationNotification();

        return response()->json([
            'success' => true,
            'message' => 'Verification link sent!',
        ], 200);
    }


    public function deleteUser(Request $request)
    {
        $client = User::findOrFail($request->input('user_id'));

        if ($client) {
            $client->delete();

            return response()->json([
                'success' => true,
                'message' => 'User and all related data deleted successfully!',
            ], 200);
        } else {
            return response()->json([
                'success' => false,
                'message' => 'User not found!',
            ], 404);
        }
    }

    public function getProfileScore(Request $request) {
        $user = User::where('id', $request->user_id)->first();
        $profile = Profile::where('user_id', $request->user_id)->first();
        $seeker = Seeking::where('user_id', $request->user_id)->first();
    
        $fillableUsers = [
            'name',
            'username',
            'email',
            'password',
            'phone_number',
            'phone_verified',
        ];
        $fillableProfiles = [
            'user_id',
            'name',
            'city',
            'state',
            'country',
            'age',
            'gender',
            'bodytype',
            'ethnicity',
            'height',
            'inches',
            'haircolor',
            'maritalstatus',
            'children',
            'religion',
            'drinker',
            'education',
            'occupation',
            'jobtitle',
            'sports',
            'hobbies',
            'languages',
            'profile_image1',
            'profile_image2',
        ];
        $fillableSeekers = [
            'user_id',
            'min_age',
            'max_age',
            'summarize',
            'location',
            'current_kids_number',
            'desired_kids_number',
            'gender',
            'bodytype',
            'haircolor',
            'maritalstatus',
            'religion',
            'smoker',
            'drinker',
            'ethnicity'
        ];
    
        function countFilledFields($model, $fillableColumns) {
            if (!$model) return 0;
            return collect($fillableColumns)->filter(fn($col) => !empty($model->$col))->count();
        }
    
        $filledUsers = countFilledFields($user, $fillableUsers);
        $filledProfiles = countFilledFields($profile, $fillableProfiles);
        $filledSeekers = countFilledFields($seeker, $fillableSeekers);
    
        $totalFields = count($fillableUsers) + count($fillableProfiles) + count($fillableSeekers);
        $filledFields = $filledUsers + $filledProfiles + $filledSeekers;
    
        $score = ($totalFields > 0) ? round(($filledFields / $totalFields) * 100) : 0;
    
        return response()->json([
            'success' => true,
            'score' => $score,
            'message' => 'Profile score calculated successfully!',
        ], 200);
    } 
    
    public function updateOnDashboard(Request $request)
    {
        try {
            // Start a database transaction
            DB::beginTransaction();

            // Validate basic fields first
            $validator = Validator::make($request->all(), [
                'ismatchmaker' => 'required|boolean',
                'age' => 'nullable|integer|min:18|max:100',
                'phone_number' => 'nullable|string|max:255',
            ]);

            if ($validator->fails()) {
                return response()->json([
                    'success' => false,
                    'message' => 'Validation error',
                    'errors' => $validator->errors()
                ], 422);
            }

            $user = Auth::user();
            $profile = $user->profile;
            $seeking = $user->seeking;

            // Create user
            if ($request->has('phone_number')) {
                $user->phone_number = $request->phone_number;
                $user->save();
            }

            // Prepare common profile data
            $profileData = [
                'user_id' => $user->id,
            ];

            if ($request->has('name')) {
                $profileData['name'] = $request->name; // Only include if 'name' is in the request
            }

            if ($request->has('age')) {
                $profileData['age'] = $request->age; // Only include if 'age' is in the request
            }


            if ($request->boolean('ismatchmaker')) {
                // Additional validation for matchmaker
                $matchmakerValidator = Validator::make($request->all(), [
                    'profile_image1' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
                    'profile_image2' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
                    'yearsexperience' => 'nullable|integer|min:0',
                    'bio' => 'nullable|string',
                ]);

                if ($matchmakerValidator->fails()) {
                    DB::rollBack();
                    return response()->json([
                        'success' => false,
                        'message' => 'Validation error',
                        'errors' => $matchmakerValidator->errors()
                    ], 422);
                }

                // Add matchmaker specific data if fields exist in the request
                if ($request->has('yearsexperience')) {
                    $profileData['yearsexperience'] = $request->yearsexperience;
                }

                if ($request->has('bio')) {
                    $profileData['bio'] = $request->bio;
                }
            } else {
                \Log::info('Request payload:', $request->all());

                // Additional validation for clients
                $clientValidator = Validator::make($request->all(), [
                    'gender' => 'nullable|string|max:50',
                    'hairColor' => 'nullable|string|max:50',
                    'bodyType' => 'nullable|array',
                    'bodytype.*' => 'string', // Each value must be a string
                    'religion' => 'nullable|array',
                    'religion.*' => 'string', // Each value must be a string
                    'ethnicity' => 'nullable|array',
                    'ethnicity.*' => 'string', // Each value must be a string
                    'heightFeet' => 'nullable|integer|min:1|max:8',
                    'heightInches' => 'nullable|integer|min:0|max:11',
                    'maritalStatus' => 'nullable|array|min:1',
                    'maritalStatus.*' => 'string|distinct', // Each marital status must be a unique string
                    'children' => 'nullable|array|min:1',  // Must be an array with at least one value
                    'children.*' => 'string',
                    'smoker' => 'nullable|boolean',
                    'drinker' => 'nullable|string|in:None,Occasionally,Often',
                    'education' => 'nullable|string|max:255',
                    'occupation' => 'nullable|string|max:255',
                    'jobTitle' => 'nullable|string|max:255',
                    'languages' => 'array|max:4',  // Ensure it's an array and no more than 4 items
                    'languages.*.language' => 'nullable|string',
                    'languages.*.level' => 'nullable|string',
                    'seeking' => 'nullable',
                    "min_age" => "nullable",
                    "max_age" => "nullable",
                    "desired_children" => "nullable",
                    "seeking_location" => "nullable",
                    "seeking_hair_color" => "nullable",
                    "seeking_gender" => "nullable",
                    "seeking_body_type" => "nullable",
                    "seeking_marital_status" => "nullable",
                    "seeking_religion" => "nullable",
                    "seeking_smoker" => "nullable",
                    "seeking_drinker" => "nullable",
                    'profile_image1' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
                    'profile_image2' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
                ]);

                if ($clientValidator->fails()) {
                    DB::rollBack();
                    return response()->json([
                        'success' => false,
                        'message' => 'Validation error',
                        'errors' => $clientValidator->errors()
                    ], 422);
                }

                // Add client-specific profile data only if the field exists in the request
                if ($request->has('gender')) {
                    $profileData['gender'] = $request->gender;
                }
                if ($request->has('hairColor')) {
                    $profileData['haircolor'] = $request->hairColor;
                }
                if ($request->has('bodyType')) {
                    $profileData['bodytype'] = $request->bodyType;
                }
                if ($request->has('ethnicity')) {
                    $profileData['ethnicity'] = $request->ethnicity;
                }
                if ($request->has('heightFeet')) {
                    $profileData['height'] = $request->heightFeet;
                }
                if ($request->has('heightInches')) {
                    $profileData['inches'] = $request->heightInches;
                }
                if ($request->has('maritalStatus')) {
                    $profileData['maritalstatus'] = $request->maritalStatus;
                }
                if ($request->has('children')) {
                    $profileData['children'] = $request->children;
                }
                if ($request->has('religion')) {
                    $profileData['religion'] = $request->religion;
                }
                if ($request->has('smoker')) {
                    $profileData['smoker'] = $request->smoker ? '1' : '0';
                }
                if ($request->has('drinker')) {
                    $profileData['drinker'] = $request->drinker;
                }
                if ($request->has('education')) {
                    $profileData['education'] = $request->education;
                }
                if ($request->has('occupation')) {
                    $profileData['occupation'] = $request->occupation;
                }
                if ($request->has('jobTitle')) {
                    $profileData['jobtitle'] = $request->jobTitle;
                }
                if ($request->has('sports')) {
                    $profileData['sports'] = $request->sports;
                }
                if ($request->has('hobbies')) {
                    $profileData['hobbies'] = $request->hobbies;
                }
                if ($request->has('languages')) {
                    $profileData['languages'] = $request->languages;
                }

                if ($request->has('having_kids')) {
                    $profileData['having_kids'] = $request->having_kids == 'Yes' ? true : false;
                }

                if ($request->has('having_kids_in_future')) {
                    $profileData['having_kids_in_future'] = $request->having_kids_in_future == 'Yes' ? true : false;
                }


                // Add seeking data
                $seekingData = [];

                if ($request->has('min_age')) {
                    $seekingData['min_age'] = $request->min_age;
                }
                if ($request->has('max_age')) {
                    $seekingData['max_age'] = $request->max_age;
                }
                if ($request->has('seeking')) {
                    $seekingData['summarize'] = $request->seeking;
                }
                if ($request->has('seeking_location')) {
                    $seekingData['location'] = $request->seeking_location;
                }
                if ($request->has('current_kids_number')) {
                    $seekingData['current_kids_number'] = $request->current_kids_number;
                }
                if ($request->has('desired_children')) {
                    $seekingData['desired_kids_number'] = $request->desired_children;
                }
                if ($request->has('seeking_gender')) {
                    $seekingData['gender'] = $request->seeking_gender;
                }
                if ($request->has('seeking_body_type')) {
                    $seekingData['bodytype'] = $request->seeking_body_type;
                }
                if ($request->has('seeking_hair_color')) {
                    $seekingData['haircolor'] = $request->seeking_hair_color;
                }
                if ($request->has('seeking_marital_status')) {
                    $seekingData['maritalstatus'] = $request->seeking_marital_status;
                }
                if ($request->has('seeking_religion')) {
                    $seekingData['religion'] = $request->seeking_religion;
                }
                if ($request->has('seeking_smoker')) {
                    $seekingData['smoker'] = $request->seeking_smoker === 'No' ? 0 : 1;
                }
                if ($request->has('seeking_drinker')) {
                    $seekingData['drinker'] = $request->seeking_drinker;
                }
                if ($request->has('seeking_ethnicity')) {
                    $seekingData['ethnicity'] = $request->seeking_ethnicity;
                }

                if($seeking) {
                    $seeking->update($seekingData);
                } else {
                    $seeking = Seeking::create($seekingData);
                }
            }

            // Create the profile
            if($profile) {
                $profile->update($profileData);
            } else {
                $profile = Profile::create($profileData);
            }

            // Commit the transaction
            DB::commit();

            // Now handle image uploads after transaction commits
            if ($request->boolean('ismatchmaker')) {
                $this->handleImageUploads($request, $user, $profile);
            }

            // Trigger verification email
            event(new Registered($user));

            return response()->json([
                'success' => true,
                'message' => 'Registration successful! Please check your email for verification.',
                'data' => $user
            ], 201);

        } catch (\Exception $e) {
            // Rollback transaction in case of any failure
            DB::rollBack();

            // Log the error details
            Log::error('Updating failed: ' . $e->getMessage());
            Log::error('Stack trace: ' . $e->getTraceAsString());

            // Handle exception response
            if ($e instanceof \Illuminate\Database\QueryException) {
                return response()->json([
                    'success' => false,
                    'message' => 'Database error occurred.',
                    'error' => 'A database error occurred while processing your request.'
                ], 500);
            }

            if ($e instanceof \Illuminate\Validation\ValidationException) {
                return response()->json([
                    'success' => false,
                    'message' => 'Validation failed',
                    'errors' => $e->errors()
                ], 422);
            }

            return response()->json([
                'success' => false,
                'message' => 'Registration failed',
                'error' => $e->getMessage(),
                'trace' => $e->getTraceAsString() // Optional: Remove in production
            ], 500);
        }
    }
}

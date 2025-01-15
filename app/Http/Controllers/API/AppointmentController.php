<?php

namespace App\Http\Controllers\API;

use Carbon\Carbon;
use Google_Client;
use App\Models\User;
use Firebase\JWT\JWT;
use GuzzleHttp\Client;
use App\Models\Meeting;
use Stripe\StripeClient;
use Google_Service_Calendar;
use Illuminate\Http\Request;
use App\Services\ZoomService;
use Google_Service_Calendar_Event;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Cookie;
use Illuminate\Support\Facades\Validator;
use Google_Service_Calendar_EventDateTime;
use Illuminate\Support\Facades\Notification;
use PHPOpenSourceSaver\JWTAuth\Facades\JWTAuth;
use App\Notifications\MeetingScheduledNotification;
use Symfony\Component\HttpFoundation\Session\Session;
use App\Mail\MeetingRequest;
use Illuminate\Support\Facades\Mail;


class AppointmentController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth')->only(['redirectToGoogle', 'handleGoogleCallback']);
        $this->middleware('auth:api')->only(['createMeeting', 'revokeGoogleToken', 'checkGoogleAuthorization', 'getUpcomingMeetings']);
        // Initialize Stripe using configuration
        $stripeSecret = config('services.stripe.secret');

        if (empty($stripeSecret)) {
            Log::error('Stripe secret key is not set in config/services.php');
        } else {
            $this->stripe = new StripeClient($stripeSecret);
        }
    }

    public function createMeeting(Request $request)
    {
        try {
            // Validate the incoming request data
            $validator = Validator::make($request->all(), [
                'user_id' => 'required|exists:users,id',
                'timezone' => 'required|string',
                'slots' => 'required|array|min:1|max:3',
                'slots.*.date' => 'required',
                'slots.*.startTime' => 'required',
                'slots.*.endTime' => 'required|after:slots.*.startTime',
            ]);

            if ($validator->fails()) {
                Log::warning('Validation failed for createMeeting', ['errors' => $validator->errors()]);
                return response()->json([
                    'success' => false,
                    'message' => 'Invalid data provided.',
                    'errors' => $validator->errors(),
                ], 422);
            }

            // Retrieve authenticated user
            $authUser = Auth::user();
            if (!$authUser) {
                return response()->json([
                    'success' => false,
                    'message' => 'Unauthorized. Please log in.',
                ], 401);
            }

            $timezone = $request->timezone;
            $slots = $request->slots;

            // Ensure no duplicate slots
            $uniqueSlots = collect($slots)->unique(function ($slot) {
                return $slot['date'] . $slot['startTime'] . $slot['endTime'];
            });

            if ($uniqueSlots->count() !== count($slots)) {
                return response()->json([
                    'success' => false,
                    'message' => 'Duplicate time slots are not allowed.',
                ], 422);
            }

            $createdMeetings = [];
            $emailSent = false; // Flag to track if the email has been sent

            foreach ($slots as $slot) {
                $normalizedDate = Carbon::parse($slot['date'])->format('D, M d');
                $startTime = Carbon::createFromFormat('D, M d g:i A', $normalizedDate . ' ' . $slot['startTime'], $timezone);
                $endTime = Carbon::createFromFormat('D, M d g:i A', $normalizedDate . ' ' . $slot['endTime'], $timezone);

                // Prepare Zoom meeting data
                $roomTitle = "Identity Verification";
                $roomDuration = $startTime->diffInMinutes($endTime);
                $data = [
                    'title' => $roomTitle,
                    'date' => $startTime->toISOString(),
                    'duration' => $roomDuration,
                    'password' => rand(10000, 99999),
                    'created_id' => $authUser->id,
                    'api_type' => 'global',
                    'host_video' => 'enable',
                    'join_before_host' => 'enable',
                    'client_video' => 'enable',
                    'description' => 'This is my first ' . $roomTitle . '.',
                    'timezone' => $timezone,
                ];

                // Create Zoom meeting
                $accessToken = $this->getAccessToken();
                $response = $this->createAMeeting($data, $accessToken);

                if ($response && isset($response->id)) {
                    $meetingData = [
                        'meeting_topic' => $response->topic,
                        'meeting_start_url' => $response->start_url,
                        'meeting_join_url' => $response->join_url,
                        'google_meet_id' => $response->id,
                        'google_meet_link' => $response->join_url,
                        'meeting_response' => json_encode($response, JSON_PRETTY_PRINT),
                        'google_meet_password' => $response->password,
                        'meeting_id' => $response->id,
                        'meeting_password' => $data['password'],
                        'meeting_start_time' => $startTime,
                        'meeting_duration' => $roomDuration,
                        'created_by' => $authUser->id,
                        'start_time' => $startTime,
                        'end_time' => $endTime,
                        'duration' => $roomDuration,
                        'client_id' => $authUser->id,
                    ];

                    $newMeeting = Meeting::create($meetingData);
                    $client = User::find($request->user_id);
                    $createdMeetings[] = $newMeeting;

                    if (!$request->has('pickadate') || !$request->boolean('pickadate')) {
                        // Send notification for non-admin requests immediately
                        Notification::send($client, new MeetingScheduledNotification($newMeeting));
                    }
                } else {
                    Log::error('Failed to create Zoom meeting', ['response' => $response]);
                    return response()->json([
                        'success' => false,
                        'message' => 'Failed to create meeting on Zoom.',
                    ], 500);
                }
            }

            // Handle admin-specific logic and email sending after all meetings are created
            if ($request->has('pickadate') && $request->boolean('pickadate')) {
                if ($request->has('receiver')) {
                    $receiver = User::find($request->input('receiver'));
                    if ($receiver) {
                        $adminMessage = $request->input('admin_message', '');
                        Mail::to($receiver->email)->send(new MeetingRequest(
                            $receiver,
                            $adminMessage,
                            $createdMeetings
                        ));
                    } else {
                        Log::error('Receiver not found with ID: ' . $request->input('receiver'));
                    }
                } else {
                    Log::warning('Receiver input is missing.');
                }
            }

            return response()->json([
                'success' => true,
                'message' => 'Meetings created successfully.',
                'data' => $createdMeetings,
            ], 200);
        } catch (\Exception $e) {
            Log::error($e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Something went wrong: ' . $e->getMessage(),
            ], 500);
        }
    }

    public function getAccessToken() {
        $key = env('ZOOM_CLIENT_ID');
        $secret = env('ZOOM_CLIENT_SECRET');
        $token_url = env('ZOOM_TOKEN_URL');
        $accountId = env('ZOOM_ACCOUNT_ID');


        $base64String = base64_encode(env('ZOOM_CLIENT_ID') . ':' . env('ZOOM_CLIENT_SECRET'));

        $response = Http::withHeaders([
            "Content-Type"=> "application/x-www-form-urlencoded",
            "Authorization"=> "Basic {$base64String}"
        ])->post("https://zoom.us/oauth/token?grant_type=account_credentials&account_id={$accountId}");

        $data = json_decode($response->getBody(), true); 
        if($data['access_token']) {
            return $data['access_token'];
        } else {
            return "Please Check Your Zoom Credentials";
        }

    }

    protected function createAMeeting($data, $accessToken)
    {
        $request_url = 'https://api.zoom.us/v2/users/me/meetings';
        $headers = [
            'Authorization: Bearer ' . $accessToken,
            'Content-Type: application/json',
        ];
        $postFields = json_encode($data);   

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_URL, $request_url);
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $postFields);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);

        $response = curl_exec($ch);
        curl_close($ch);

        return json_decode($response);
    }

    /**
     * Refresh the Google access token for a given user.
     *
     * @param User $user
     * @return array
     */
    public function refreshGoogleToken(User $user)
    {
        if (!$user || !$user->google_refresh_token) {
            return ['success' => false, 'message' => 'No refresh token available.'];
        }

        try {
            $client = new Google_Client();
            $client->setClientId(config('services.google.client_id'));
            $client->setClientSecret(config('services.google.client_secret'));
            $client->setAccessType('offline');
            $client->refreshToken($user->google_refresh_token);
            $newToken = $client->getAccessToken();

            if (isset($newToken['access_token'])) {
                // Update tokens in the user model
                $user->google_access_token = $newToken['access_token'];
                if (isset($newToken['refresh_token'])) {
                    $user->google_refresh_token = $newToken['refresh_token'];
                }
                $user->google_token_expires_at = Carbon::now()->addSeconds($newToken['expires_in']);
                $user->save(); // Eloquent model's save method

                Log::info('Google tokens refreshed for user', ['user_id' => $user->id]);

                return ['success' => true];
            } else {
                Log::error('Failed to refresh Google token for user', ['user_id' => $user->id, 'response' => $newToken]);
                return ['success' => false, 'message' => 'Failed to refresh Google token.'];
            }
        } catch (\Exception $e) {
            Log::error('Exception during Google OAuth Token Refresh', ['exception' => $e->getMessage()]);
            return ['success' => false, 'message' => 'An error occurred while refreshing Google token.'];
        }
    }

    /**
     * Revoke the Google access token for a user.
     */
    public function revokeGoogleToken(Request $request)
    {
        $user = Auth::user();

        if (!$user || !$user->google_access_token) {
            return response()->json(['error' => 'No access token available to revoke.'], 400);
        }

        try {
            $client = new Google_Client();
            $client->setAccessToken($user->google_access_token);

            $response = $client->revokeToken();

            if (!$response) {
                Log::error('Google OAuth Token Revocation Failed');
                return response()->json(['error' => 'Failed to revoke access token.'], 400);
            }

            // Clear tokens from the user model
            $user->google_access_token = null;
            $user->google_refresh_token = null;
            $user->google_token_expires_at = null;
            $user->save(); // Eloquent model's save method

            Log::info('Google access token revoked for user', ['user_id' => $user->id]);

            return response()->json(['success' => true]);
        } catch (\Exception $e) {
            Log::error('Exception during Google OAuth Token Revocation', ['exception' => $e->getMessage()]);
            return response()->json(['error' => 'An error occurred while revoking Google token.'], 500);
        }
    }

    /**
     * Check if the authenticated user has authorized Google.
     */
    public function checkGoogleAuthorization()
    {
        $user = Auth::user();
        if ($user && $user->google_access_token) {
            if (Carbon::now()->gte($user->google_token_expires_at)) {
                $refreshResponse = $this->refreshGoogleToken($user);
                if (!$refreshResponse['success']) {
                    return response()->json(['authorized' => false, 'message' => 'Failed to refresh token.'], 500);
                }
            }
            return response()->json(['authorized' => true]);
        }
        return response()->json(['authorized' => false]);
    }

    public function getUpcomingMeetings(Request $request)
    {
        $user = Auth::user();

        if (!$user) {
            return response()->json([
                'success' => false,
                'message' => 'Unauthorized. Please log in.',
            ], 401);
        }

        // Fetch upcoming meetings along with matchmaker details for clients
        $clientMeetings = Meeting::where('matchmaker_id', null)
            ->where('client_id', $user->id)
            ->where('start_time', '>=', now())
            ->orderBy('start_time', 'asc')
            ->get()
            ->map(function ($meeting) {
                return [
                    'id' => $meeting->id,
                    'client_id' => $meeting->client_id,
                    'google_meet_id' => $meeting->google_meet_id,
                    'google_meet_link' => $meeting->google_meet_link,
                    'start_time' => $meeting->start_time,
                    'duration' => $meeting->duration,
                    'status' => $meeting->status,
                ];
            });

        return response()->json([
            'success' => true,
            'data' => $clientMeetings,
        ], 200);
    }
}
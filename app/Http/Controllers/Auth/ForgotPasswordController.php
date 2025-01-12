<?php

namespace App\Http\Controllers\Auth;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Foundation\Auth\SendsPasswordResetEmails;
use Illuminate\Support\Str;
use App\Models\User;
use App\Mail\ResetPassword;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Password;
use Illuminate\Auth\Events\PasswordReset;
use Illuminate\Support\Facades\Validator;

class ForgotPasswordController extends Controller
{
    use SendsPasswordResetEmails;

    public function sendResetLinkEmail(Request $request)
    {
        $request->validate(['email' => 'required|email']);

        // Generate a new random password
        $newPassword = Str::random(10); // Adjust the length of the password as needed

        // Find the user by email
        $user = User::where('email', $request->email)->first();

        if (!$user) {
            return response()->json(['success' => false, 'message' => __('User not found')], 404);
        }

        // Update user's password
        $user->password = bcrypt($newPassword);
        $user->save();

        try {
            Mail::to($user->email)->send(new ResetPassword($user, $newPassword));
            // Password sent successfully
            return response()->json(['success' => true, 'message' => __('Password sent successfully')]);
        } catch (\Exception $e) {
            // If sending the email fails, return an error response
            // \Log::error('Failed to send email: ' . $e->getMessage());
            return response()->json(['success' => false, 'message' => __('Failed to send email')], 500);
        }
    }

    public function reset(Request $request)
    {
        // Validate the incoming data
        $validator = Validator::make($request->all(), [
            'email' => 'required|email|exists:users,email',
            'token' => 'required|string',
            'password' => 'required|string|min:8|confirmed',
        ]);

        // If validation fails, return the error messages as JSON
        if ($validator->fails()) {
            return response()->json([
                'errors' => $validator->errors()
            ], 422); // 422 Unprocessable Entity for validation errors
        }
        // Validation passed, process the password reset
        // Example: Reset the password logic
        $user = User::where('email', $request->email)->first();
        if (!$user) {
            return response()->json(['message' => 'Invalid token or email.'], 400);
        }

        // Proceed with updating the password
        $user->password = bcrypt($request->password);
        $user->save();

        return response()->json(['message' => 'Password reset successfully.']);
    }
}

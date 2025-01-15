<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Auth;
use Illuminate\Http\Request;
use App\Models\RequestAvailability;
use App\Models\User;
use App\Mail\MeetingRequest;
use App\Mail\MeetingRequestSecondParty;
use Illuminate\Support\Str;
use Carbon\Carbon;

class RequestAvailabilityController extends Controller
{

    public function getRequestData(Request $request)
    {
        $ra = RequestAvailability::orderBy('id', 'desc')->with(['firstParty', 'secondParty', 'user'])->get();
        return response()->json([
            "success" => true,
            "data" => $ra,
            "message" => 'Request sent successfully.'
        ], 200);
    }

    public function sendMeetingRequest(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'user_id' => 'required|exists:users,id',
            'admin_message' => 'required|string',
            'receiver' => 'required|exists:users,id',
        ]);

        // admin - sender of the request
        $user = Auth::user();
        // user who receives this email (either client or matchmaker)
        $receiver = User::findOrFail($request->input('receiver'));


        $ra = new RequestAvailability;
        $ra->code = Str::uuid()->toString();
        $ra->user_id = $user->id;
        $ra->client_one_id = $receiver->id;
        $ra->save();

        $url = url('/') . '/pick-a-date/' . ($ra->code);

        if($receiver) {
            Mail::to($receiver->email)->send(new MeetingRequest(
                $receiver,
                $request->input('admin_message'),
                $url
            ));

            return response()->json([
                "success" => true,
                "message" => 'Request sent successfully.'
            ], 200);
        } else {
            return response()->json([
                "success" => false,
                "message" => 'Something went wrong!'
            ], 400);
        }
    }

    public function getFirstPartyResponse(Request $request)
    {
        $ra = RequestAvailability::where('code', $request->input('route_id'))
        ->where('client_one_id', $request->input('user_id'))
        ->whereNotNull('start_date_one')
        ->first();
        if ($ra) {
            return response()->json([
                "success" => true,
                "data" => $ra,
                "message" => 'Request sent successfully.'
            ], 200);
        } else {
            return response()->json([
                "success" => true,
                "data" => null,
                "message" => 'Something went wrong!'
            ], 200);
        }
    }

    public function getSecondPartyResponse(Request $request)
    {
        $ra = RequestAvailability::where('code', $request->input('route_id'))
        ->where('client_two_id', $request->input('user_id'))
        ->whereNull('chosen_date')
        ->first();
        if ($ra) {
            return response()->json([
                "success" => true,
                "data" => $ra,
                "message" => 'Request sent successfully.'
            ], 200);
        } else {
            return response()->json([
                "success" => true,
                "data" => null,
                "message" => 'Something went wrong!'
            ], 200);
        }
    }

    public function storeFirstPartyResponse(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'user_id' => 'required|exists:users,id',
            'timezone' => 'required|string',
            'slots' => 'required|array|min:1|max:3',
            'slots.*.date' => 'required',
            'slots.*.startTime' => 'required',
            'slots.*.endTime' => 'required|after:slots.*.startTime',
        ]);

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
            $dateTimeString = $slot['date'] . ' ' . $slot['startTime'];
            $dateTime = Carbon::parse($dateTimeString);
            $formattedDateTime = $dateTime->toDateTimeString();  // "2025-01-15 16:15:00"
            $createdMeetings[] = $formattedDateTime;
        }

        $ra = RequestAvailability::where('code', $request->input('route_id'))
        ->where('client_one_id', $request->input('user_id'))->first();
        if ($ra) {
            $ra->timezone = $timezone;
            $ra->start_date_one = $createdMeetings[0];
            $ra->start_date_two = $createdMeetings[1];
            $ra->start_date_three = $createdMeetings[2];
            $ra->save();
            return response()->json([
                "success" => true,
                "data" => $ra,
                "message" => 'Request sent successfully.'
            ], 200);
        } else {
            return response()->json([
                "success" => false,
                "message" => 'Something went wrong!'
            ], 400);
        }
    }

    public function storeSecondPartyResponse(Request $request)
    {
        // Retrieve the request availability based on the code, client ID, and where chosen_date is null
        $ra = RequestAvailability::where('code', $request->input('route_id'))
            ->where('client_two_id', $request->input('user_id'))
            ->whereNull('chosen_date')
            ->first();
    
        if ($ra) {
            // Get the column name (e.g., start_date_one, start_date_two, etc.)
            $fieldName = $request->input('field_name');
            // Dynamically set the chosen_date to the value of the specified field
            $ra->chosen_date = $ra->$fieldName;
            $ra->save();

            return response()->json([
                "success" => true,
                "data" => $ra,
                "message" => 'Request sent successfully.'
            ], 200);
        } else {
            return response()->json([
                "success" => false,
                "message" => 'Something went wrong, request not found!'
            ], 400);
        }
    }
    

    public function sendMeetingRequestSecondParty(Request $request)
    {
        //// Extract the payload from the request
        $payload = $request->input('payload');

        // Validate the payload data
        $validated = Validator::make($payload, [
            'start_date_one' => 'required|date',
            'start_date_two' => 'required|date',
            'start_date_three' => 'required|date',
            'receiver' => 'required|integer|exists:users,id',
            'admin_message' => 'required|string',
            'code' => 'required|string',
        ]);

        // Handle validation failure
        if ($validated->fails()) {
            return response()->json([
                'success' => false,
                'errors' => $validated->errors(),
            ], 422);
        }

        // Extract validated data
        $data = $validated->validated();

        // Get the admin (sender of the request)
        $admin = Auth::user();

        // Find the receiver
        $receiver = User::findOrFail($data['receiver']);

        $ra = RequestAvailability::where('code', $data['code'])->first();
        $ra->client_two_id = $data['receiver'];
        $ra->save();

        // Process the meeting request (e.g., save to database or send an email)
        // Example: Sending an email notification
        $emailData = [
            'code' => $ra->code,
            'receiver' => $receiver,
            'start_dates' => [
                [
                    'name' => 'start_date_one',
                    'value' => Carbon::parse($data['start_date_one'])->format('F d, Y | H:i A'),
                ],
                [
                    'name' => 'start_date_two',
                    'value' => Carbon::parse($data['start_date_two'])->format('F d, Y | H:i A'),
                ],
                [
                    'name' => 'start_date_three',
                    'value' => Carbon::parse($data['start_date_three'])->format('F d, Y | H:i A'),
                ],
            ],
            'admin_message' => $data['admin_message'],
        ];

        // Send email or perform other actions
        Mail::to($receiver->email)->send(new MeetingRequestSecondParty($emailData));

        // Return a success response
        return response()->json([
            'success' => true,
            'message' => 'Meeting request sent successfully.',
        ]);
    }
}

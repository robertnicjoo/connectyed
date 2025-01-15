<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

use App\Models\User;
use App\Models\Profile;
use App\Models\Meeting;
use App\Models\MeetingReview;

class SurveyController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth:api', ['except' => []]);
    } 

    public function store(Request $request)
    {
        $meeting = Meeting::where('google_meet_id', $request->input('meeting_id'))->first();
    
        if ($meeting) {
            // Check if the client already submitted a review for this meeting
            $existingReview = MeetingReview::where('meeting_id', $meeting->id)
                                            ->where('client_id', $request->input('client_id'))
                                            ->first();
            
            if ($existingReview) {
                return response()->json([
                    'success' => false,
                    'message' => 'You have already submitted a review for this meeting!',
                ], 400); // Changed to 400 for Bad Request, as it's client-side error
            }
    
            if ($meeting->client_id != $request->input('client_id')) {
                return response()->json([
                    'success' => false,
                    'message' => 'You are not allowed to rate this meeting!',
                ], 500);
            } else {
                $review = new MeetingReview;
                $review->meeting_id = $meeting->id;
                $review->client_id = $request->input('client_id');
                $review->complaint_text = $request->input('complaint_text');
                $review->rate = $request->input('rating');
                $review->reviewed_at = now();
                if ($request->input('rating') > 3) {
                    $review->status = 'satisfied';
                } else {
                    $review->status = 'complained';
                }
                $review->save();
                return response()->json([
                    'success' => true,
                    'message' => 'Meeting Review submitted successfully.',
                    'data' => $review,
                ], 200);
            }
        } else {
            return response()->json([
                'success' => false,
                'message' => 'Meeting 404!',
            ], 404); // Changed to 404 as the meeting is not found
        }
    }
    
}

<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

use App\Models\User;
use App\Models\Profile;
use App\Models\Meeting;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Auth;

class AdminController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth:api', ['except' => []]);
    } 

    public function overviews()
    {
        $totalUsers = User::count();
        $totalMatchmakers = User::where('role', 'matchmaker')->count();
        $totalCandidates = User::where('role', 'candidate')->count();
        $totalClients = User::where('role', 'client')->count();
        $totalMeetings = Meeting::count();
        return response()->json([
            'totalUsers' => $totalUsers,
            'totalMatchmakers' => $totalMatchmakers,
            'totalCandidates' => $totalCandidates,
            'totalClients' => $totalClients,
            'totalMeetings' => $totalMeetings,
        ], 200);
    }

    /**
     * Fetch users with role 'candidate' along with their profiles.
     */
    public function getCandidates()
    {
        // Eager load the 'profile' relationship
        $candidates = User::where('role', 'candidate')
                          ->with('profile') // Include profile data
                          ->get();        
                          
        return response()->json([
            "success" => true,
            "data" => $candidates,
            "message" => 'Success'
        ], 200);
    }

    /**
     * Approve a candidate by changing their role to 'matchmaker'.
     */
    public function approveCandidate(Request $request)
    {
        $request->validate([
            'user_id' => 'required|exists:users,id',
        ]);

        $user = User::find($request->user_id);
        $user->role = 'matchmaker';
        $user->save();
        
        return response()->json([
            "success" => true,
            "data" => $user,
            "message" => 'Candidate approved successfully!'
        ], 200);
    }

    /**
     * Fetch users with role 'client' along with their profiles.
     */
    public function getClients()
    {
        $clients = User::with(['profile', 'seeking'])
                       ->where('role', 'client')
                       ->get();        

        return response()->json([
            "success" => true,
            "data" => $clients,
            "message" => 'Success'
        ], 200);
    }
}

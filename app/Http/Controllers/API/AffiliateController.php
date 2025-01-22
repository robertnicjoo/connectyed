<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Affiliate;
use App\Models\User;

class AffiliateController extends Controller
{
    /**
     * Get a list of users with the 'matchmaker' role.
     */
    public function getMatchmakers()
    {
        $matchmakers = User::where('role', 'matchmaker')->get();
        return response()->json([
            'success' => true,
            'data' => $matchmakers
        ], 200);
    }

    /**
     * Assign a code to a matchmaker.
     */
    public function assignCode(Request $request)
    {
        $request->validate([
            'user_id' => 'required|exists:users,id',
            'code' => 'required|unique:affiliates,code',
            'percentage' => 'required|numeric|min:0|max:100',
            'start_date' => 'required|date',
            'expire_date' => 'required|date|after_or_equal:start_date',
        ]);

        $affiliate = Affiliate::create([
            'user_id' => $request->user_id,
            'code' => $request->code,
            'percentage' => $request->percentage,
            'start_date' => $request->start_date,
            'expire_date' => $request->expire_date,
        ]);

        return response()->json([
            'success' => true,
            'message' => 'Code assigned successfully',
            'data' => $affiliate
        ], 201);
    }

    /**
     * List all affiliate codes.
     */
    public function index()
    {
        $affiliates = Affiliate::with(['user'])->get();
        return response()->json([
            'success' => true,
            'data' => $affiliates
        ], 200);
    }

    /**
     * Update an affiliate code.
     */
    public function update(Request $request, $id)
    {
        $request->validate([
            'code' => 'sometimes|required|unique:affiliates,code,' . $id,
            'percentage' => 'sometimes|numeric|min:0|max:100',
            'start_date' => 'sometimes|date',
            'expire_date' => 'sometimes|date|after_or_equal:start_date',
        ]);

        $affiliate = Affiliate::findOrFail($id);
        $affiliate->update($request->all());

        return response()->json([
            'success' => true,
            'message' => 'Affiliate updated successfully',
            'data' => $affiliate
        ], 200);
    }

    /**
     * Delete an affiliate code.
     */
    public function destroy($id)
    {
        $affiliate = Affiliate::findOrFail($id);
        $affiliate->delete();

        return response()->json([
            'success' => true,
            'message' => 'Affiliate deleted successfully'
        ], 200);
    }
}

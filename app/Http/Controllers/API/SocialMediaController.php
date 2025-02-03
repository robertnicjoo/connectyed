<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\SocialMedia;
use Illuminate\Support\Facades\Auth;

class SocialMediaController extends Controller
{
    // Show all social media links for the authenticated user
    public function index()
    {
        $user = Auth::user();
        return response()->json([
            "success" => true,
            "data" => $user->socialMedia,
            "message" => 'Social media list is ready.'
        ], 200);
    }

    // Store a new social media link
    public function store(Request $request)
    {
        $request->validate([
            'platform' => 'required|string|max:255',
            'url' => 'required|url',
        ]);

        $socialMedia = Auth::user()->socialMedia()->create([
            'platform' => $request->platform,
            'url' => $request->url,
        ]);

        return response()->json([
            "success" => true,
            "data" => $socialMedia,
            "message" => 'Social media link added.'
        ], 200);
    }

    // Show a specific social media link
    public function show($id)
    {
        $socialMedia = Auth::user()->socialMedia()->findOrFail($id);

        return response()->json([
            "success" => true,
            "data" => $socialMedia,
            "message" => 'Social media data is ready.'
        ], 200);
    }

    // Update a social media link
    public function update(Request $request, $id)
    {
        $request->validate([
            'platform' => 'sometimes|string|max:255',
            'url' => 'sometimes|url',
        ]);

        $socialMedia = Auth::user()->socialMedia()->findOrFail($id);
        $socialMedia->update($request->only(['platform', 'url']));

        return response()->json([
            "success" => true,
            "data" => $socialMedia,
            "message" => 'Social media data updated.'
        ], 200);
    }

    // Delete a social media link
    public function destroy($id)
    {
        $socialMedia = Auth::user()->socialMedia()->findOrFail($id);
        $socialMedia->delete();

        return response()->json([
            "success" => true,
            "data" => null,
            "message" => 'Social media link deleted successfully.'
        ], 200);
    }
}

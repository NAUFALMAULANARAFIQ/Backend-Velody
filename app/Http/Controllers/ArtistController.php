<?php

namespace App\Http\Controllers;

use App\Models\Artist;
use Illuminate\Http\Request;

class ArtistController extends Controller
{
    public function index()
    {
        return response()->json(Artist::all());
    }

    public function show($id)
    {
        $artist = Artist::with(['albums', 'songs'])->find($id);

        if (!$artist) {
            return response()->json(['message' => 'Artist not found'], 404);
        }

        return response()->json($artist);
    }
}

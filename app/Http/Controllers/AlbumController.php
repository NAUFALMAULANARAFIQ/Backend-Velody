<?php

namespace App\Http\Controllers;

use App\Models\Album;
use Illuminate\Http\Request;

class AlbumController extends Controller
{
    public function index()
    {
        return response()->json(Album::with('artist')->get());
    }

    public function show($id)
    {
        $album = Album::with(['artist', 'songs'])->find($id);

        if (!$album) {
            return response()->json(['message' => 'Album not found'], 404);
        }

        return response()->json($album);
    }
}

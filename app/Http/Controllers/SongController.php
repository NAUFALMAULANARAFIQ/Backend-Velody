<?php

namespace App\Http\Controllers;

use App\Models\Song;
use Illuminate\Http\Request;

class SongController extends Controller
{
    public function index()
    {
    $songs = Song::with(['artist','album'])->get()->map(function($song) {
        $song->file_url = asset('song/' . basename($song->file_url));
        $song->cover_image = asset('storage/' . $song->album->cover_image);

        return $song;
    });

    return response()->json($songs);
    }

    public function show($id)
    {
        $song = Song::with(['artist', 'album'])->find($id);

        if (!$song) {
            return response()->json(['message' => 'Lagu tidak ditemukan'], 404);
        }

        return response()->json($song);
    }
}

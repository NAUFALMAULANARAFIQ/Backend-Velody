<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\History;

class HistoryController extends Controller
{
    public function index(Request $request)
    {
        $userId = $request->user()->id_users;

        $histories = History::with(['song.artist'])
            ->where('id_users', $userId)
            ->orderBy('created_at', 'desc')
            ->limit(20)
            ->get();

        $formatted = $histories->map(function ($item) {
            $song = $item->song;

            if (!$song) return null;

            return [
                'id'          => $song->id_songs,
                'title'       => $song->title,
                'artist'      => $song->artist ? $song->artist->name : 'Unknown',
                'cover_image' => $song->cover_image,
                'file_url'    => $song->file_url,
                'duration'    => $song->duration,
            ];
        })->filter()->values();

        return response()->json($formatted);
    }

    public function store(Request $request)
    {
        $request->validate([
            'id_songs' => 'required|integer',
        ]);

        $userId = $request->user()->id_users;
        $songId = $request->id_songs;

        History::where('id_users', $userId)
            ->where('id_songs', $songId)
            ->delete();

        History::create([
            'id_users' => $userId,
            'id_songs' => $songId,
        ]);

        return response()->json([
            'success' => true,
            'message' => 'History saved'
        ]);
    }
}

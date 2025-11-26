<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class FavoriteController extends Controller
{
    public function toggle(Request $request)
    {
        $request->validate([
            'id_songs' => 'required|integer',
        ]);

        $userId = $request->user()->id_users;
        $songId = $request->id_songs;
        $exists = DB::table('favorites')
            ->where('id_users', $userId)
            ->where('id_songs', $songId)
            ->first();

        if ($exists) {
            DB::table('favorites')
                ->where('id_users', $userId)
                ->where('id_songs', $songId)
                ->delete();

            return response()->json(['status' => 'removed', 'message' => 'Dihapus dari favorit']);
        } else {
            DB::table('favorites')->insert([
                'id_users' => $userId,
                'id_songs' => $songId,
                'created_at' => now(),
                'updated_at' => now(),
            ]);

            return response()->json(['status' => 'added', 'message' => 'Ditambahkan ke favorit']);
        }
    }

    public function index(Request $request)
    {
        $userId = $request->user()->id_users;

        $favorites = DB::table('favorites')
            ->join('songs', 'favorites.id_songs', '=', 'songs.id_songs')
            ->join('artists', 'songs.id_artists', '=', 'artists.id_artists')
            ->join('albums', 'songs.id_albums', '=', 'albums.id_albums')
            ->select(
                'songs.id_songs as id',
                'songs.title',
                'albums.cover_image',
                'songs.file_url',
                'songs.duration',
                'artists.name as artist_name'
            )
            ->where('favorites.id_users', $userId)
            ->orderBy('favorites.created_at', 'desc')
            ->get();
        $formatted = $favorites->map(function ($song) {
            return [
                'id'          => $song->id,
                'title'       => $song->title,
                'artist'      => $song->artist_name,
                'cover_image' => $song->cover_image,
                'file_url'    => $song->file_url,
                'duration'    => $song->duration,
            ];
        });

        return response()->json($formatted);
    }
}

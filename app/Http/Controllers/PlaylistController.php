<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Playlist;
use Illuminate\Support\Facades\DB;

class PlaylistController extends Controller
{
    public function index(Request $request)
    {
        $userId = $request->user()->id_users;

        $playlists = Playlist::where('id_users', $userId)
            ->withCount('songs')
            ->orderBy('created_at', 'desc')
            ->get();

        return response()->json($playlists);
    }

    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'description' => ''

        ]);

        $playlist = Playlist::create([
            'id_users' => $request->user()->id_users,
            'name' => $request->name,
            'description' => ''
        ]);

        return response()->json([
            'success' => true,
            'message' => 'Playlist created',
            'data' => $playlist
        ]);
    }

    public function show($id)
    {
        $playlist = DB::table('playlists')
            ->where('id_playlists', $id)
            ->first();

        if (!$playlist) {
            return response()->json(['message' => 'Playlist not found'], 404);
        }

        $songs = DB::table('playlists_song')
            ->join('songs', 'playlists_song.id_songs', '=', 'songs.id_songs')
            ->join('artists', 'songs.id_artists', '=', 'artists.id_artists')
            ->where('playlists_song.id_playlists', $id)
            ->select(
                'songs.id_songs as id',
                'songs.title',
                'songs.cover_image',
                'songs.file_url',
                'songs.duration',
                'artists.name as artist_name'
            )
            ->get();

        $formattedSongs = $songs->map(function ($song) {
            return [
                'id'          => $song->id,
                'title'       => $song->title,
                'artist'      => $song->artist_name ?? 'Unknown Artist',
                'cover_image' => $song->cover_image,
                'file_url'    => $song->file_url,
                'duration'    => $song->duration ?? 0,
            ];
        });
        
        return response()->json([
            'id_playlists' => $playlist->id_playlists,
            'name'         => $playlist->name,
            'description'  => $playlist->description ?? '',
            'songs'        => $formattedSongs
        ]);
    }

    public function addSong(Request $request, $playlistId)
    {
        $request->validate([
            'id_songs' => 'required|integer|exists:songs,id_songs',
        ]);

        $playlist = Playlist::where('id_playlists', $playlistId)
            ->where('id_users', $request->user()->id_users)
            ->first();

        if (!$playlist) {
            return response()->json(['message' => 'Playlist not found or unauthorized'], 404);
        }

        if ($playlist->songs()->where('songs.id_songs', $request->id_songs)->exists()) {
            return response()->json(['message' => 'Song already in playlist'], 409);
        }

        $playlist->songs()->attach($request->id_songs);

        return response()->json([
            'success' => true,
            'message' => 'Song added to playlist'
        ]);
    }

    public function getSongs($id)
    {
        $songs = DB::table('playlists_song')
            ->join('songs', 'playlists_song.id_songs', '=', 'songs.id_songs')
            ->join('artists', 'songs.id_artists', '=', 'artists.id_artists')
            ->join('albums', 'songs.id_albums', '=', 'albums.id_albums')
            ->where('playlists_song.id_playlists', $id)
            ->select(
                'songs.id_songs as id',
                'songs.title',
                'albums.cover_image',
                'songs.file_url',
                'songs.duration',
                'artists.name as artist_name'
            )
            ->get();

        $formattedSongs = $songs->map(function ($song) {
            return [
                'id'          => $song->id,
                'title'       => $song->title,
                'artist'      => $song->artist_name ?? 'Unknown',
                'cover_image' => $song->cover_image,
                'file_url'    => $song->file_url,
                'duration'    => $song->duration ?? 0,
            ];
        });

        return response()->json($formattedSongs);
    }
}

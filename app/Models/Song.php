<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Song extends Model
{
    use HasFactory;
    protected $primaryKey = 'id_songs';

    protected $guarded = [];

    public function artist()
    {
        return $this->belongsTo(Artist::class, 'id_artists');
    }
    public function album()
    {
        return $this->belongsTo(Album::class, 'id_albums');
    }
    public function playlists() {
        return $this->belongsToMany(Playlist::class, 'playlists_song', 'id_songs', 'id_playlists');
    }
}

<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Playlist extends Model
{
    use HasFactory;
    protected $primaryKey = 'id_playlists';

    protected $guarded = [];

    public function user()
    {
        return $this->belongsTo(User::class, 'id_users');
    }
    public function songs()
    {
        return $this->belongsToMany(
            Song::class,
            'playlists_song',
            'id_playlists',
            'id_songs'
        );
    }
}

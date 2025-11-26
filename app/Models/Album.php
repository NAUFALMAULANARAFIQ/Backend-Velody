<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Album extends Model
{
    protected $guarded = ['id'];
    protected $primaryKey = 'id_albums';

    public function artist() {
        return $this->belongsTo(Artist::class, 'id_artists');
    }

    public function songs() {
        return $this->hasMany(Song::class, 'id_albums');
    }
}

<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Artist extends Model
{
    protected $guarded = [];
    protected $primaryKey = 'id_artists';

    public function albums() {
        return $this->hasMany(Album::class, 'id_artists');
    }

    public function songs() {
        return $this->hasMany(Song::class, 'id_artists');
    }
}

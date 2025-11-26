<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class History extends Model
{
    use HasFactory;
    protected $table = 'histories';
    protected $primaryKey = 'id_histories';

    protected $guarded = [];

    public function user()
    {
        return $this->belongsTo(User::class, 'id_users');
    }

    public function song()
    {
        return $this->belongsTo(Song::class, 'id_songs');
    }
}

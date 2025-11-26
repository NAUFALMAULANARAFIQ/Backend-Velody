<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class ArtistSeeder extends Seeder
{
    public function run()
    {
        $artists = [
            "LANY",
            "Rex Orange County",
            "Reality Club",
            "The 1975",
            "Clairo",
            "Lauv",
            "Daniel Caesar",
            "Keshi",
            "Mazzy Star",
            "The Marias",
            "wave to earth",
            "Frank Ocean",
            "Cigarettes After Sex",
            "Joji",
            "Thomas Day",
            "Phoebe Bridgers",
            "Coldplay",
            "Lizzy McAlpine",
            "Lord Huron",
            "Paramore",
            "NERIAH",
            "The Neighbourhood",
        ];


        foreach ($artists as $artist) {
            DB::table('artists')->insert([

                'name'       => $artist,
                'bio'        => "This is the official artist profile of {$artist}.",
                'image'      => "artists/default.png",
                'created_at' => now(),
                'updated_at' => now(),
            ]);
        }
    }
}

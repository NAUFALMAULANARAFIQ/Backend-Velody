<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class AlbumSeeder extends Seeder
{
    public function run()
    {
        $albums = [
            ['title' => "mama's boy (deluxe)", 'artist' => "LANY"],
            ['title' => "Apricot Princess", 'artist' => "Rex Orange County"],
            ['title' => "What Do You Really Know?", 'artist' => "Reality Club"],
            ['title' => "Being Funny In a Foreign Language", 'artist' => "The 1975"],
            ['title' => "~how i'm feeling~", 'artist' => "Lauv"],
            ['title' => "Son Of Spergy", 'artist' => "Daniel Caesar"],
            ['title' => "Requiem", 'artist' => "keshi"],
            ['title' => "Immunity", 'artist' => "Clairo"],
            ['title' => "Paramore", 'artist' => "Paramore"],
            ['title' => "Blonde", 'artist' => "Frank Ocean"],
            ['title' => "Strange Trails", 'artist' => "Lord Huron"],
            ['title' => "So Tonight That I Might See", 'artist' => "Mazzy Star"],
        ];

        foreach ($albums as $item) {
            $artist = DB::table('artists')->where('name', $item['artist'])->first();

            if (!$artist) {
                $artistId = DB::table('artists')->insertGetId([
                    'name'       => $item['artist'],
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);
            } else {
                $artistId = $artist->id_artists;
            }
            DB::table('albums')->updateOrInsert(
                [
                    'title'      => $item['title'],
                    'id_artists' => $artistId,
                ],
                [
                    'cover_image'  => "albums/default.png",
                    'release_date' => "2020-01-01",
                    'created_at'   => now(),
                    'updated_at'   => now(),
                ]
            );
        }
    }
}

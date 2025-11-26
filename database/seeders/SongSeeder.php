<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class SongSeeder extends Seeder
{
    public function run()
    {
        $songArtists = [
        "what i wish just one person would say to me" => "LANY",
        "4 Seasons" => "Rex Orange County",
        "A Sorrowful Reunion" => "Reality Club",
        "About You" => "The 1975",
        "Act My Age" => "LANY",
        "Always" => "Rex Orange County",
        "Bags" => "Clairo",
        "Canada" => "Lauv",
        "Emily’s Song" => "Daniel Caesar",
        "Euphoria" => "Keshi",
        "Fade Into You" => "Mazzy Star",
        "Heavy" => "The Marias",
        "Hericane" => "LANY",
        "homesick" => "wave to earth",
        "I Couldn't Be More In Love" => "The 1975",
        "Ivy" => "Frank Ocean",
        "K.." => "Cigarettes After Sex",
        "Let Me Go" => "Daniel Caesar",
        "Let Me Know" => "LANY",
        "Like You Do" => "Joji",
        "Loose" => "Daniel Caesar",
        "lost myself 4 u" => "Thomas Day",
        "Never Not" => "Lauv",
        "No One Noticed (Extended English)" => "The Marias",
        "Pluto Projector" => "Rex Orange County",
        "Scott Street" => "Phoebe Bridgers",
        "seasons" => "wave to earth",
        "SLOW DANCING IN THE DARK" => "Joji",
        "Sparks" => "Coldplay",
        "Staying" => "Lizzy McAlpine",
        "Streetcar" => "Daniel Caesar",
        "Tampa" => "LANY",
        "The Night We Met" => "Lord Huron",
        "The Only Exception" => "Paramore",
        "Unfinished Business" => "NERIAH",
        "Valentine's Day" => "LANY",
        "Valentines" => "The Neighbourhood",
        "Waiting Room" => "Phoebe Bridgers",
        "White Ferrari" => "Frank Ocean",
        "Who Knows" => "Daniel Caesar",
    ];


        $genres = ['Pop', 'Indie Pop', 'Alternative', 'R&B', 'Soul', 'Rock'];

        foreach ($songArtists as $title => $artistName) {
            $artist = DB::table('artists')->where('name', $artistName)->first();
            if (!$artist) {
                continue;
            }

            $album = DB::table('albums')->where('id_artists', $artist->id_artists)->first();
            if (!$album) {
                continue;
            }

           $host = env('APP_HOST', 'http://127.0.0.1:8000');

            DB::table('songs')->insert([
                'id_artists' => $artist->id_artists,
                'id_albums'  => $album->id_albums,
                'title'      => $title,
                'genre'      => $genres[array_rand($genres)],
                'file_url'   => $host . '/song/' . rawurlencode($title) . '.mp3',
                'duration'   => rand(120, 320),
                'created_at' => now(),
                'updated_at' => now(),
            ]);
        }
    }
}

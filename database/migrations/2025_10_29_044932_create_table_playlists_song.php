<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('playlists_song', function (Blueprint $table) {
            $table->id('id_playlists')->primary();
            $table->unsignedBigInteger('id_songs');
            $table->timestamps();

            $table->foreign('id_songs')->references('id_songs')->on('songs')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('playlists_songs');
    }
};

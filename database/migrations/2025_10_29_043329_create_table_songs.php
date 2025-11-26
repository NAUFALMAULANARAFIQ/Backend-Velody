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
        Schema::create('songs', function (Blueprint $table) {
            $table->id('id_songs')->primary();
            $table->unsignedBigInteger('id_artists');
            $table->unsignedBigInteger('id_albums');
            $table->integer('duration');
            $table->string('file_url', length:500);
            $table->string('genre', length:255);
            $table->string('title', length:50);
            $table->timestamps();

            $table->foreign('id_artists')->references('id_artists')->on('artists')->onDelete('cascade');
            $table->foreign('id_albums')->references('id_albums')->on('albums')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('songs');
    }
};

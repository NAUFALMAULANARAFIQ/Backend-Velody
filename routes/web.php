<?php

use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Response;

Route::get('/', function () {
    return view('welcome');
});



Route::get('/song/{filename}', function ($filename) {
    $path = storage_path('app/public/songs/' . $filename);

    if (!file_exists($path)) {
        abort(404);
    }

    return Response::file($path, [
        'Access-Control-Allow-Origin' => '*',
        'Content-Type' => 'audio/mpeg'
    ]);
});
Route::get('/cover/{filename}', function ($filename) {
    $path = storage_path('app/public/album-cover/' . $filename);

    if (!file_exists($path)) {
        abort(404);
    }

    return Response::file($path, [
        'Access-Control-Allow-Origin' => '*',
        'Content-Type' => 'webp'
    ]);
});



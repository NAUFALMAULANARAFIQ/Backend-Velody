<?php

namespace App\Http\Controllers\API\auth;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;

class AuthController extends Controller
{
    public function register(Request $request)
    {
        $request->validate([
            'username'     => 'required|string',
            'email'    => 'required|email|unique:users',
            'password' => 'required|min:6'
        ]);

        $user = User::create([
            'username'     => $request->username,
            'email'    => $request->email,
            'password' => Hash::make($request->password),
        ]);

        $token = $user->createToken('auth_token')->plainTextToken;

        return response()->json([
            'success' => true,
            'message' => 'Register berhasil',
            'token'   => $token,
            'user'    => $user,
        ]);
    }

    public function login(Request $request)
    {
        $request->validate([
            'password' => 'required',
            'email'    => 'nullable|email',
            'username' => 'nullable|string',
        ]);

        $loginField = $request->email ? 'email' : 'username';
        $loginValue = $request->email ?? $request->username;

        if (!Auth::attempt([$loginField => $loginValue, 'password' => $request->password])) {
            return response()->json([
                'success' => false,
                'message' => 'Username/Email atau password salah',
            ], 401);
        }

        $user = User::where($loginField, $loginValue)->first();
        $token = $user->createToken('auth_token')->plainTextToken;

        return response()->json([
            'success' => true,
            'message' => 'Login berhasil',
            'token'   => $token,
            'user'    => $user,
        ]);
    }

    public function logout(Request $request)
    {
        $request->user()->tokens()->delete();

        return response()->json([
            'success' => true,
            'message' => 'Logout berhasil',
        ]);
    }

    public function profile(Request $request)
    {
        return response()->json([
            'success' => true,
            'user'    => $request->user(),
        ]);
    }
}

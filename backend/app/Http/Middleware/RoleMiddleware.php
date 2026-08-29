<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class RoleMiddleware
{
    public function handle(Request $request, Closure $next, ...$roles): Response
    {
        $user = $request->user();

        // // 1. فحص هل المستخدم مسجل دخول أصلاً؟
        if (!$user) {
            return response()->json(['message' => 'Unauthenticated.'], 401);
        }

        // // 2. فحص هل دور المستخدم موجود ضمن الأدوار المسموحة؟
        if (!in_array($user->role, $roles)) {
            return response()->json([
                'status' => 'error',
                'message' => 'ليس لديك صلاحية الوصول لهذا القسم.'
            ], 403);
        }

        return $next($request);
    }
}
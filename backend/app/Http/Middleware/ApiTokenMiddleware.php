<?php

namespace App\Http\Middleware;

use App\Models\User;
use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Symfony\Component\HttpFoundation\Response;

class ApiTokenMiddleware
{
    public function handle(Request $request, Closure $next): Response
    {
        // // 1. استخراج التوكن من الهيدر (Bearer Token)
        $token = $request->bearerToken();

        // // استخدام استراتيجية Early Return للحفاظ على نظافة الكود
        if (!$token) {
            return response()->json([
                'status' => 'error',
                'message' => 'غير مصرح لك بالدخول، يرجى إرسال التوكن.',
            ], 401);
        }

        // // 2. البحث عن المستخدم المرتبط بالتوكن (بعد تشفيره للمقارنة)
        $user = User::where('api_token', hash('sha256', $token))->first();

        if (!$user) {
            return response()->json([
                'status' => 'error',
                'message' => 'التوكن غير صحيح أو منتهي الصلاحية.',
            ], 401);
        }

        // // 3. ربط المستخدم الحالي بالطلب (Auth)
        Auth::setUser($user);
        $request->setUserResolver(fn () => $user);

        return $next($request);
    }
}
<?php

namespace App\Http\Controllers\Api\User\Auth;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\User; 
use Illuminate\Support\Facades\Http; 
use Illuminate\Support\Facades\Hash; 
use Illuminate\Support\Str;
use App\Models\OtpCode;
use App\Services\SmsService;

class AuthController extends Controller
{
    public function sendOtp(Request $request, SmsService $smsService)
    {
        $request->validate(['phone' => 'required']);

        $code = rand(100000, 999999);

        // 1. حفظ أو تحديث الرمز في قاعدة البيانات
        OtpCode::updateOrCreate(
            ['phone' => $request->phone],
            ['code' => $code, 'expires_at' => now()->addMinutes(5)]
        );

        // 2. إرسال الرسالة وفحص النتيجة
        $smsSent = $smsService->send($request->phone, "رمز التحقق الخاص بك هو: {$code}");

        if (!$smsSent) {
            return response()->json([
                'status' => 'failure',
                'message' => 'فشل إرسال رمز التحقق، يرجى التأكد من الرقم أو المحاولة لاحقاً',
            ], 400);
        }

        return response()->json([
            'status' => 'success',
            'message' => 'تم إرسال رمز التحقق بنجاح',
            'debug_code' => config('app.debug') ? $code : null,
        ]);
    }

    public function verifyOtp(Request $request)
    {
        $request->validate([
            'phone' => 'required',
            'code'  => 'required',
        ]);

        // 1. البحث عن الرمز
        $otpRecord = OtpCode::where('phone', $request->phone)
                            ->where('code', $request->code)
                            ->first();

        // 2. الفحص والتأكد من الصلاحية
        if (!$otpRecord || now()->greaterThan($otpRecord->expires_at)) {
            return response()->json([
                'status'  => 'error',
                'message' => 'رمز التحقق غير صحيح أو منتهي الصلاحية',
            ], 400);
        }

        // 3. حذف الرمز فوراً
        $otpRecord->delete();

        // 4. (اختياري) إنشاء أو جلب المستخدم وإصدار التوكن
        $user = User::firstOrCreate(
            ['phone' => $request->phone],
            [
                'name' => 'User ' . Str::random(5),
                'password' => Hash::make(Str::random(16)),
                'approve' => true,
                'role' => 'user'
            ]
        );

        $user->tokens()->delete();
        $token = $user->createToken('API Token')->plainTextToken;

        return response()->json([
            'status'  => 'success',
            'message' => 'تم التحقق بنجاح',
            'token'   => $token,
            'user'    => $user,
        ]);
    }



    public function googleLogin(Request $request)
    {
        // 1. التحقق من وجود id_token القادم من Flutter
        $request->validate([
            // رمز التوكن مطلوب
            'id_token' => 'required|string', 
        ]);

        // 2. إرسال طلب إلى سيرفرات قوقل للتحقق من صحة التوكن
        $googleResponse = Http::get("https://oauth2.googleapis.com/tokeninfo", [
            // إرسال الـ id_token كباراميتر
            'id_token' => $request->id_token, 
        ]);

        // 3. التأكد من نجاح الاستجابة واحتوائها على البريد الإلكتروني
        if ($googleResponse->failed() || !isset($googleResponse->json()['email'])) {
            // إرجاع خطأ أمني إذا كان التوكن مزيفاً أو منتهي الصلاحية
            return response()->json([ 
                // حالة الفشل
                'status' => 'fail', 
                // رسالة الخطأ
                'message' => 'رمز id_token غير صالح أو منتهي الصلاحية', 
            ], 401);
        }

        // 4. استخراج بيانات المستخدم الموثقة رسمياً من قوقل
        $googleData = $googleResponse->json(); 
        // البريد الموثق من قوقل
        $email = $googleData['email']; 
        // الاسم المسجل في قوقل
        $name = $googleData['name'] ?? 'Google User'; 

        // 5. البحث عن المستخدم في قاعدة البيانات عبر البريد الموثق
        $user = User::where('email', $email)->first(); 

        // 6. إنشاء حساب جديد إذا لم يكن مسجلاً
        if (!$user) { 
            // إنشاء المستخدم وتفعيله تلقائياً
            $user = User::create([ 
                // الاسم المستخرج من قوقل
                'name'     => $name, 
                // البريد الإلكتروني الموثق
                'email'    => $email, 
                // كلمة مرور عشوائية ومشفرة
                'password' => Hash::make(Str::random(16)), 
                // رقم الهاتف غير متوفر
                'phone'    => null, 
                // تفعيل الحساب فوراً
                'approve'  => true, 
                // تحديد دور المستخدم
                'role'     => 'user', 
            ]);
        } else {
            // 7. تفعيل الحساب تلقائياً إذا كان موجوداً وغير مفعل
            if (!$user->approve) { 
                // تحديث حالة التفعيل
                $user->update(['approve' => true]); 
            }
        }

        // 8. حذف التوكنات القديمة لحماية الجلسة
        $user->tokens()->delete(); 

        // 9. إنشاء توكن جديد للمستخدم عبر Sanctum
        $token = $user->createToken('API Token')->plainTextToken; 

        // 10. إرجاع الرد النهائي بنجاح
        return response()->json([ 
            // حالة العملية
            "status" => "success", 
            // التوكن الجديد
            "token"  => $token, 
            // كائن المستخدم
            "user"   => $user, 
            // بيانات المستخدم للتوافق مع فلاتر
            "data"   => $user 
        ]);
    }

    

    // --- [ 7. تسجيل الخروج - Logout ] ---
    public function logout(Request $request)
    {
        $user = $request->user();

        // 1. التحقق من وجود الحساب
        if (!$user) {
            return response()->json(['status' => 'failure', 'errorKey' => 'userNotFound']);
        }

        // 2. حذف التوكنات القديمة 
        $user->tokens()->delete(); 

        return response()->json([
            "status" => "success"
        ]); 
    }
}
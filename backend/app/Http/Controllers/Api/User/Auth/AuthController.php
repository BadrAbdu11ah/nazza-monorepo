<?php

namespace App\Http\Controllers\Api\User\Auth;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\User; 
use Illuminate\Support\Facades\Http; 
use Illuminate\Support\Facades\Hash; 
use Illuminate\Support\Str;

class AuthController extends Controller
{
    // --- [ 1. تسجيل الدخول - Login ] ---
    public function login(Request $request)
    {
        $request->validate([
            'email'    => 'required|email', 
            'password' => 'required'
        ]);

        $user = User::where('email', $request->email)->first();

        // 1. التحقق من وجود الحساب
        if (!$user) {
            return response()->json(['status' => 'failure', 'errorKey' => 'emailNotFound']);
        }

        // 2. التحقق من تفعيل الحساب 
        if (!$user->approve) { 
            return response()->json(['status' => 'failure', 'errorKey' => 'accountNotActive']);
        }

        // 3. التحقق من صحة كلمة المرور 
        if (!Hash::check($request->password, $user->password)) {
            return response()->json(['status' => 'failure', 'errorKey' => 'passwordIncorrect']);
        }

        // 4. حذف التوكنات القديمة وتوليد توكن جديد باستخدام Sanctum
        $user->tokens()->delete(); 
        $token = $user->createToken('API Token')->plainTextToken;

        return response()->json([
            "status" => "success",
            "token"  => $token, 
            "user"   => $user
        ]); 
    }

    // --- [ 2. تسجيل مستخدم جديد - Signup ] ---
    public function signup(Request $request)
    {
        $request->validate([
            'username' => 'required|string|max:255',
            'email'    => 'required|email',
            'password' => 'required|min:8',
            'phone'    => 'required',
        ]);

        // 1. التحقق من تكرار الإيميل 
        if (User::where('email', $request->email)->exists()) {
            return response()->json(["status" => "failure", "errorKey" => "emailOrPhoneExists"]);
        }

        // 2. إنشاء المستخدم الجديد 
        $verifyCode = rand(10000, 99999);
        $user = User::create([
            'name'        => $request->username,
            'email'       => $request->email,
            'password'    => $request->password,
            'phone'       => $request->phone,
            'verify_code' => $verifyCode,        
            'approve'     => false,              
            'role'        => 'user',
        ]);

        if (!$user) {
            return response()->json(["status" => "failure"], 500);
        }

        return response()->json([
            "status" => "success", 
            "data"   => ["email" => $user->email]
        ]);
    }

    // --- [ 3. فحص الإيميل لنسيان كلمة المرور - Forget Password ] ---
    public function checkEmail(Request $request)
    {
        $request->validate(['email' => 'required|email']);

        $user = User::where('email', $request->email)->first(); 

        if (!$user) {
            return response()->json(["status" => "failure", "errorKey" => "emailNotFound"]); 
        }

        $newCode = rand(10000, 99999);
        $user->update(['verify_code' => $newCode]);

        return response()->json([
            "status"     => "success",
            "data"       => $user,
            "verifycode" => $newCode 
        ]);
    }

    // --- [ 4. التحقق من رمز التفعيل - Verify Code ] ---
    public function verifyCode(Request $request)
    {
        $request->validate([
            'email'      => 'required|email', 
            'verifycode' => 'required'
        ]);

        $user = User::where('email', $request->email)
                    ->where('verify_code', $request->verifycode)
                    ->first(); 

        if (!$user) {
            return response()->json(["status" => "failure", "errorKey" => "verificationCodeIncorrect"]);
        }

        // تحديث الحالة وتصفير كود التحقق
        $user->update([
            'approve'     => true, 
            'verify_code' => null 
        ]);

        // توليد التوكن مباشرة بعد التفعيل الناجح للدخول الفوري
        $token = $user->createToken('API Token')->plainTextToken;

        return response()->json([
            "status" => "success",
            "token"  => $token, 
            "data"   => $user
        ]); 
    }

    // --- [ 5. إعادة تعيين كلمة المرور - Reset Password ] ---
    public function resetPassword(Request $request)
    {
        $request->validate([
            'email'    => 'required|email', 
            'password' => 'required|min:8'
        ]);

        $user = User::where("email", $request->email)->first();

        if (!$user) {
            return response()->json(["status" => "failure", "errorKey" => "emailNotFound"]);
        }

        $user->update(["password" => $request->password]);

        return response()->json(["status" => "success"]);
    }

    // --- [ 6. تحديث وحذف التوكنات القديمة - Reset Tokens ] ---
    public function deleteOldTokens(Request $request)
    {
        $request->validate(['email' => 'required|email']);

        $user = User::where('email', $request->email)->first();

        if (!$user) {
            return response()->json(['status' => 'failure', 'errorKey' => 'emailNotFound']);
        }

        // حذف التوكنات القديمة وتوليد واحد نظيف
        $user->tokens()->delete(); 
        $token = $user->createToken('API Token')->plainTextToken;

        return response()->json([
            'status' => 'success',
            'token'  => $token,
            'user'   => $user
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

    // --- [ 8. تسجيل الدخول عبر قوقل - Google Login ] ---
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
}
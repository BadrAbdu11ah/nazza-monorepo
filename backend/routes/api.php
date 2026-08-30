<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\User\Auth\AuthController;
use App\Http\Controllers\Api\User\HomeController;
use App\Http\Controllers\Api\User\ItemController;
use App\Http\Controllers\Api\User\FavoriteController;
use App\Http\Controllers\Api\User\CartController; 
use App\Http\Controllers\Api\User\AddressController;
use App\Http\Controllers\Api\User\CouponController;
use App\Http\Controllers\Api\User\OrderController;
use App\Http\Controllers\Api\User\NotificationController;

use App\Http\Controllers\Api\Admin\Auth\AdminAuthController;
use App\Http\Controllers\Api\Admin\Order\AdminOrderController;
use App\Http\Controllers\Api\Admin\Categories\AdminCategoriesController;
use App\Http\Controllers\Api\Admin\Items\AdminItemsController;

use App\Http\Controllers\Api\Delivery\Auth\DeliveryAuthController;
use App\Http\Controllers\Api\Delivery\Order\DeliveryOrderController;

// -----------------------------------------------------------
// 1. مسارات المصادقة العامة (Auth)
// -----------------------------------------------------------
Route::prefix('user')->group(function () {
    Route::controller(AuthController::class)->group(function () {
        Route::post('/google-login', 'googleLogin');
        Route::post('/send-otp', 'sendOtp');
        Route::post('/verify-otp', 'verifyOtp');
        Route::post('/login', 'login');
        Route::post('/signup', 'signup');
        Route::post('/auth/verify-code', 'verifyCode'); 
        Route::post('/logout', 'logout');
        // مسارات استعادة كلمة المرور
        Route::prefix('forgetpassword')->group(function () {
            Route::post('/checkemail',          'checkEmail');
            Route::post('/verifycode',          'verifyCode');
            Route::post('/reset-password',      'resetPassword');
            Route::post('/reset-verify-code',   'resetVerifyCode'); 
        });
    });
});

// -----------------------------------------------------------
// 2. المسارات المحمية (تتطلب توكن Sanctum)
// -----------------------------------------------------------
Route::middleware('auth:sanctum')->group(function () {
    Route::prefix('user')->group(function () {
        // الصفحة الرئيسية
        Route::controller(HomeController::class)->group(function () {
            Route::get('/home', 'index');
            Route::get('/offers', 'offers');
            Route::post('/search', 'search');
        });
    });
});


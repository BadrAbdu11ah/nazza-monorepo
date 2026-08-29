<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\User>
 */
class UserFactory extends Factory
{
    /**
     * كلمة المرور الافتراضية للمستخدمين الوهميين
     */
    protected static ?string $password;

    /**
     * تعريف الحالة الافتراضية للمودل (البيانات العشوائية)
     */
    public function definition(): array
    {
        return [
            // // ربط الأسماء مع هيكلية المتجر الجديدة (users_)
            'users_name'       => fake()->name(),
            'users_email'      => fake()->unique()->safeEmail(),
            'users_password'   => static::$password ??= Hash::make('123456'), // كلمة مرور موحدة للاختبار
            'users_phone'      => fake()->phoneNumber(),
            'users_approve'    => 1, // تفعيل الحساب تلقائياً للمستخدمين الوهميين
            
            // // الحقول المضافة
            'role'             => 'user', 
            'api_token'        => hash('sha256', Str::random(60)), // توليد توكن عشوائي مشفر
            
            'remember_token'   => Str::random(10),
        ];
    }

    /**
     * حالة خاصة للمستخدمين غير المفعلين (غير الموافق عليهم)
     */
    public function unapproved(): static
    {
        return $this->state(fn (array $attributes) => [
            'users_approve' => 0,
        ]);
    }

    /**
     * حالة خاصة لإنشاء حساب "مدير" بسرعة
     */
    public function admin(): static
    {
        return $this->state(fn (array $attributes) => [
            'role' => 'admin',
        ]);
    }
}
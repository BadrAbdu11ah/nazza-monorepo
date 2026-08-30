<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Prunable; // 1. استدعاء خاصية التنظيف التلقائي

class OtpCode extends Model
{
    use HasFactory, Prunable; // 2. تفعيل الميزة داخل الـ Model

    protected $fillable = [
        'phone',
        'code',
        'expires_at',
    ];

    protected $casts = [
        'expires_at' => 'datetime',
    ];

    // 3. تحديد السجلات المراد حذفها (الرموز منتهية الصلاحية)
    public function prunable()
    {
        // استعلام للحصول على كافة الرموز التي انتهى وقتها الحالي
        return static::where('expires_at', '<=', now());
    }
}
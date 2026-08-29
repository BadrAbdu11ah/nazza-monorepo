<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Coupon extends Model
{
    // اسم الجدول في قاعدة البيانات
    protected $table = 'coupons';

    /**
     * الحقول القابلة للتعبئة جماعياً
     */
    protected $fillable = [
        'name',
        'count',
        'expired_at',
        'discount',
    ];

    /**
     * تحويل الحقول تلقائياً إلى أنواع البيانات المناسبة في PHP
     */
    protected function casts(): array
    {
        return [
            'expired_at' => 'datetime', // تحويل تاريخ الانتهاء لكائن Carbon تلقائياً
        ];
    }

    /**
     * دالة مساعدة للتحقق مما إذا كان الكوبون قد انتهت صلاحيته أم لا
     */
    public function isExpired(): bool
    {
        return $this->expired_at->isPast();
    }
}
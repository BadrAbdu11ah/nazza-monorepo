<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use App\Models\User;
use App\Models\Address;
use App\Models\Coupon;

class Order extends Model
{
    protected $table = 'orders';

    protected $fillable = [
        'user_id',
        'address_id',
        'address_name',
        'address_city',
        'address_street',
        'address_lat',
        'address_long',
        
        'type',
        'delivery_price',
        'price',             // Subtotal (إجمالي المنتجات)
        'discount_amount',   // قيمة الخصم الثابتة بالريال
        'discount_rate',     // نسبة الخصم
        'total_price',       // الإجمالي النهائي بعد الخصم والشحن
        'coupon_id',         // ID الكوبون (لأغراض الإحصائيات)
        'coupon_name',       // اسم/كود الكوبون وقت الشراء
        'payment_method',
        'status',
        'delivery_id',
        'rating',
        'review',
    ];

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class, 'user_id', 'id');
    }

    public function address(): BelongsTo
    {
        return $this->belongsTo(Address::class, 'address_id', 'id');
    }

    // علاقة اختيارية (قد تكون null لو تم حذف الكوبون من قاعدة البيانات)
    public function coupon(): BelongsTo
    {
        return $this->belongsTo(Coupon::class, 'coupon_id', 'id');
    }

    public function delivery(): BelongsTo
    {
        return $this->belongsTo(User::class, 'delivery_id', 'id');
    }
}
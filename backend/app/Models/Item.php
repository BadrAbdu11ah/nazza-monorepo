<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Casts\Attribute;
use App\Models\Category; 
use App\Models\Cart;

class Item extends Model
{
    protected $table = 'items';

    /**
     * الحقول القابلة للتعبئة جماعياً
     */
    protected $fillable = [
        "name", 
        "name_ar", 
        "desc", 
        "desc_ar", 
        "image", 
        "count", 
        "active", 
        "price", 
        "discount", 
        "delivery_time",
        "category_id"
    ];

    protected $appends = [
        'discounted_price',
    ];

    /**
     * جلب بيانات القسم الذي ينتمي إليه هذا المنتج
     */
    public function category(): BelongsTo
    {
        return $this->belongsTo(Category::class, 'category_id', 'id');
    }

    /**
     * علاقة جلب السلات المرتبطة بهذا المنتج والتي تم تحويلها إلى طلب مكتمل (غير فارغة من order_id)
     */
    public function salesCount(): HasMany
    {
        return $this->hasMany(Cart::class, 'item_id', 'id')->whereNotNull('order_id');
    }

    /**
     * Accessor لتعديل رابط الصورة تلقائياً بإضافة المسار الكامل للسيرفر
     */
    protected function image(): Attribute
    {
        return Attribute::make(
            get: fn ($value) => $value ? asset("upload/items/" . $value) : null,
        );
    }

    /**
     * Accessor لحساب السعر النهائي بعد الخصم تلقائياً
     */
    protected function discountedPrice(): Attribute
    {
        return Attribute::make(
            get: function () {
                if ($this->discount && $this->discount > 0) {
                    return round($this->price - ($this->price * ($this->discount / 100)), 2);
                }
                return (float) $this->price;
            },
        );
    }
}
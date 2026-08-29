<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Casts\Attribute;
use Illuminate\Database\Eloquent\Relations\HasMany;
use App\Models\Item;

class Category extends Model
{
    protected $table = 'categories'; 

    protected $fillable = [
        "name",
        "name_ar",
        "description",
        "image"
    ];

    /**
     * علاقة الأقسام بالمنتجات (القسم يحتوي على منتجات كثيرة)
     */
    public function items(): HasMany
    {
        return $this->hasMany(Item::class, 'category_id', 'id');
    }

    /**
     * Accessor لتعديل رابط الصورة تلقائياً عند جلبها
     */
    protected function image(): Attribute
    {
        return Attribute::make(
            get: fn ($value) => $value ? asset("upload/categories/" . $value) : null,
        );
    }
}
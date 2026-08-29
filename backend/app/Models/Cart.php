<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Support\Collection;
use App\Models\Item; 
use App\Models\Order; 
use App\Models\User; 

class Cart extends Model
{
    // اسم الجدول في قاعدة البيانات
    protected $table = 'carts';

    /**
     * الحقول القابلة للتعبئة جماعياً
     */
    protected $fillable = [
        'user_id', 
        'item_id', 
        'order_id', 
        'coupon_id',
    ];

    /**
     * السجل في السلة ينتمي لمنتج واحد
     */
    public function item(): BelongsTo
    {
        return $this->belongsTo(Item::class, 'item_id', 'id');
    }

    /**
     * السجل في السلة ينتمي لطلب واحد (عند إتمام الشراء فقط)
     */
    public function order(): BelongsTo
    {
        return $this->belongsTo(Order::class, 'order_id', 'id');
    }

    public function coupon(): BelongsTo
    {
        return $this->belongsTo(Coupon::class, 'coupon_id', 'id');
    }
    

    /**
     * السجل في السلة ينتمي لمستخدم واحد
     */
    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class, 'user_id', 'id');
    }

    /**
     * تجميع ومعالجة عناصر السلة وحساب الأسعار والكميات بشكل موحد
     *
     * @param Collection $cartCollection
     * @return Collection
     */
    public static function formatItems(Collection $cartCollection): Collection
    {
        return $cartCollection->groupBy('item_id')->map(function ($group) {
            $cartItem   = $group->first();
            $item       = $cartItem->item;
            
            // اعتماد الخصم عبر Accessor الخاص بالمنتج (discounted_price)
            $unitPrice  = $item->discounted_price ?? ($item->price - ($item->price * ($item->discount ?? 0) / 100));
            $countItems = $group->count();

            return [
                'id'               => $cartItem->id,
                'item_id'          => $item->id,
                'count_items'      => $countItems,
                'item_price'       => round($unitPrice, 2),
                'total_item_price' => round($countItems * $unitPrice, 2),
                'item'             => $item,
            ];
        })->values();
    }
}
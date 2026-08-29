<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use App\Models\Item; 

class Favorite extends Model
{
    // تحديد اسم الجدول في قاعدة البيانات
    protected $table = 'favorites';

    /**
     * الحقول القابلة للتعبئة جماعياً
     */
    protected $fillable = [
        'user_id', 
        'item_id', 
    ];

    /**
     * سجل المفضلة ينتمي لمنتج واحد محدد
     */
    public function item(): BelongsTo
    {
        return $this->belongsTo(Item::class, 'item_id', 'id');
    }

    /**
     * سجل المفضلة ينتمي لمستخدم واحد محدد
     */
    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class, 'user_id', 'id');
    }
}
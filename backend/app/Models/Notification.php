<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Notification extends Model
{
    protected $table = 'notifications'; 

    protected $fillable = [
        "title",
        "body",
        "user_id",
    ];

    /**
     * الاشعار ينتمي لمستحدم واحد محدد
     */
    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class, 'user_id', 'id');
    }
}

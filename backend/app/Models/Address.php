<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Address extends Model
{
    // اسم الجدول في قاعدة البيانات
    protected $table = 'addresses';

    /**
     * الحقول القابلة للتعبئة جماعياً (Mass Assignable)
     */
    protected $fillable = [
        'user_id',
        'name',
        'city',
        'street',
        'lat',
        'long',
        'phone',
    ];

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class, 'user_id', 'id');
    }
}
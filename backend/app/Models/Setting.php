<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Setting extends Model
{
    protected $table = 'settings';

    protected $fillable = [
        'title_home_ar',
        'body_home_ar',
        'title_home_en',
        'body_home_en',
    ];
}

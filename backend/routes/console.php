<?php

use Illuminate\Foundation\Inspiring;
use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Facades\Schedule;


Artisan::command('inspire', function () {
    $this->comment(Inspiring::quote());
})->purpose('Display an inspiring quote');


// تشغيل تنظيف الجدول تلقائياً كل ساعة
Schedule::command('model:prune', [
    '--model' => [App\Models\OtpCode::class],
])->hourly();
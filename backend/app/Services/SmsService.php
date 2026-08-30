<?php

namespace App\Services;

use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;

class SmsService
{
    public function send(string $phone, string $message): bool
    {
        $driver = config('sms.driver');

        // عند الاشتراك الفعلي وتغيير Driver إلى taqnyat
        if ($driver === 'taqnyat') {
            $response = Http::withHeaders([
                'Authorization' => 'Bearer ' . config('sms.taqnyat.bearer_token'),
            ])->post('https://api.taqnyat.sa/v1/messages', [
                'recipients' => [$phone],
                'sender'     => config('sms.taqnyat.sender'),
                'body'       => $message,
            ]);

            return $response->successful();
        }

        // في مرحلة التطوير (SMS_DRIVER=log): تُكتب الرسالة في storage/logs/laravel.log
        Log::info("SMS Mock Sent to [{$phone}]: {$message}");
        return true;
    }
}
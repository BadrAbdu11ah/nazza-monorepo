<?php

namespace App\Services;

use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;

class SmsService
{
    public function send(string $phone, string $message): bool
    {
        $driver = config('sms.driver');

        if ($driver === 'authentica') {
            $formattedPhone = preg_replace('/^0/', '966', trim($phone));
            $apiUrl = config('sms.authentica.url');

            $response = Http::withHeaders([
                'X-Authorization' => config('sms.authentica.api_key'),
                'Accept'          => 'application/json',
                'Content-Type'    => 'application/json',
            ])->post($apiUrl, [
                'phone'       => $formattedPhone,
                'method'      => 'sms', // تحديد وسيلة الإرسال
                'template_id' => config('sms.authentica.template_id'), // رقم القالب
            ]);

            if ($response->failed()) {
                Log::error("Authentica SMS Failed: ", [
                    'status' => $response->status(),
                    'body'   => $response->body(),
                ]);
                return false;
            }

            return true;
        }

        Log::info("SMS Mock Sent to [{$phone}]: {$message}");
        return true;
    }
}
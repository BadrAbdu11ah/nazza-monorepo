<?php

namespace App\Services;

use Kreait\Firebase\Messaging\CloudMessage;
use Kreait\Firebase\Messaging\Notification;

use Illuminate\Support\Facades\Log;

class FcmService
{
    /**
     * إرسال إشعار لمستخدم محدد عبر الـ Topic الخاص به (users + userId)
     */
    public function sendToUser($userId, $title, $body, array $extraData = [])
    {
        $topicName = "users" . $userId;
        return $this->sendToTopic($topicName, $title, $body, $extraData);
    }

    /**
     * إرسال إشعار لمستخدم محدد عبر الـ Topic الخاص به (delivery + userId)
     */
    public function sendToDelivery($userId, $title, $body, array $extraData = [])
    {
        $topicName = "delivery" . $userId;
        return $this->sendToTopic($topicName, $title, $body, $extraData);
    }

    /**
     * إرسال إشعار لمستخدم محدد عبر الـ Topic الخاص به (service + userId)
     */
    public function sendToServices($userId, $title, $body, array $extraData = [])
    {
        $topicName = "service" . $userId;
        return $this->sendToTopic($topicName, $title, $body, $extraData);
    }

    /**
     * إرسال إشعار عام لأي Topic
     */
    public function sendToTopic($topicName, $title, $body, array $extraData = [])
    {
        try {
            // // 1. استدعاء خدمة Firebase Messaging
            $messaging = app('firebase.messaging');

            // // 2. تجهيز الرسالة والبيانات
            $message = CloudMessage::withTarget('topic', $topicName)
                ->withNotification(Notification::create($title, $body))
                ->withData(array_merge([
                    'type' => 'home', // // قيمة افتراضية للتوجيه
                ], $extraData));

            // // 3. الإرسال
            $messaging->send($message);

            return true;

        } catch (\Exception $e) {
            // // تسجيل الخطأ في Log دون إيقاف العملية
            Log::error("فشل إرسال الإشعار للـ Topic ({$topicName}): " . $e->getMessage());
            return false;
        }
    }
}
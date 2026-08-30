<?php

return [
    'driver' => env('SMS_DRIVER', 'log'),

    'taqnyat' => [
        'bearer_token' => env('TAQNYAT_BEARER_TOKEN'),
        'sender'       => env('TAQNYAT_SENDER'),
    ],
];
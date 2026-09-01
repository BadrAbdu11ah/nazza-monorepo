<?php

return [
    'driver' => env('SMS_DRIVER', 'log'),

    'authentica' => [
        'api_key'     => env('AUTHENTICA_API_KEY'),
        'url'         => env('AUTHENTICA_API_URL'),
        'template_id' => env('AUTHENTICA_TEMPLATE_ID'),
    ],
];
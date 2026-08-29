<?php

namespace Database\Seeders;

use App\Models\User;
use App\Models\Category; 
use App\Models\Item;     
use App\Models\Setting;
use App\Models\Coupon;
use App\Models\Order;
use App\Models\Address;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;

class DatabaseSeeder extends Seeder
{
    use WithoutModelEvents;

    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // 1. إنشاء حساب المدير (Admin)
        User::create([
            'name'      => 'Badr Abdullah',
            'email'     => 'Badr@Abdullah.com',
            'password'  => Hash::make('123456'),
            'phone'     => '0500000000',
            'role'      => 'admin',
            'approve'   => 1,
            'api_token' => hash('sha256', 'admin-test-token'), 
        ]);

        // 2. إنشاء حساب مستخدم تجريبي (Test User)
        User::create([
            'name'      => 'Test User',
            'email'     => 'test@example.com',
            'password'  => Hash::make('123456'),
            'phone'     => '0500000001', 
            'role'      => 'user',
            'approve'   => 1,
            'api_token' => hash('sha256', 'user-test-token'),
        ]);

        // 3. إنشاء حساب مستخدم تجريبي (Test Delivery)
        User::create([
            'name'      => 'Badr Delivery',
            'email'     => 'Badr@Delivery.com',
            'password'  => Hash::make('123456'),
            'phone'     => '0500000002', 
            'role'      => 'delivery',
            'approve'   => 1,
            'api_token' => hash('sha256', 'delivery-test-token'),
        ]);

        // إعدادات الموقع (Settings)
        Setting::create([
            'title_home_ar' => 'عروض الصيف',
            'body_home_ar' => 'خصومات تصل إلى 50% على جميع المنتجات',
            'title_home_en' => 'Summer Offers',
            'body_home_en' => 'Get discounts up to 50% on all items',
        ]);

        // 4. إنشاء الفئات (Categories)
        $categories = [
            [
                'name'        => 'Dresses',
                'name_ar'     => 'الفساتين',
                'description' => 'Beautiful and elegant dresses for all occasions',
                'image'       => '1786804465_6a8078f13178e.svg',
            ],
            [
                'name'        => 'Laptops',
                'name_ar'     => 'لابتوبات',
                'description' => 'High-performance laptops for work and gaming',
                'image'       => 'laptop.svg',
            ],
            [
                'name'        => 'Mobile',
                'name_ar'     => 'جوالات',
                'description' => 'Latest smartphones with advanced features',
                'image'       => 'mobile.svg',
            ],
            [
                'name'        => 'camera',
                'name_ar'     => 'كاميرا',
                'description' => 'none',
                'image'       => '1786964294_6a82e946026e1.svg',
            ],
            [
                'name'        => 'Shoes',
                'name_ar'     => 'الأحذية',
                'description' => 'Quality footwear for all activities',
                'image'       => 'shoes.svg',
            ],
        ];

        foreach ($categories as $category) {
            Category::create($category);
        }

        // 5. إنشاء المنتجات (Items)
        $mobileCategory = Category::where('image', 'mobile.svg')->first();
        $laptopCategory = Category::where('image', 'laptop.svg')->first();

        if ($mobileCategory) {
            Item::create([
                'name'        => 'iPhone 15 Pro',
                'name_ar'     => 'آيفون 15 برو',
                'desc'        => 'Latest Apple iPhone with advanced camera and A17 processor',
                'desc_ar'     => 'أحدث هاتف آيفون من أبل مع كاميرا متقدمة ومعالج A17',
                'count'       => 50,
                'active'      => 1,
                'price'       => 2000.00, 
                'discount'    => 0,
                'image'       => 'iphone.png',
                'delivery_time' => 20,
                'category_id' => $mobileCategory->id, 
            ]);
        }

        if ($laptopCategory) {
            Item::create([
                'name'        => 'Dell XPS 15',
                'name_ar'     => 'ديل إكس بي إس 15',
                'desc'        => 'Premium laptop with Intel i9 processor and RTX 4090',
                'desc_ar'     => 'جهاز كمبيوتر محمول فاخر مع معالج إنتل i9 و RTX 4090',
                'count'       => 30,
                'active'      => 1,
                'price'       => 1000.00, 
                'discount'    => 5,
                'image'       => 'laptop.png',
                'delivery_time' => 20,
                'category_id' => $laptopCategory->id, 
            ]);
        }

        Coupon::create([
            'name' => 'badr20',
            'count' => 50,
            'expired_at' => now()->addDays(30),
            'discount' => 20,
        ]);
        // منتهي الصلاحية
        Coupon::create([
            'name' => 'badr30',
            'count' => 50,
            'expired_at' => '2022-01-01',
            'discount' => 30,
        ]);

        Coupon::create([
            'name' => 'badr40',
            'count' => 50,
            'expired_at' => now()->addDays(30),
            'discount' => 40,
        ]);

        Coupon::create([
            'name' => 'badr50',
            'count' => 50,
            'expired_at' => now()->addDays(30),
            'discount' => 50,
        ]);

        Address::create([
            'user_id' => 1,
            'name' => 'Address 1',
            'city' => 'Riyadh',
            'street' => 'Street 1',
            'lat' => 24.713619830044224,
            'long' => 46.67424571647625,
            'phone' => '123456789',
        ]);

        Address::create([
            'user_id' => 2,
            'name' => 'Address 2',
            'city' => 'Jeddah',
            'street' => 'Street 2',
            'lat' => 21.543333333333333,
            'long' => 46.67424571647625,
            'phone' => '123456789',
        ]);
    }
}
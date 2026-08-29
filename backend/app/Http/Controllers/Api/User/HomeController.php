<?php

namespace App\Http\Controllers\Api\User;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Category; 
use App\Models\Cart; 
use App\Models\Item;     
use App\Models\Setting;     

class HomeController extends Controller
{
    /**
     * عرض بيانات الصفحة الرئيسية (الأقسام وأكثر المنتجات مبيعاً)
     * GET /api/home
     */
    public function index()
    {
        $categories = Category::all();
        $settings = Setting::first();

        $items = Item::has('salesCount') 
            ->withCount('salesCount')
            ->orderBy('sales_count_count', 'desc')
            ->take(10)
            ->get();

        if ($items->isEmpty()) {
            $items = Item::latest()->take(10)->get();
            return response()->json([
                "status"     => "success", 
                "categories" => $categories,
                "items"      => $items,
                "settings"   => $settings,
            ]);
        }

        return response()->json([
            "status"     => "success", 
            "categories" => $categories,
            "items"      => $items,
            "settings"   => $settings,
        ]);
    }
    
    /**
     * عرض العروض فقط
     * GET /api/offers
     */
    public function offers(Request $request)
    {
        $user = $request->user();
        $items = Item::where('discount', '>', 0)
            ->latest()
            ->get();

        if ($items->isEmpty()) {
            return response()->json([
                'status'  => "success",
                'message' => 'لا توجد عروض متاحة حالياً',
                'data'    => [] 
            ]);
        }

        if ($user) {
            $favoriteItemIds = $user->favorites()->pluck('item_id')->toArray();

            $items->map(function ($item) use ($favoriteItemIds) {
                $item->is_favorite = in_array($item->id, $favoriteItemIds);
                return $item;
            });
        }

        return response()->json([
            'status'  => "success",
            'message' => 'تم جلب العروض بنجاح',
            'data'    => $items 
        ]);
    }

     /**
     * البحث عن المنتجات بالاسم مع حقول الخصم والمفضلة الجاهزة تلقائياً
     * POST /api/search
    */
    public function search(Request $request)
    {
        $request->validate(["search" => "required|string"]);
        $search = $request->search;
        $user = $request->user();

        $items = Item::with("category")
                    ->where(function($query) use ($search) {
                        $query->where("name", "LIKE", "%$search%")
                              ->orWhere("name_ar", "LIKE", "%$search%");
                    })
                    ->get();

        if ($user) {
            $favoriteItemIds = $user->favorites()->pluck('item_id')->toArray();

            $items->map(function ($item) use ($favoriteItemIds) {
                $item->is_favorite = in_array($item->id, $favoriteItemIds);
                return $item;
            });
        }

        return response()->json([
            "status" => "success",
            "data"   => $items
        ]);
    }
}
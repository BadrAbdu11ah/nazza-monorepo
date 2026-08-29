<?php

namespace App\Http\Controllers\Api\User;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Item; 

class ItemController extends Controller
{
    /**
     * عرض منتجات قسم محدد مع حقن حالة المفضلة
     * GET /api/items/category/{id}
     */
    public function index(Request $request, $id)
    {
        $user = $request->user();

        // 1. جلب المنتجات التابعة للقسم المحدد 
        $items = Item::where("category_id", $id)->get();

        // 2. حقن حقل المفضلة (is_favorite) إذا كان المستخدم مسجلاً
        if ($user) {
            // جلب معرفات المنتجات المفضلة للمستخدم الحالي في مصفوفة سريعة بالذاكرة
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

    /**
     * البحث عن المنتجات بالاسم مع حقول الخصم والمفضلة الجاهزة تلقائياً
     * POST /api/items/search
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
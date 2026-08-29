<?php

namespace App\Models;

use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Laravel\Sanctum\HasApiTokens;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\BelongsToMany; 
use App\Models\Order;
use App\Models\Address;
use App\Models\Cart;
use App\Models\Favorite;
use App\Models\Item; 
use App\Models\Notification; 

class User extends Authenticatable
{
    use HasFactory, Notifiable, HasApiTokens;

    protected $table = 'users'; 

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'name',
        'email',
        'password',
        'phone',
        'role',          
        'api_token',     
        'verify_code',
        'approve',
    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */
    protected $hidden = [
        'password',
        'remember_token',
        'api_token',    
    ];

    /**
     * Get the attributes that should be cast.
     *
     * @return array<string, string>
     */
    protected function casts(): array
    {
        return [
            'password' => 'hashed', 
            'approve'  => 'boolean', 
        ];
    }

    /**
     * التحقق من صلاحيات ودور المستخدم
     */
    public function hasRole(string $role): bool
    {
        return $this->role === $role;
    }

    /**
     * علاقة المستخدم بالطلبات (المستخدم لديه طلبات كثيرة)
     */
    public function orders(): HasMany
    {
        return $this->hasMany(Order::class, 'user_id', 'id');
    }

    /**
     * إضافة: علاقة المستخدم بالعناوين (المستخدم لديه عناوين شحن متعددة)
     */
    public function addresses(): HasMany
    {
        return $this->hasMany(Address::class, 'user_id', 'id');
    }

    /**
     * إضافة: علاقة المستخدم بعناصر السلة الحالية
     */
    public function carts(): HasMany
    {
        return $this->hasMany(Cart::class, 'user_id', 'id');
    }

    /**
     * علاقة المنتجات المفضلة للمستخدم مباشرة عبر جدول favorites
     */
    public function favoriteItems(): BelongsToMany
    {
        return $this->belongsToMany(Item::class, 'favorites', 'user_id', 'item_id')->withTimestamps();
    }

    /**
     * علاقة المستخدم بسجلات جدول المفضلة نفسه
     */
    public function favorites(): HasMany
    {
        return $this->hasMany(Favorite::class, 'user_id', 'id');
    }

    /**
     * علاقة المستخدم بسجلات جدول المفضلة نفسه
     */
    public function notifications(): HasMany
    {
        return $this->hasMany(Notification::class, 'user_id', 'id');
    }
}
<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('orders', function (Blueprint $table) {
            $table->id(); 
            
            $table->foreignId('user_id')->constrained()->onDelete('cascade');

            $table->foreignId('address_id')->nullable()->constrained('addresses')->nullOnDelete();
            $table->string('address_name')->nullable();    
            $table->string('address_city')->nullable();    
            $table->string('address_street')->nullable();  
            $table->decimal('address_lat', 10, 8)->nullable();     
            $table->decimal('address_long', 11, 8)->nullable();

            $table->integer("type")->default(0); // 0 => Delivery, 1 => Drive Thru 
            $table->double("delivery_price")->default(0);
            $table->double("price");
            $table->double("total_price");
            
            $table->foreignId('coupon_id')->nullable()->constrained('coupons')->nullOnDelete();
            $table->string('coupon_name')->nullable();
            $table->decimal('discount_amount', 10, 2)->default(0.00)->nullable();
            $table->integer('discount_rate')->default(0)->nullable();
            
            $table->integer("payment_method")->default(0); // 0 => cash, 1 => payment card
            
            $table->integer("status")->default(0); // 0 => pending, 1 => rejected, 2 => accepted, 3 => prepare, 4 => delivered, 5 => done, 6 => cancelled
            
            $table->foreignId('delivery_id')->nullable()->constrained('users')->nullOnDelete();            
            $table->decimal("rating", 2, 1)->nullable();
            $table->string("review", 255)->nullable();
            
            $table->timestamps();
            $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('orders');
    }
};
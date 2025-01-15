<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Carbon\Carbon;
use App\Models\User;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('users', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->string('username')->unique();
            $table->string('email')->unique();
            $table->timestamp('email_verified_at')->nullable();
            $table->string('password');
            $table->string('phone_number')->nullable();
            $table->boolean('phone_verified')->default(false);
            $table->string('role')->nullable();
            $table->rememberToken();
            $table->timestamps();
        });

        Schema::create('password_reset_tokens', function (Blueprint $table) {
            $table->string('email')->primary();
            $table->string('token');
            $table->timestamp('created_at')->nullable();
        });

        Schema::create('sessions', function (Blueprint $table) {
            $table->string('id')->primary();
            $table->foreignId('user_id')->nullable()->index();
            $table->string('ip_address', 45)->nullable();
            $table->text('user_agent')->nullable();
            $table->longText('payload');
            $table->integer('last_activity')->index();
        });


        User::create([
            'name' => 'Admin',
            'username' => 'admin',
            'email' => 'admin@mail.com',
            'password' => bcrypt('123456'),
            'role' => 'admin',
            'email_verified_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'password' => bcrypt('password'),
        ]);

        User::create([
            'name' => 'Efriel Elyasa',
            'username' => 'user',
            'email' => 'user@mail.com',
            'password' => bcrypt('123456'),
            'email_verified_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'password' => bcrypt('password'),
        ]);
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('users');
        Schema::dropIfExists('password_reset_tokens');
        Schema::dropIfExists('sessions');
    }
};

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
        Schema::create('profiles', function (Blueprint $table) {
            $table->id(); // Automatically creates a primary key with auto-increment
            $table->unsignedBigInteger('user_id')->nullable();
            $table->foreign('user_id')->references('id')->on('users')->onDelete('cascade')->onUpdate('cascade');
            $table->string('name', 255);
            $table->unsignedBigInteger('matchmaker_id')->nullable();
            $table->foreign('matchmaker_id')->references('id')->on('users')->onDelete('cascade')->onUpdate('cascade');
            $table->string('city', 100);
            $table->string('state', 100);
            $table->string('country', 100);
            $table->integer('age'); // No auto-increment here
            $table->string('gender', 25)->nullable();
            $table->json('bodytype')->nullable();
            $table->integer('height')->nullable(); // No auto-increment here
            $table->integer('inches')->nullable(); // No auto-increment here
            $table->string('haircolor', 50)->nullable();
            $table->json('maritalstatus')->nullable();
            $table->json('children')->nullable(); // No auto-increment here
            $table->json('religion')->nullable();
            $table->tinyInteger('smoker')->nullable(); // No auto-increment here
            $table->string('drinker', 20)->nullable();
            $table->string('education', 100)->nullable();
            $table->integer('yearsexperience')->nullable(); // No auto-increment here
            $table->string('jobtitle', 100)->nullable();
            $table->text('sports')->nullable();
            $table->text('hobbies')->nullable();
            $table->json('languages')->nullable()->change(); //
            $table->text('bio')->nullable();
            $table->string('profile_image1');
            $table->string('profile_image2');
            $table->string('occupation', 150)->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('profiles');
    }
};

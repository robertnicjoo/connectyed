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
        Schema::create('request_availabilities', function (Blueprint $table) {
            $table->id();
            $table->string('code')->unique();
            $table->foreignId('user_id')->constrained('users'); // Person who requested
            $table->foreignId('client_one_id')->constrained('users'); // Person who chooses the datetimes
            $table->foreignId('client_two_id')->constrained('users')->nullable(); // Person who accepts one of the times
            $table->foreignId('meeting_id')->constrained('meetings')->nullable(); // References the created meeting
            $table->string('timezone')->nullable(); // created by first person
            $table->dateTime('start_date_one')->nullable(); // created by first person
            $table->dateTime('start_date_two')->nullable(); // created by first person
            $table->dateTime('start_date_three')->nullable(); // created by first person
            $table->dateTime('chosen_date')->nullable(); // created by second person
            $table->string('end_time')->nullable();
            $table->boolean('finished')->default(false);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('request_availabilities');
    }
};

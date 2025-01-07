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
        Schema::table('profiles', function (Blueprint $table) {
            $table->unsignedBigInteger('matchmaker_id2')->nullable()->index(); // Matchmaker profile reference
            $table->foreign('matchmaker_id2')
                  ->references('id')
                  ->on('profiles')
                  ->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('profiles', function (Blueprint $table) {
            $table->dropForeign(['matchmaker_id2']); // Drop foreign key
            $table->dropColumn('matchmaker_id2'); // Drop the column
        });
    }
};

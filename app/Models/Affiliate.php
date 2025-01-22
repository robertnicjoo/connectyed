<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Affiliate extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'percentage',
        'code',
        'is_used',
        'number_of_usage',
        'start_date',
        'expire_date',
    ];

    protected $casts = [
        'start_date' => 'date',
        'expire_date' => 'date',
        'is_used' => 'datetime',
        'number_of_usage' => 'integer',
    ];

    /**
     * Relationship with User model
     */
    public function user()
    {
        return $this->belongsTo(User::class);
    }
}

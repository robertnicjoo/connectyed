<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class MeetingReview extends Model
{
    use HasFactory;

    protected $fillable = [
        'meeting_id',
        'client_id',
        'status', //enum('pending', 'satisfied', 'complained') 
        'complaint_text',
        'reviewed_at',
        'rate',
    ];
}

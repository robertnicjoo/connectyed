<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class RequestAvailability extends Model
{
    protected $fillable = [
        'code',
        'user_id',
        'timezone',
        'client_one_id',
        'client_two_id',
        'meeting_id',
        'start_date_one',
        'start_date_two',
        'start_date_three',
        'chosen_date',
        'end_time',
        'finished',
    ];

    protected $casts = [
        'user_id' => 'integer', 
        'client_one_id' => 'integer', 
        'client_two_id' => 'integer', 
        'meeting_id' => 'integer', 
        'start_date_one' => 'datetime',
        'start_date_two' => 'datetime',
        'start_date_three' => 'datetime',
        'chosen_date' => 'datetime',
        'finished' => 'boolean',
    ];


    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    public function firstParty()
    {
        return $this->belongsTo(User::class, 'client_one_id');
    }

    public function secondParty()
    {
        return $this->belongsTo(User::class, 'client_two_id');
    }
    
    public function meeting()
    {
        return $this->hasOne(Meeting::class);
    }
}

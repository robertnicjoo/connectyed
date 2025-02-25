<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Profile extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'user_id',
        'matchmaker_id',
        'city',
        'state',
        'country',
        'age',
        'gender',
        'bodytype', //multiple
        'height',
        'inches',
        'haircolor',
        'maritalstatus',
        'children',
        'religion', //multiple
        'smoker',
        'drinker',
        'education',
        'jobtitle',
        'sports',
        'hobbies',
        'languages',
        'bio',
        'profile_image1',
        'profile_image2',
        'yearsexperience',
        'name', 
        'seeking',
        'occupation',
        'ethnicity',
        'having_kids',
        'having_kids_in_future',
    ];

    /**
     * The attributes that should be cast to native types.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'age' => 'integer',
        'yearsexperience' => 'integer',
        'children' => 'integer',
        'smoker' => 'boolean',
        'height' => 'integer',
        'inches' => 'integer',
        'bodytype' => 'array',
        'religion' => 'array',
        'ethnicity' => 'array',
        'children' => 'array',
        'maritalstatus' => 'array',
        'languages' => 'array',
    ];

    /**
     * Get the user that owns the profile.
     */
    public function user()
    {
        return $this->belongsTo(User::class);
    }
}

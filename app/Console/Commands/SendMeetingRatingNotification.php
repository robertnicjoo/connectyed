<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\Meeting;
use App\Models\User;
use App\Notifications\MeetingRatingNotification;
use Carbon\Carbon;

class SendMeetingRatingNotification extends Command
{
    protected $signature = 'meeting:send-rating-notifications';
    protected $description = 'Send rating notifications to users for meetings that have ended';

    public function __construct()
    {
        parent::__construct();
    }

    public function handle()
    {
        // Get all meetings where the end_time has passed and send notifications
        $meetings = Meeting::where('end_time', '<', Carbon::now())->get();
        $this->info("now: " . Carbon::now());
        $this->info("meetings: " . $meetings);

        foreach ($meetings as $meeting) {
            $user = User::find($meeting->client_id);

            // Check if the user exists before sending the notification
            if ($user) {
                $user->notify(new MeetingRatingNotification($meeting, $user));
                $this->info("Notification sent to: " . $user->email);
            } else {
                $this->error("User with client_id {$meeting->client_id} not found.");
            }

            $meeting->status = 'finished';
            $meeting->save();
        }
    }
}

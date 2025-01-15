<?php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Notifications\Notification;
use Illuminate\Notifications\Messages\MailMessage;

class MeetingRatingNotification extends Notification
{
    use Queueable;

    protected $meeting;
    protected $user;

    public function __construct($meeting, $user)
    {
        $this->meeting = $meeting;
        $this->user = $user;
    }

    public function via($notifiable)
    {
        return ['mail'];
    }

    public function toMail($notifiable)
    {
        return (new MailMessage)
            ->subject('How was your experience?')
            ->greeting('Hello ' . $notifiable->name)
            ->line('You have just finished your scheduled meeting.')
            ->line('We would like to know about your experience, would you mind taking 2 minutes and filling our survey form?')
            ->action('Rate your experience', url('/survey').'/'.$this->meeting->google_meet_id)
            ->line('Thank you for using our service!');
    }
}

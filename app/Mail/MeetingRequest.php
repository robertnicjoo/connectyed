<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Mail\Mailables\Content;
use Illuminate\Mail\Mailables\Envelope;
use Illuminate\Queue\SerializesModels;

class MeetingRequest extends Mailable
{
    use Queueable, SerializesModels;

    public $user;
    public $adminMessage;
    public $url;

    /**
     * Create a new message instance.
     */
    public function __construct($user, $adminMessage, $url)
    {
        $this->user = $user;
        $this->adminMessage = $adminMessage;
        $this->url = $url;
    }

    /**
     * Get the message envelope.
     */
    public function envelope(): Envelope
    {
        return new Envelope(
            subject: 'Meeting Request',
        );
    }

    /**
     * Get the message content definition.
     */
    public function content(): Content
    {
        return new Content(
            markdown: 'emails.meeting-request',
            with: [
                'user' => $this->user,
                'adminMessage' => $this->adminMessage,
                'url' => $this->url,
            ],
        );
    }

    /**
     * Get the attachments for the message.
     *
     * @return array<int, \Illuminate\Mail\Mailables\Attachment>
     */
    public function attachments(): array
    {
        return [];
    }
}

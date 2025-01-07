<x-mail::message>
# New Password

Hello {{ $user->name }},

We received a request to reset your password for your account.

> If you made this request, please log in with your new password and consider changing it to a more secure one.
> 
> If you didn't make this request, you can safely ignore this email cause we already changed your password and you're in safe hands.

<x-mail::panel>
Your new password is: **{{ $pass }}**
</x-mail::panel>

---

Thanks,<br>
{{ config('app.name') }}
</x-mail::message>

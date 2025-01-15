<x-mail::message>
# Hey {{ $user->name }}, I’ve got a date for you

Here are some date details:

<x-mail::panel>
{{ $adminMessage }}
</x-mail::panel>


<x-mail::button :url="$url">
Provide your availability
</x-mail::button>

Thanks,<br>
{{ config('app.name') }}
</x-mail::message>

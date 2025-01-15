<x-mail::message>
# Hey {{ $data['receiver']['name'] }}, I’ve got a date for you

Here are some date details:

<x-mail::panel>
{{$data['admin_message'] }}
</x-mail::panel>


<p>Here are the meetings that have been scheduled, please select your availability:</p>

<table style="width: 100%; border-collapse: collapse; text-align: left; font-family: Arial, sans-serif;">
    <thead style="background-color: #f2f2f2;">
        <tr>
            <th style="border: 1px solid #ddd; padding: 8px;">Start Time</th>
            <th style="border: 1px solid #ddd; padding: 8px;">Duration (minutes)</th>
            <th style="border: 1px solid #ddd; padding: 8px;">Availability</th>
        </tr>
    </thead>
    <tbody>
        @foreach($data['start_dates'] as $meeting)
            <tr style="background-color: {{ $loop->index % 2 === 0 ? '#ffffff' : '#f9f9f9' }};">
                <td style="border: 1px solid #ddd; padding: 8px;">{{ $meeting['value'] }}</td>
                <td style="border: 1px solid #ddd; padding: 8px;">15</td>
                <td style="border: 1px solid #ddd; padding: 8px;">
                    <x-mail::button :url="url('/') . '/approve-a-date/' . $data['code'] . '/' . $meeting['name']">
                        Select
                    </x-mail::button>
                </td>                               
            </tr>
        @endforeach
    </tbody>
</table>


Thanks,<br>
{{ config('app.name') }}
</x-mail::message>

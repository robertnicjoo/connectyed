// // countries.js
// export const countries = [
//     'Afghanistan', 'Albania', 'Algeria', 'Andorra', 'Angola', 'Antigua and Barbuda', 'Argentina', 'Armenia',
//     'Australia', 'Austria', 'Azerbaijan', 'Bahamas', 'Bahrain', 'Bangladesh', 'Barbados', 'Belarus',
//     'Belgium', 'Belize', 'Benin', 'Bhutan', 'Bolivia', 'Bosnia and Herzegovina', 'Botswana', 'Brazil',
//     'Brunei', 'Bulgaria', 'Burkina Faso', 'Burundi', 'Cabo Verde', 'Cambodia', 'Cameroon', 'Canada',
//     'Central African Republic', 'Chad', 'Chile', 'China', 'Colombia', 'Comoros', 'Congo',
//     'Costa Rica', 'Croatia', 'Cuba', 'Cyprus', 'Czech Republic', 'Denmark', 'Djibouti', 'Dominica',
//     'Dominican Republic', 'Ecuador', 'Egypt', 'El Salvador', 'Equatorial Guinea', 'Eritrea',
//     'Estonia', 'Eswatini', 'Ethiopia', 'Fiji', 'Finland', 'France', 'Gabon', 'Gambia',
//     'Georgia', 'Germany', 'Ghana', 'Greece', 'Grenada', 'Guatemala', 'Guinea', 'Guinea-Bissau',
//     'Guyana', 'Haiti', 'Honduras', 'Hungary', 'Iceland', 'India', 'Indonesia', 'Iran', 'Iraq',
//     'Ireland', 'Israel', 'Italy', 'Jamaica', 'Japan', 'Jordan', 'Kazakhstan', 'Kenya', 'Kiribati',
//     'Kuwait', 'Kyrgyzstan', 'Laos', 'Latvia', 'Lebanon', 'Lesotho', 'Liberia', 'Libya', 'Liechtenstein',
//     'Lithuania', 'Luxembourg', 'Madagascar', 'Malawi', 'Malaysia', 'Maldives', 'Mali', 'Malta',
//     'Marshall Islands', 'Mauritania', 'Mauritius', 'Mexico', 'Micronesia', 'Moldova', 'Monaco',
//     'Mongolia', 'Montenegro', 'Morocco', 'Mozambique', 'Myanmar', 'Namibia', 'Nauru', 'Nepal',
//     'Netherlands', 'New Zealand', 'Nicaragua', 'Niger', 'Nigeria', 'North Korea', 'North Macedonia',
//     'Norway', 'Oman', 'Pakistan', 'Palau', 'Palestine', 'Panama', 'Papua New Guinea', 'Paraguay',
//     'Peru', 'Philippines', 'Poland', 'Portugal', 'Qatar', 'Romania', 'Russia', 'Rwanda',
//     'Saint Kitts and Nevis', 'Saint Lucia', 'Saint Vincent and the Grenadines', 'Samoa', 'San Marino',
//     'Sao Tome and Principe', 'Saudi Arabia', 'Senegal', 'Serbia', 'Seychelles', 'Sierra Leone',
//     'Singapore', 'Slovakia', 'Slovenia', 'Solomon Islands', 'Somalia', 'South Africa', 'South Korea',
//     'South Sudan', 'Spain', 'Sri Lanka', 'Sudan', 'Suriname', 'Sweden', 'Switzerland', 'Syria',
//     'Taiwan', 'Tajikistan', 'Tanzania', 'Thailand', 'Timor-Leste', 'Togo', 'Tonga',
//     'Trinidad and Tobago', 'Tunisia', 'Turkey', 'Turkmenistan', 'Tuvalu', 'Uganda', 'Ukraine',
//     'United Arab Emirates', 'United Kingdom', 'United States', 'Uruguay', 'Uzbekistan', 'Vanuatu',
//     'Vatican City', 'Venezuela', 'Vietnam', 'Yemen', 'Zambia', 'Zimbabwe'
// ];

export const countries = [
    {
        name: "Afghanistan",
        states: [
            {
                name: "Kabul",
                cities: ["Kabul City", "Shakardara", "Paghman"],
            },
            {
                name: "Kandahar",
                cities: ["Kandahar"],
            },
            {
                name: "Nangarhar",
                cities: ["Jalalabad"],
            },
            {
                name: "Herat",
                cities: ["Herat"],
            },
            {
                name: "Balkh",
                cities: ["Mazar-e-sharif"],
            },
            {
                name: "Helmand",
                cities: ["Lashkargah"],
            },
            {
                name: "Kunduz",
                cities: ["Kunduz"],
            },
            {
                name: "Takhar",
                cities: ["Taloqan"],
            },
            {
                name: "Baghlan",
                cities: ["Puli Khumri"],
            },
            {
                name: "Jowzjan",
                cities: ["Sheberghan"],
            },
            {
                name: "Nimroz",
                cities: ["Zaranj"],
            },
            {
                name: "Faryab",
                cities: ["Maymana"],
            },
            {
                name: "Ghazni",
                cities: ["Ghazni"],
            },
            {
                name: "Khost",
                cities: ["Khost"],
            },
            {
                name: "Parwan",
                cities: ["Charikar"],
            },
            {
                name: "Badakhshan",
                cities: ["Fayzabad"],
            },
            {
                name: "Uruzgan",
                cities: ["Tarinkot"],
            },
            {
                name: "Paktia",
                cities: ["Gardez"],
            },
        ],
    },
    {
        name: "Albania",
        states: [
            {
                name: "Tirana",
                cities: ["Tirana City", "Farkë", "Vaqarr"],
            },
            {
                name: "Tropojë",
                cities: ["Bajram Curri "],
            },
            {
                name: "Malësi e Madhe",
                cities: ["Bajzë"],
            },
            {
                name: "Mallakastër",
                cities: ["Ballsh"],
            },
            {
                name: "Berat",
                cities: ["Berat"],
            },
            {
                name: "Devoll",
                cities: ["Bilisht"],
            },
            {
                name: "Bulqizë",
                cities: ["Bulqizë"],
            },
            {
                name: "Mat",
                cities: ["Burrel"],
            },
            {
                name: "Cërrik",
                cities: ["Cërrik"],
            },
            {
                name: "Elbasan",
                cities: ["Cërrik"],
            },
            {
                name: "Skrapar",
                cities: ["Çorovodë"],
            },
        ],
    },
    {
        name: "Indonesia",
        states: [
            {
                name: "Aceh",
                cities: ["Banda Aceh"],
            },
            {
                name: "North Sumatra",
                cities: ["Medan"],
            },
            {
                name: "West Sumatra",
                cities: ["Padang"],
            },
            {
                name: "Riau",
                cities: ["Pekanbaru"],
            },
            {
                name: "Jambi",
                cities: ["Jambi"],
            },
            {
                name: "South Sumatra",
                cities: ["Palembang"],
            },
            {
                name: "Bengkulu",
                cities: ["Bengkulu"],
            },
            {
                name: "Lampung",
                cities: ["Bandar Lampung"],
            },
            {
                name: "Bangka Belitung Islands",
                cities: ["Pangkal Pinang"],
            },
            {
                name: "Riau Islands",
                cities: ["Tanjung Pinang", "Batam"],
            },
            {
                name: "Special Capital Region of Jakarta",
                cities: ["Central Jakarta"],
            },
            {
                name: "West Java",
                cities: ["Bandung", "Bekasi", "Depok"],
            },
            {
                name: "Central Java",
                cities: ["Semarang"],
            },
            {
                name: "Special Region of Yogyakarta",
                cities: ["Yogyakarta"],
            },
            {
                name: "East Java",
                cities: ["Surabaya"],
            },
            {
                name: "Banten",
                cities: ["Serang", "Tangerang"],
            },
            {
                name: "Bali",
                cities: ["Denpasar"],
            },
            {
                name: "West Nusa Tenggara",
                cities: ["Mataram"],
            },
            {
                name: "East Nusa Tenggara",
                cities: ["Kupang"],
            },
            {
                name: "West Kalimantan",
                cities: ["Pontianak"],
            },
            {
                name: "Central Kalimantan",
                cities: ["Palangka Raya"],
            },
            {
                name: "South Kalimantan",
                cities: ["Banjarbaru", "Banjarmasin"],
            },
            {
                name: "East Kalimantan",
                cities: ["Samarinda"],
            },
            {
                name: "North Kalimantan",
                cities: ["Tanjung Selor", "Tarakan"],
            },
            {
                name: "North Sulawesi",
                cities: ["Manado"],
            },
            {
                name: "Central Sulawesi",
                cities: ["Palu"],
            },
            {
                name: "South Sulawesi",
                cities: ["Makassar"],
            },
            {
                name: "Southeast Sulawesi",
                cities: ["Kendari"],
            },
            {
                name: "Gorontalo",
                cities: ["Gorontalo"],
            },
            {
                name: "West Sulawesi",
                cities: ["Mamuju"],
            },
            {
                name: "Maluku",
                cities: ["Ambon"],
            },
            {
                name: "North Maluku",
                cities: ["Sofifi", "Ternate"],
            },
            {
                name: "West Papua",
                cities: ["Manokwari"],
            },
            {
                name: "Southwest Papua",
                cities: ["Sorong"],
            },
            {
                name: "Papua",
                cities: ["Jayapura"],
            },
            {
                name: "South Papua",
                cities: ["Salor", "Merauke"],
            },
            {
                name: "Central Papua",
                cities: ["Wanggar", "Timika"],
            },
            {
                name: "Highland Papua",
                cities: ["Jayawijaya"],
            },
        ],
    },
    {
        name: "United States",
        states: [
            {
                name: "Alabama",
                cities: ["Montgomery", "Huntsville"],
            },
            {
                name: "Alaska",
                cities: ["Juneau", "Anchorage"],
            },
            {
                name: "Arizona",
                cities: ["Phoenix"],
            },
            {
                name: "Arkansas",
                cities: ["Little Rock"],
            },
            {
                name: "California",
                cities: ["Sacramento", "Los Angeles"],
            },
            {
                name: "Sacramento",
                cities: ["Denver"],
            },
            {
                name: "Connecticut",
                cities: ["Hartford", "Bridgeport"],
            },
            {
                name: "Delaware",
                cities: ["Dover", "Wilmington"],
            },
            {
                name: "Florida",
                cities: ["Tallahassee", "Jacksonville"],
            },
            {
                name: "Georgia",
                cities: ["Atlanta"],
            },
            {
                name: "Hawaii",
                cities: ["Honolulu"],
            },
            {
                name: "Idaho",
                cities: ["Boise"],
            },
            {
                name: "Illinois",
                cities: ["Springfield", "Chicago"],
            },
            {
                name: "Indiana",
                cities: ["Indianapolis"],
            },
            {
                name: "Iowa",
                cities: ["Des Moines"],
            },
            {
                name: "Kansas",
                cities: ["Topeka", "Wichita"],
            },
            {
                name: "Kentucky",
                cities: ["Frankfort", "Louisville"],
            },
            {
                name: "Louisiana",
                cities: ["Baton Rouge", "New Orleans"],
            },
            {
                name: "Maine",
                cities: ["Augusta", "Portland"],
            },
            {
                name: "Maryland",
                cities: ["Annapolis", "Baltimore"],
            },
            {
                name: "Massachusetts",
                cities: ["Boston"],
            },
            {
                name: "Michigan",
                cities: ["Lansing", "Detroit"],
            },
            {
                name: "Minnesota",
                cities: ["Saint Paul", "Minneapolis"],
            },
            {
                name: "Mississippi",
                cities: ["Jackson"],
            },
            {
                name: "Missouri",
                cities: ["Jefferson City", "Kansas City"],
            },
            {
                name: "Montana",
                cities: ["Helena", "Billings"],
            },
            {
                name: " Nebraska",
                cities: ["Lincoln", "Omaha"],
            },
            {
                name: "Nevada",
                cities: ["Carson City", "Las Vegas"],
            },
            {
                name: "New Hampshire",
                cities: ["Concord", "Manchester"],
            },
            {
                name: "New Jersey",
                cities: ["Trenton", "Newark"],
            },
            {
                name: "New Mexico",
                cities: ["Santa Fe", "Albuquerque"],
            },
            {
                name: "New York",
                cities: ["Albany", "New York City"],
            },
            {
                name: "North Carolina",
                cities: ["Raleigh", "Charlotte"],
            },
            {
                name: "North Dakota",
                cities: ["Bismarck", "Fargo"],
            },
            {
                name: "Ohio",
                cities: ["Columbus"],
            },
            {
                name: "Oklahoma",
                cities: ["Oklahoma City"],
            },
            {
                name: "Oregon",
                cities: ["Salem", "Portland"],
            },
            {
                name: "Pennsylvania",
                cities: ["Harrisburg", "Philadelphia"],
            },
            {
                name: "Rhode Island",
                cities: ["Providence"],
            },
            {
                name: "South Carolina",
                cities: ["Columbia", "Charleston"],
            },
            {
                name: "South Dakota",
                cities: ["Pierre", "Sioux Falls"],
            },
            {
                name: "Tennessee",
                cities: ["Nashville"],
            },
            {
                name: "Texas",
                cities: ["Austin", "Houston"],
            },
            {
                name: "Utah",
                cities: ["Salt Lake City"],
            },
            {
                name: "Vermont",
                cities: ["Montpelier", "Burlington"],
            },
            {
                name: "Virginia",
                cities: ["Richmond", "Virginia Beach"],
            },
            {
                name: "Washington",
                cities: ["Olympia", "Seattle"],
            },
            {
                name: "West Virginia",
                cities: ["Charleston"],
            },
            {
                name: "Wisconsin",
                cities: ["Madison", "Milwaukee"],
            },
            {
                name: "Wyoming",
                cities: ["Cheyenne"],
            },
        ],
    },
    // more countries
];

<template>  
    <div class="mx-auto max-w-7xl py-6 sm:px-6 lg:px-8 flex justify-center">
        <div class="w-full shadow-connectyed rounded-xl bg-connectyed-card-light flex flex-col py-5 px-5 mb-5"> 
            <div class="p-6 bg-gray-50 text-medium text-gray-500 dark:text-gray-400 dark:bg-gray-800 rounded-lg w-full">
                <div class="main-content flex flex-col md:flex-row">
                    
                    <div class="w-full md:w-1/3 p-2 flex flex-col justify-center items-center">
                        <!-- Main Image -->
                        <div v-if="profile.profile_image1"  class="w-full overflow-hidden bg-gray-400 flex items-center mb-2">
                            <a target="_blank" :href="profile.profile_image1">
                                <img :src="profile.profile_image1" alt="Main Image" class="w-full h-auto md:h-full object-cover">
                            </a>
                        </div>
                        
                        <!-- Thumbnail Image (Image2) - Only if not null -->
                        <div v-if="profile.profile_image2" class="w-full overflow-hidden bg-gray-300 flex justify-center items-center">
                            <a target="_blank" :href="profile.profile_image2">
                                <img :src="profile.profile_image2" alt="Profile Thumbnail" class="w-full h-full object-cover">
                            </a>
                        </div>

                        <div v-if="!profile.profile_image1 && !profile.profile_image2"  class="w-full overflow-hidden bg-gray-400 flex items-center mb-2">
                            <a target="_blank" :href="profile.profile_image1">
                                <img src="/upload/images/profiles/default.png" alt="Image Not Found" class="w-full h-auto md:h-full object-cover">
                            </a>
                        </div>
                    </div>


                    <div class="w-full md:w-2/3">
                        <div class="flex flex-wrap mb-1">
                            <div class="w-full">
                                <label class="text-gray-700 text-2xl">{{profile.name}}</label>
                            </div>
                        </div>
                        <div class="flex flex-wrap mb-1">
                            <div class="w-full mb-5">
                                <label class="text-gray-700 text-1/2xl">
                                    {{ profile.city ? profile.city : 'Your City' }}, {{ profile.country ? profile.country : 'Your Country' }}
                                </label>
                            </div>
                        </div>  
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-3 mb-3">
                            <div>
                                <label class="text-gray-700 text-md">Age:</label> {{ profile.age ? profile.age : 'N/A' }}
                            </div>
                            <div>
                                <label class="text-gray-700 text-md">Body Type:</label> {{ formattedArrays(profile.bodytype) }}
                            </div>
                            <div>
                                <label class="text-gray-700 text-md">Height:</label>
                                {{ profile.height ? profile.height+'′' : 'N/A' }} {{ profile.inches ? profile.inches+'″' : '0″' }}
                            </div>
                            <div>
                                <label class="text-gray-700 text-md">Hair Color:</label> {{ profile.haircolor ? profile.haircolor : 'N/A' }}
                            </div>
                            <div>
                                <label class="text-gray-700 text-md">Marital Status:</label> {{ formattedArrays(profile.maritalstatus) }}
                            </div>
                            <div>
                                <label class="text-gray-700 text-md">Children:</label> {{ profile.children ? profile.children : 'N/A' }}
                            </div>
                            <div>
                                <label class="text-gray-700 text-md">Religion:</label> {{ formattedArrays(profile.religion) }}
                            </div>
                            <div>
                                <label class="text-gray-700 text-md">Smoker:</label> {{ profile.smoker !== undefined ? (profile.smoker ? 'Yes' : 'No') : 'N/A' }}                            </div>
                            <div>
                                <label class="text-gray-700 text-md">Drinker:</label> {{ profile.drinker ? profile.drinker : 'N/A' }}
                            </div>
                            <div>
                                <label class="text-gray-700 text-md">Education:</label> {{ profile.education ? profile.education : 'N/A' }}
                            </div>
                            <div>
                                <label class="text-gray-700 text-md">Job Title:</label> {{ profile.jobtitle ? profile.jobtitle : 'N/A' }}
                            </div>
                            <div>
                                <label class="text-gray-700 text-md">Sports:</label> {{ profile.sports ? profile.sports : 'N/A' }}
                            </div>
                            <div>
                                <label class="text-gray-700 text-md">Hobbies:</label> {{ profile.hobbies ? profile.hobbies : 'N/A' }}
                            </div>
                            <div>
                                <label class="text-gray-700 text-md">Languages:</label> {{ formattedLanguages(profile.languages) }}

                            </div>
                        </div>
                    </div>
                </div>
                <div class="grid grid-cols-1 px-5 mt-5">
                    <label class="text-gray-700 text-md">Self Description:</label>
                    {{ profile.bio ? profile.bio : 'N/A' }}
                </div>
                <div class="grid grid-cols-1 px-5 mt-5">
                    <label class="text-gray-700 text-md">Comments:</label>
                    {{ profile.comment ? profile.comment : 'N/A' }}
                </div>
            </div>
        </div>
    </div>
</template>


<script>
  export default {
    props: {
      profile: {
        type: Object,
        required: true,
        default: () => ({
            name: '',
            city: '',
            state: '',
            country: '',
            currentLocation: '',
            age: '',
            hairColor: '',
            bodytype: [],
            heightFeet: '',
            heightInches: '',
            maritalStatus: [],
            children: '',
            religion: [],
            smoker: '',
            drinker: '',
            education: '',
            jobTitle: '',
            sports: '',
            hobbies: '',
            englishLevel: '',
            languages: [],
            avatar: '/upload/images/profiles/default.png'
        }),
      },
    },
    methods: {
        formattedArrays(value) {
            // If value is undefined, null, or an empty array, return 'N/A'
            if (!value || (Array.isArray(value) && value.length === 0)) {
                return 'N/A';
            }

            // If value is a string, try to parse it as JSON
            if (typeof value === 'string') {
                try {
                    value = JSON.parse(value);
                } catch (error) {
                    console.error('Error parsing value:', error);
                    value = []; // Default to an empty array if parsing fails
                }
            }

            // Ensure value is an array, then join values with commas
            return Array.isArray(value) ? value.join(', ') : value;
        },
        formattedLanguages(languages) {
            if (typeof languages === 'string') {
                try {
                    languages = JSON.parse(languages);
                } catch (error) {
                    console.error('Error parsing languages:', error);
                    return 'N/A';
                }
            }

            if (Array.isArray(languages) && languages.length > 0) {
                return languages.map(lang => `${lang.language} (${lang.level})`).join(', ');
            }
            return 'N/A';
        }
    }
  };
</script>
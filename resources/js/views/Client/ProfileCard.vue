<template>  
    <div class="mx-auto max-w-7xl py-6 sm:px-6 lg:px-8 flex justify-center">
        <div class="w-full shadow-connectyed rounded-xl bg-connectyed-card-light flex flex-col py-5 px-5 mb-5"> 
            <div class="p-6 bg-gray-50 text-medium text-gray-500 dark:text-gray-400 dark:bg-gray-800 rounded-lg w-full">
                <div class="main-content flex flex-col md:flex-row">
                    <div class="w-full md:w-1/3 p-2 flex justify-center">
                        <!-- Main Image -->
                        <div class="w-full md:w-[270px] h-auto md:h-[360px] overflow-hidden bg-gray-400 flex items-center">
                            <a target="_blank" :href="profile.profile_image1">
                                <img :src="profile.profile_image1" alt="Main Image" class="w-full h-auto md:h-full object-cover">
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
                            <div class="w-full">
                                <label class="text-gray-700 text-2xl">
                                    {{ profile.city ? profile.city : 'Your City' }}, {{ profile.country ? profile.country : 'Your Country' }}
                                </label>
                            </div>
                        </div>  
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-3 mb-3">
                            <div>
                                <label class="text-gray-700 text-md">Age:</label> {{ profile.age ? profile.age : 'N/A' }}
                            </div>
                            <div>
                                <label class="text-gray-700 text-md">Body Type:</label> {{ profile.bodytype ? profile.bodytype : 'N/A' }}
                            </div>
                            <div>
                                <label class="text-gray-700 text-md">Height:</label>
                                {{ profile.height ? profile.height+'′' : 'N/A' }} {{ profile.inches ? profile.inches+'″' : '0″' }}
                            </div>
                            <div>
                                <label class="text-gray-700 text-md">Hair Color:</label> {{ profile.haircolor ? profile.haircolor : 'N/A' }}
                            </div>
                            <div>
                                <label class="text-gray-700 text-md">Marital Status:</label> {{ profile.maritalstatus ? profile.maritalstatus : 'N/A' }}
                            </div>
                            <div>
                                <label class="text-gray-700 text-md">Children:</label> {{ profile.children ? profile.children : 'N/A' }}
                            </div>
                            <div>
                                <label class="text-gray-700 text-md">Religion:</label> {{ profile.religion ? profile.religion : 'N/A' }}
                            </div>
                            <div>
                                <label class="text-gray-700 text-md">Smoker:</label> {{ profile.smoker ? profile.smoker : 'N/A' }}
                            </div>
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
                                <label class="text-gray-700 text-md">English Level:</label> {{ profile.english ? profile.english : 'N/A' }}
                            </div>
                            <div>
                                <label class="text-gray-700 text-md">Languages:</label> {{ profile.languages ? profile.languages : 'N/A' }}
                            </div>
                        </div>
                    </div>
                </div>
                <div class="grid grid-cols-1 px-5 mt-5">
                    <label class="text-gray-700 text-md">Self Description:</label>
                    {{ profile.description ? profile.description : 'N/A' }}
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
            bodytype: '',
            heightFeet: '',
            heightInches: '',
            maritalStatus: '',
            children: '',
            religion: '',
            smoker: '',
            drinker: '',
            education: '',
            jobTitle: '',
            sports: '',
            hobbies: '',
            englishLevel: '',
            languages: '',
            avatar: '/upload/images/profiles/default.png'
        }),
      },
    },
  };
  </script>
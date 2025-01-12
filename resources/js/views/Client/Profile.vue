<template>
    <div class="mx-full shadow-connectyed rounded-xl bg-connectyed-card-light flex flex-col py-5 px-5 mb-5">
        <div class="grid grid-cols-4 gap-4">
            <label class="text-lg font-bold text-gray-900 dark:text-white mb-4 p-2">About your Profile</label>
            <span></span>
            <span></span>
            <button
                class="bg-connectyed-button-light text-connectyed-button-dark py-3 px-10"
                @click="toggleFormVisibility"
                v-if="!isFormVisible"
            >
                Edit Info
            </button>
        </div>

        <!-- Loading State -->
        <div v-if="!user || !profile" class="text-center my-5">
            <p class="text-gray-700">Loading user and profile information...</p>
        </div>

        <!-- Main Content -->
        <div class="main-content" v-else>
            <!-- Profile Display -->
            <div v-if="!isFormVisible">
                <div class="flex">
                    <!-- Profile Images Section -->
                    <div class="col-4 p-2">
                        <div class="flex flex-wrap justify-left cursor-pointer">
                            <!-- Main Image -->
                            <div class="w-[270px] h-[360px] overflow-hidden bg-gray-400">
                                <img
                                    :src="currentAvatar || '/upload/images/profiles/default.png'"
                                    alt="Main Image"
                                    class="w-full h-full object-cover"
                                />
                            </div>

                            <!-- Thumbnails -->
                            <div class="flex flex-wrap justify-left gap-2 mt-2">
                                <div
                                    class="w-[45px] h-[61px] p-1 overflow-hidden cursor-pointer"
                                    v-for="(image, index) in profile.additionalImages"
                                    :key="image"
                                >
                                    <img
                                        :src="image"
                                        @click="updateAvatar(image)"
                                        alt="Profile Thumbnail"
                                        class="shadow-sm bg-gray-400 w-full h-full object-cover rounded"
                                    />
                                </div>
                            </div>
                        </div>

                        <!-- Upload Image Buttons -->
                        <div class="flex w-full gap-2 my-2">
                            <label class="cursor-pointer flex-1">
                                <span class="text-connectyed-button-dark bg-connectyed-button-light hover:bg-connectyed-button-hover
                                    hover:text-connectyed-button-hover-dark focus:outline-none focus:ring-2 focus:ring-blue-500 px-4 py-2 w-full
                                    block text-center rounded">
                                    Upload Image 1
                                </span>
                                <input
                                    type="file"
                                    class="hidden"
                                    @change="uploadFile($event, 1)"
                                    accept="image/*"
                                />
                            </label>

                            <label class="cursor-pointer flex-1">
                                <span class="text-connectyed-button-dark bg-connectyed-button-light hover:bg-connectyed-button-hover
                                    hover:text-connectyed-button-hover-dark focus:outline-none focus:ring-2 focus:ring-blue-500 px-4 py-2 w-full
                                    block text-center rounded">
                                    Upload Image 2
                                </span>
                                <input
                                    type="file"
                                    class="hidden"
                                    @change="uploadFile($event, 2)"
                                    accept="image/*"
                                />
                            </label>
                        </div>
                    </div>

                    <!-- Profile Details Section -->
                    <div class="col-7">
                        <!-- User Name -->
                        <div class="flex flex-wrap mb-1">
                            <div class="w-full">
                                <label class="text-gray-700 text-2xl font-semibold capitalize">
                                    {{ profile.name }}
                                </label>
                            </div>
                        </div>

                        <!-- Location -->
                        <div class="flex flex-wrap mb-1">
                            <div class="w-full">
                                <label class="text-gray-700 text-2xl">
                                    {{ userCity || 'Your City' }}, {{ profile.country || 'Your Country' }}
                                </label>
                            </div>
                        </div>

                        <!-- Additional Profile Information -->
                        <!-- You can expand this section with all the profile details as needed -->
                        <div class="flex flex-wrap mb-3">
                            <div class="w-full">
                                <label class="text-gray-700 text-lg font-semibold">Age: {{ profile.age }}</label>
                            </div>
                        </div>
                        <!-- Repeat similar blocks for other profile details -->
                    </div>
                </div>
            </div>

            <!-- Edit Form -->
            <div v-if="isFormVisible">
                <form class="w-full" @submit.prevent="postProfile" method="put">
                    <!-- Full Name -->
                    <div class="flex flex-wrap -mx-3 mb-6">
                        <div class="w-full px-3 mb-6 md:mb-0">
                            <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="name">
                                Full Name
                            </label>
                            <input
                                class="appearance-none block w-full border border-gray-500 rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white"
                                type="text"
                                v-model="profile.name"
                                id="name"
                                required
                            />
                        </div>
                    </div>

                    <!-- Country -->
                    <div>
                        <h3 class="font-semibold text-lg mb-4">Location Details</h3>
                        <div class="grid grid-cols-3 md:grid-cols-3 gap-1">
                        <select-option
                            label="Country"
                            :options="filteredCountries"
                            v-model="profile.country"
                            :required="true"
                            class="appearance-none block w-full border border-gray-500 rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white"
                            @change="handleCountrySearch(profile.country)"
                        />

                        <!-- State Dropdown -->
                        <select-option
                            label="State"
                            :options="filteredStates"
                            v-model="profile.state"
                            :required="true"
                            class="appearance-none block w-full border border-gray-500 rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white"
                            @change="handleStateSearch(profile.state)"
                        />

                        <!-- City Dropdown -->
                        <select-option
                            label="City"
                            :options="filteredCities"
                            v-model="profile.city"
                            :required="true"
                            class="appearance-none block w-full border border-gray-500 rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white"
                            @change="handleCitySearch(profile.city)"
                        />
                        </div>
                    </div>

                    <!-- Age and Hair Color -->
                    <div class="flex flex-wrap -mx-3 mb-6">
                        <!-- Age -->
                        <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
                            <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="age">
                                Age
                            </label>
                            <input
                                class="appearance-none block w-full border border-gray-200 rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
                                v-model="profile.age"
                                id="age"
                                type="number"
                                min="0"
                                required
                            />
                        </div>

                        <!-- Hair Color -->
                        <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
                            <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="haircolor">
                                Hair Color
                            </label>
                            <input
                                class="appearance-none block w-full border border-gray-200 rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
                                v-model="profile.haircolor"
                                id="haircolor"
                                type="text"
                                required
                            />
                        </div>
                    </div>

                    <!-- Gender -->
                    <div class="flex flex-wrap -mx-3 mb-6">
                        <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="gender">
                            Gender
                        </label>
                        <div class="relative w-full">
                            <select
                                class="block appearance-none w-full border border-gray-200 text-gray-700 py-3 px-4 pr-8 rounded leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
                                v-model="profile.gender"
                                id="gender"
                                required
                            >
                                <option value="">Select Gender</option>
                                <option>Male</option>
                                <option>Female</option>
                                <!-- Add more gender options if needed -->
                            </select>
                            <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
                                <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
                                    <path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z" />
                                </svg>
                            </div>
                        </div>
                    </div>

                    <!-- Body Type, Height Feet, and Inches -->
                    <div class="flex flex-wrap -mx-3 mb-6">
                        <!-- Body Type -->
                        <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
                            <div class="relative">
                                <MultiSelectOption
                                    label="Body Type"
                                    class="block appearance-none w-full border border-gray-200 text-gray-700 py-3 px-4 pr-8 rounded leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
                                    :options="bodyTypes"
                                    v-model="profile.bodytype"
                                    :required="true"
                                />
                                
                                    <!-- 
                                    id="bodytype" -->
                                <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
                                    <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
                                        <path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z" />
                                    </svg>
                                </div>
                            </div>
                        </div>

                        <!-- Height (Feet) -->
                        <div class="w-full md:w-1/4 px-3 mb-6 md:mb-0">
                            <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="height">
                                Height (Feet)
                            </label>
                            <input
                                class="appearance-none block w-full border border-gray-200 rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
                                v-model="profile.height"
                                id="height"
                                placeholder="0"
                                min="0"
                                max="8"
                                type="number"
                                required
                            />
                        </div>

                        <!-- Height (Inches) -->
                        <div class="w-full md:w-1/4 px-3 mb-6 md:mb-0">
                            <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="inches">
                                Inches
                            </label>
                            <input
                                class="appearance-none block w-full border border-gray-200 rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
                                v-model="profile.inches"
                                id="inches"
                                placeholder="0"
                                min="0"
                                max="11"
                                type="number"
                                required
                            />
                        </div>
                    </div>

                    <!-- Marital Status and Children -->
                    <div class="grid grid-cols-3 md:grid-cols-3 gap-4 mt-4">
                        <!-- Marital Status -->
                        <MultiSelectOption 
                            label="Marital Status" 
                            v-model="profile.maritalstatus" 
                            :options="maritalStatuses" 
                            :required="true"
                            :maxItem="1"
                        />

                        <!-- Children -->
                        <select-option
                            label="Current Kid(s)"
                            :options="childrenOptions"
                            v-model="profile.children"
                            :required="true"
                        />

                        <!-- Religion -->
                        <MultiSelectOption
                            label="Religion"
                            :options="religions"
                            v-model="profile.religion"
                            :required="true"
                        />
                    </div>

                    <!-- Smoker and Drinker -->
                    <div class="flex flex-wrap -mx-3 mb-6">
                        <!-- Smoker -->
                        <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
                            <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="smoker">
                                Smoker
                            </label>
                            <div class="relative">
                                <select
                                    class="block appearance-none w-full border border-gray-200 text-gray-700 py-3 px-4 pr-8 rounded leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
                                    v-model="profile.smoker"
                                    id="smoker"
                                    required
                                >
                                    <option value="">Select Option</option>
                                    <option :value="true">Yes</option>
                                    <option :value="false">No</option>
                                    <!-- Add more options if needed -->
                                </select>
                                <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
                                    <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
                                        <path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z" />
                                    </svg>
                                </div>
                            </div>
                        </div>

                        <!-- Drinker -->
                        <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
                            <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="drinker">
                                Drinker
                            </label>
                            <div class="relative">
                                <select
                                    class="block appearance-none w-full border border-gray-200 text-gray-700 py-3 px-4 pr-8 rounded leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
                                    v-model="profile.drinker"
                                    id="drinker"
                                    required
                                >
                                    <option value="">Select Option</option>
                                    <option>None</option>
                                    <option>Occasionally</option>
                                    <option>Often</option>
                                    <!-- Add more options if needed -->
                                </select>
                                <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
                                    <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
                                        <path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z" />
                                    </svg>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Education and Job Title -->
                    <div class="flex flex-wrap -mx-3 mb-6">
                        <!-- Education -->
                        <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
                            <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="education">
                                Education
                            </label>
                            <input
                                class="appearance-none block w-full border border-gray-200 rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
                                v-model="profile.education"
                                id="education"
                                type="text"
                                required
                            />
                        </div>

                        <!-- Job Title -->
                        <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
                            <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="jobtitle">
                                Job Title
                            </label>
                            <input
                                class="appearance-none block w-full border border-gray-200 rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
                                v-model="profile.jobtitle"
                                id="jobtitle"
                                type="text"
                                required
                            />
                        </div>
                    </div>

                    <!-- Sports and Hobbies -->
                    <div class="flex flex-wrap -mx-3 mb-6">
                        <!-- Sports -->
                        <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
                            <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="sports">
                                Sports
                            </label>
                            <input
                                class="appearance-none block w-full border border-gray-200 rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
                                v-model="profile.sports"
                                id="sports"
                                type="text"
                                required
                            />
                        </div>

                        <!-- Hobbies -->
                        <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
                            <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="hobbies">
                                Hobbies
                            </label>
                            <input
                                class="appearance-none block w-full border border-gray-200 rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
                                v-model="profile.hobbies"
                                id="hobbies"
                                type="text"
                                required
                            />
                        </div>
                    </div>

                    <!-- English Level and Languages -->
                    <!-- <div class="flex flex-wrap -mx-3 mb-6">
                        <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
                            <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="languages">
                                Languages
                            </label>
                            <input
                                class="appearance-none block w-full border border-gray-200 rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
                                v-model="profile.languages"
                                id="languages"
                                type="text"
                                required
                            />
                        </div>
                    </div> -->

                    <!-- Languages and Levels -->
                    <div class="grid grid-cols-1 md:grid-cols-1 gap-4 mt-4">
                        <div class="space-y-4">
                        <label for="languages" class="block">Languages</label>
                        <!-- Language-Level Pairing -->
                        <div v-for="(item, index) in profile.languages" :key="index" class="flex space-x-4">
                            <!-- Language Input -->
                            <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
                            <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="languages">
                                Language
                            </label>
                            <select
                                class="appearance-none block w-full border border-gray-200 rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
                                v-model="item.language"
                                required
                            >
                                <option value="" disabled>Select language</option>
                                <option v-for="(language, i) in languages" :key="i" :value="language">
                                {{ language }}
                                </option>
                            </select>
                            </div>

                            <!-- Level Select -->
                            <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
                            <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="level">
                                Level
                            </label>
                            <select
                                v-model="item.level"
                                class="appearance-none block w-full border border-gray-200 rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
                                required
                            >
                                <option value="" disabled>Select level</option>
                                <option v-for="(level, i) in englishLevels" :key="i" :value="level">
                                {{ level }}
                                </option>
                            </select>
                            </div>

                            <!-- Remove Language Button -->
                            <button
                            @click="removeLanguage(index)"
                            type="button"
                            class="ml-2 text-red-500"
                            :disabled="profile.languages.length <= 1"
                            >
                            Remove
                            </button>
                        </div>

                        <!-- Add Language Button -->
                        <button
                            @click="addLanguage"
                            class="mt-2 px-4 py-2 rounded"
                            type="button"
                            :class="{
                            'bg-blue-500 text-white': !(profile.languages.length >= 4),
                            'bg-gray-400 text-gray-600 cursor-not-allowed': profile.languages.length >= 4
                            }"
                            :disabled="profile.languages.length >= 4"
                        >
                            Add Language
                        </button>
                        </div>
                    </div>

                    <!-- Bio -->
                    <div class="flex flex-wrap -mx-3 mb-6">
                        <div class="w-full px-3 mb-6 md:mb-0">
                            <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="bio">
                                Bio
                            </label>
                            <textarea
                                class="appearance-none block w-full border border-gray-200 rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
                                v-model="profile.bio"
                                id="bio"
                                rows="4"
                                required
                            ></textarea>
                        </div>
                    </div>

                    <!-- Submit Button -->
                    <div class="flex flex-wrap -mx-3 mb-6 justify-center">
                        <button
                            type="submit"
                            :disabled="processing"
                            class="bg-connectyed-button-light text-connectyed-button-dark hover:bg-connectyed-button-hover-light hover:text-connectyed-button-hover-dark py-3 px-10 rounded"
                        >
                            {{ processing ? 'Saving...' : 'SAVE' }}
                        </button>
                    </div>
                </form>
                <div>
                    <hr class="mt-5">
                    <NewPassword 
                        :email="profile.email" 
                        :token="authorization.token"
                        inputClass="appearance-none block w-full border border-gray-200 rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
                    />
                </div>
            </div>
        </div>
    </div>
</template>
<script>
// Import the countries array from countries.js
import { countries } from '../../components/countries.js';
import NewPassword from '../newPassword.vue';
import MultiSelectOption from '../../components/MultiSelectOption.vue';
import SelectOption from '../../components/SelectOption.vue';
import axios from 'axios';

export default {
    name: "Profile",
    data() {
        return {
            bodyTypes: ['Slender', 'Average', 'Athletic', 'Curvy', 'Big and Beautiful'],
            languages: [
                'English', 'Spanish', 'Mandarin', 'Hindi', 'Arabic', 'Bengali', 'Portuguese', 
                'Russian', 'Japanese', 'Punjabi', 'German', 'Javanese', 'Korean', 'French', 
                'Turkish', 'Vietnamese', 'Telugu', 'Chinese', 'Marathi', 'Tamil'
            ],
            englishLevels: ['Native', 'Beginner', 'Intermediate', 'Proficient'],
            maritalStatuses: ['Single', 'Separated', 'Divorced', 'Married', 'Widowed'],
            childrenOptions: ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10'],
            religions: [
                'Buddhism', 'Catholic', 'Christian', 'Confucianism', 'Hinduism',
                'Islam', 'Jainism', 'Judaism', 'Shinto', 'Sikhism',
                'Taoism', 'Zoroastrianism', 'Other'
            ],
            userCity: '',
            countries: countries,
            filteredCountries: countries.map(country => country.name), // For search functionality
            user: {},
            profile: {
                bio: '',
                country: '',
                state: '',
                email: '',
                city: '',
                bodytype: [],
                languages: [],
                additionalImages: [],
                maritalstatus: [],
                children: '',
                religion: [],
            },
            isFormVisible: false,
            processing: false,
            currentAvatar: null,
            authorization: this.$store.state.auth.authorization,
        };
    },
    components: {
        MultiSelectOption,
        SelectOption,
        NewPassword,
    },
    computed: {
        // Access user and profile from Vuex store
        userFromStore() {
            return this.$store.getters['auth/user'];
        },
        profileFromStore() {
            return this.$store.getters['auth/profile'];
        },
    },
    mounted() {
        this.getProfile();
    },
    methods: {
        // Handle country search
        handleCountrySearch(query) {
            // Filter states based on the selected country
            const selected = this.countries.find(country => country.name === query);
            this.filteredStates = selected ? selected.states.map(state => state.name) : [];
            // Reset the selected state and city when the country changes
            this.profile.state = null;
            this.profile.city = null;
        },
        // Handle state search
        handleStateSearch(query) {
            // Filter cities based on the selected state
            const country = this.countries.find(country => country.name === this.profile.country);
            const selected = country ? country.states.find(state => state.name === query) : null;
            this.filteredCities = selected ? selected.cities : [];
            
            // Reset the selected city when the state changes
            this.profile.city = null;
        },
        // Handle city search based on selected state
        handleCitySearch(query) {
            // If no state is selected, reset the city options
            if (!this.profile.state) {
                this.filteredCities = [];
                return;
            }

            // Find the country that has the selected state
            const country = this.countries.find(c => c.name === this.profile.country);
            if (!country) return;

            // Find the selected state within the country
            const state = country.states.find(s => s.name === this.profile.state);
            if (!state) return;

            // If no query is entered, show all cities in the selected state
            if (!query) {
                this.filteredCities = state.cities;
                return;
            }
        },
        addLanguage() {
            // Add a new language-level pair
            this.profile.languages.push({ language: '', level: '' });
        },
        removeLanguage(index) {
            // Remove language-level pair at the specified index
            if (this.profile.languages.length > 1) {
                this.profile.languages.splice(index, 1);
            }
        },
        toggleFormVisibility() {
            this.isFormVisible = !this.isFormVisible;
        },
        /**
         * Fetch the user's profile from the backend API.
         */
        async getProfile() {
            this.processing = true;
            try {
                axios.defaults.headers.common.Authorization = `Bearer ${this.authorization.token}`;
                const response = await axios.get('/api/profile/getprofile');

                if (response.data.success) {
                    // Set profile and user data
                    this.profile = response.data.data;
                    this.user = response.data.data.user;
                    this.profile.email = this.user.email;

                    this.userCity = this.profile.city;
                    
                    // Ensure additionalImages is an array
                    if (!Array.isArray(this.profile.additionalImages)) {
                        this.profile.additionalImages = [];
                    }

                    // Decode bodytype from JSON string to array
                    if (typeof this.profile.bodytype === 'string') {
                        try {
                            this.profile.bodytype = JSON.parse(this.profile.bodytype);
                        } catch (error) {
                            console.error('Error parsing bodytype:', error);
                            this.profile.bodytype = [];
                        }
                    }

                    // Initialize as empty array if still undefined
                    if (!Array.isArray(this.profile.bodytype)) {
                        this.profile.bodytype = [];
                    }

                    // Decode languages from JSON string to array
                    if (typeof this.profile.languages === 'string') {
                        try {
                        this.profile.languages = JSON.parse(this.profile.languages);
                        } catch (error) {
                        console.error('Error parsing languages:', error);
                        this.profile.languages = [];
                        }
                    }

                    // Initialize as empty array if still undefined
                    if (!Array.isArray(this.profile.languages)) {
                        this.profile.languages = [];
                    }

                    // Decode religion from JSON string to array
                    if (typeof this.profile.religion === 'string') {
                        try {
                            this.profile.religion = JSON.parse(this.profile.religion);
                        } catch (error) {
                            console.error('Error parsing religion:', error);
                            this.profile.religion = [];
                        }
                    }

                    // Initialize as empty array if still undefined
                    if (!Array.isArray(this.profile.religion)) {
                        this.profile.religion = [];
                    }

                    // Decode maritalstatus from JSON string to array
                    if (typeof this.profile.maritalstatus === 'string') {
                        try {
                            this.profile.maritalstatus = JSON.parse(this.profile.maritalstatus);
                        } catch (error) {
                            console.error('Error parsing maritalstatus:', error);
                            this.profile.maritalstatus = [];
                        }
                    }

                    // Initialize as empty array if still undefined
                    if (!Array.isArray(this.profile.maritalstatus)) {
                        this.profile.maritalstatus = [];
                    }
                    
                    // Set current avatar
                    this.currentAvatar = this.profile.profile_image1 || '/upload/images/profiles/default.png';

                    // Update Vuex store with fetched user and profile
                    this.$store.commit('auth/SET_USER', this.user);
                    this.$store.commit('auth/SET_PROFILE', this.profile);
                } else {
                    alert('Failed to fetch profile data.');
                }
            } catch (error) {
                console.error('Error fetching profile:', error);
                alert('Failed to fetch profile.');
            } finally {
                this.processing = false;
            }
        },

        /**
         * Submit the updated profile to the backend API.
         */
        async postProfile() {
            this.processing = true;
            try {
                axios.defaults.headers.common.Authorization = `Bearer ${this.authorization.token}`;
                
                // Initialize FormData
                const formData = new FormData();
                
                // Append profile fields to formData
                formData.append('profile[name]', this.profile.name || this.user.name);
                formData.append('profile[bio]', this.profile.bio || '');
                formData.append('profile[country]', this.profile.country || '');
                formData.append('profile[state]', this.profile.state || '');
                formData.append('profile[city]', this.profile.city || '');                
                formData.append('profile[children]', this.profile.children || '');

                // Append bodyType array
                this.profile.maritalstatus.forEach(item => {
                    formData.append('profile[maritalstatus][]', item);
                });

                // Append bodyType array
                this.profile.bodytype.forEach(item => {
                    formData.append('profile[bodytype][]', item);
                });

                // Append languages array
                this.profile.languages.forEach((item, index) => {
                    formData.append(`profile[languages][${index}][language]`, item.language);
                    formData.append(`profile[languages][${index}][level]`, item.level);
                });

                this.profile.religion.forEach(item => {
                    formData.append('profile[religion][]', item);
                });

                // Smoker field
                const smoker = typeof this.profile.smoker === 'string'
                    ? (this.profile.smoker === 'true' || this.profile.smoker === true)
                    : this.profile.smoker;
                formData.append('profile[smoker]', smoker);

                // Send the FormData via Axios PUT request
                const response = await axios.post('/api/profile/updateprofile', formData);

                if (response.data.success) {
                    // Update the profile data
                    this.profile = response.data.data;
                    this.user = response.data.data.user;

                    // Update Vuex store
                    this.$store.commit('auth/SET_USER', this.user);
                    this.$store.commit('auth/SET_PROFILE', this.profile);

                    this.currentAvatar = this.profile.profile_image1 || '/upload/images/profiles/default.png';
                    this.isFormVisible = false;

                    alert('Profile updated successfully');
                } else {
                    alert('Failed to update profile.');
                }
            } catch (error) {
                console.error('Error updating profile:', error);
                alert('Failed to update profile. Please try again.');
            } finally {
                this.processing = false;
            }
        },

        /**
         * Upload a profile image.
         * @param {Event} event - The file input change event.
         * @param {Number} imageNumber - Indicates which image slot to upload (1 or 2).
         */
        async uploadFile(event, imageNumber = 1) {
            const file = event.target.files[0];
            if (!file) return;

            const formData = new FormData();
            formData.append("file", file);
            formData.append("image_number", imageNumber);

            this.processing = true;
            try {
                axios.defaults.headers.common.Authorization = `Bearer ${this.authorization.token}`;
                const response = await axios.post('/api/profile/uploadimage', formData, {
                    headers: {
                        'Content-Type': 'multipart/form-data'
                    }
                });

                if (response.data.success) {
                    if (imageNumber === 1) {
                        this.profile.profile_image1 = response.data.data;
                        this.currentAvatar = response.data.data;
                    } else if (imageNumber === 2) {
                        // Assuming you have a separate field for the second image
                        if (!this.profile.additionalImages) {
                            this.profile.additionalImages = [];
                        }
                        this.profile.additionalImages.push(response.data.data);
                    }
                    // Update Vuex store with the new profile
                    this.$store.commit('auth/SET_PROFILE', this.profile);
                    alert('Image uploaded successfully');
                } else {
                    alert('Failed to upload image.');
                }
            } catch (error) {
                console.error('Error uploading image:', error);
                alert('Failed to upload image.');
            } finally {
                this.processing = false;
            }
        },

        /**
         * Update the avatar to a selected image.
         * @param {String} image - The URL of the selected image.
         */
        async updateAvatar(image) {
            this.processing = true;
            try {
                axios.defaults.headers.common.Authorization = `Bearer ${this.authorization.token}`;
                const payload = {
                    avatar: image,
                };
                const response = await axios.put('/api/profile/updateprofile', payload);
                if (response.data.success) {
                    this.profile.profile_image1 = response.data.data.profile_image1;
                    this.currentAvatar = response.data.data.profile_image1 || '/upload/images/profiles/default.png';

                    // Update Vuex store with the new profile
                    this.$store.commit('auth/SET_PROFILE', this.profile);
                    alert('Avatar updated successfully');
                } else {
                    alert('Failed to update avatar.');
                }
            } catch (error) {
                console.error('Error updating avatar:', error);
                alert('Failed to update avatar.');
            } finally {
                this.processing = false;
            }
        },
    },
    watch: {
        // Watch for changes in selected country to reset filtered states and cities
        'profile.country'(newCountry) {
        const country = this.countries.find(c => c.name === newCountry);
        if (country) {
            console.log('New country:', newCountry);
            this.profile.state = null; // Reset selected state when country changes
            this.profile.city = null; // Reset selected city when country changes
            this.filteredStates = country.states.map(state => state.name);
            this.filteredCities = []; // Clear cities when country changes
        } else {
            this.filteredStates = [];
            this.filteredCities = [];
        }
        },

        // Watch for changes in selected state to reset filtered cities
        'profile.state'(newState) {
        if (!this.profile.country) return;

        const country = this.countries.find(c => c.name === this.profile.country);
        if (!country) return;

        const state = country.states.find(s => s.name === newState);
        if (state) {
            console.log('New state:', newState);

            this.profile.city = null; // Reset selected city when state changes
            this.filteredCities = state.cities;
        } else {
            this.filteredCities = [];
        }
        },

        // Watch for changes in selected city
        'profile.city'(newCity) {
            if (newCity) {
                // You can perform any additional actions or logic when a city is selected
                console.log(`New city: ${newCity}`);
            }
        },
    },
};
</script>

<style scoped>
/* Add any component-specific styles here */

/* Example: Customize the appearance of the upload buttons */
.bg-connectyed-button-light {
    background-color: #4CAF50; /* Example color */
}

.text-connectyed-button-dark {
    color: #FFFFFF; /* Example color */
}

.bg-connectyed-button-hover {
    background-color: #45a049; /* Example hover color */
}

.bg-connectyed-button-hover-light {
    background-color: #66BB6A; /* Example hover light color */
}

.text-connectyed-button-hover-dark {
    color: #FFFFFF; /* Example hover text color */
}

/* Additional styles as needed */
</style>

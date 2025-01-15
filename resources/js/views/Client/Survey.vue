<template>
  <div class="max-w-3xl mx-auto p-6 bg-white rounded-lg shadow-lg">
    <h2 class="text-2xl font-bold text-center mb-6">Rate Your Experience</h2>

    <form @submit.prevent="submitSurvey" class="space-y-6">
      <!-- Star Rating Selection -->
      <div>
        <label for="rating" class="block text-lg font-semibold mb-2">Rate the meeting:</label>
        <div class="flex">
          <FontAwesomeIcon
            v-for="n in 5"
            :key="n"
            :icon="faStar"
            class="cursor-pointer text-gray-400 text-3xl"
            :class="{'text-yellow-400': n <= rating}"
            @click="rating = n"
          />
        </div>
      </div>

      <!-- Complaint Text -->
      <div>
        <label for="complaint_text" class="block text-lg font-semibold mb-2">What would you have liked to be different?</label>
        <textarea v-model="complaintText" id="complaint_text" class="block w-full h-40 px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500"
          placeholder="Please provide your feedback..."></textarea>
      </div>

      <!-- Meeting ID -->
      <div>
        <label for="meetingId" class="block text-lg font-semibold mb-2">Meeting ID *</label>
        <input v-model="meetingId" id="meetingId" readonly
          class="block w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500" />
      </div>

      <!-- Submit Button -->
      <div>
        <button type="submit"
          class="w-full py-2 bg-indigo-600 text-white font-semibold rounded-lg hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-indigo-500">
          Submit
        </button>

        <div v-if="message != ''" v-html="message"></div>
      </div>
    </form>
  </div>
</template>

<script>
import axios from 'axios';
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome';
import { faStar } from '@fortawesome/free-solid-svg-icons';

export default {
  components: {
    FontAwesomeIcon,
    faStar
  },
  data() {
    console.log('dddd: ', this.$route.params.meetingId);
    return {
      message: '',
      faStar,  // Icon for star
      rating: '', // Store the selected rating
      complaintText: '',
      meetingId: '', // Assuming meeting_id is passed via route params
      clientId: '', // Assuming the user info is stored in Vuex
    };
  },
  computed: {
    user() {
      return this.$store.state.auth.user;
    },
  },
  watch: {
    // Watch the route params to update meetingId when the route changes
    '$route.params.meetingId'(newMeetingId) {
      this.meetingId = newMeetingId;
    }
  },
  mounted() {
    // Set the meetingId initially from the route
    this.meetingId = this.$route.params.meetingId;
  },
  methods: {
    async submitSurvey() {
      this.message = '';
      if (!this.rating || !this.meetingId) {
        alert('Please fill in all fields.');
        return;
      }

      try {
        const response = await axios.post('/api/survey-store', {
          meeting_id: this.meetingId,
          client_id: this.user.id,
          complaint_text: this.complaintText,
          rating: this.rating,
        });

        if (response.data.success) {
          this.message = '<p class="text-green-500">Thank you for your feedback!</p>';
        } else {
          this.message = `<p class="text-red-500">${response.data.message}</p>`;
        }
      } catch (error) {
       // Check if the error is related to the response from the backend
        if (error.response) {
          // The request was made and the server responded with a status code
          // outside of the 2xx range
          this.message = `<p class="text-red-500">${error.response.data.message || error.response.statusText}</p>`;
        } else if (error.request) {
          // The request was made but no response was received
          this.message = '<p class="text-red-500">No response from server. Please check your internet connection or try again later.</p>';
        } else {
          // Something else happened in setting up the request
          this.message = `<p class="text-red-500">Unexpected error: ${error.message}</p>`;
        }
      }
    },
  },
};
</script>

<style scoped>
/* Add custom styling if needed */
</style>

<template>
  <div class="p-8 bg-gray-100 min-h-screen">
    <h1 class="text-2xl font-bold mb-6 text-gray-700">List of registered clients</h1>

    <div v-if="clients.length === 0" class="text-gray-500">
      No clients Registered
    </div>

    <div v-else class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
      <div v-for="client in clients" :key="client.id" class="p-6 bg-white shadow-md rounded-lg">
        <h2 class="text-lg font-semibold text-[#213366]">{{ client.name }}</h2>
        <p class="text-gray-500">{{ client.email }}</p>
        <div class="mt-4">
          <div class="grid grid-cols-1 md:grid-cols-2 gap-4 mt-4">
            <button v-if="!client.email_verified_at"
              @click="approveClient(client.id)"
              class="px-4 py-2 bg-orange-500 text-white rounded hover:bg-orange-600"
            >
              Verify
            </button>
            <span v-else class="px-4 py-2 bg-green-500 text-white rounded hover:bg-green-600">Verified</span>
            <button class="end" type="button" @click="openSummaryModal(client)">
              Summary
            </button>
          </div>
        </div>
      </div>
    </div>

    <!-- Modal Section -->
    <div v-if="showModal" class="fixed inset-0 z-50 bg-black bg-opacity-50 flex justify-center items-center">
      <div class="bg-white p-6 rounded-lg shadow-lg max-w-lg w-full">
        <h2 class="text-xl font-semibold">{{ selectedClient.name }}'s Information</h2>
        <!-- { "id": 44, "name": "rebeca", "username": "souza", "email": "rebecasouzasilva345@gmail.com", "email_verified_at": "2024-09-13T14:06:05.000000Z", "role": "client", "avatar": null, "google_token_expires_at": null, "created_at": "2024-09-13T14:04:16.000000Z", "updated_at": "2025-01-09T03:07:14.000000Z", "purchased_package": null, "criteria_limit": 0, "package_purchased_at": null, "criteria": null, "profile": { "id": 36, "user_id": 44, "name": "rebeca", "matchmaker_id": null, "city": "", "state": "", "country": "", "location": null, "age": 0, "gender": null, "bodytype": null, "ethnicity": null, "height": null, "inches": 0, "haircolor": null, "maritalstatus": null, "children": null, "religion": null, "smoker": null, "drinker": null, "education": null, "occupation": null, "yearsexperience": null, "jobtitle": null, "sports": null, "hobbies": null, "languages": null, "bio": null, "profile_image1": null, "profile_image2": null, "created_at": "2024-09-13T14:04:16.000000Z", "updated_at": "2024-09-13T14:04:16.000000Z" } }  -->
        <p><strong>Username:</strong> {{ selectedClient.username }}</p>
        <p><strong>Email:</strong> {{ selectedClient.email }}</p>
        <p><strong>Joined At:</strong> {{ selectedClient.created_at }}</p>
        <p><strong>Last Update:</strong> {{ selectedClient.updated_at }}</p>
        <p><strong>Country:</strong> {{ selectedClient.profile.country }}</p>
        <p><strong>State:</strong> {{ selectedClient.profile.state }}</p>
        <p><strong>City:</strong> {{ selectedClient.profile.city }}</p>
        <p><strong>Age:</strong> {{ selectedClient.profile.age }}</p>
        <p><strong>Children:</strong> {{ selectedClient.profile.children }}</p>
        <p><strong>Verification Status:</strong> {{ selectedClient.email_verified_at ? 'Verified' : 'Not Verified' }}</p>
        <button @click="closeModal" class="mt-4 px-4 py-2 bg-red-500 text-white rounded hover:bg-red-600">Close</button>
      </div>
    </div>

  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      authorization:this.$store.state.auth.authorization,
      clients: [],
      showModal: false,
      selectedClient: null,
    };
  },
  mounted() {
    this.fetchClients();
  },
  methods: {
    async fetchClients() {
        this.processing = true
        axios.defaults.headers.common.Authorization = `Bearer ${this.authorization.token}` 
        await axios.get('/api/admin/clients')
          .then((response) => {                                              
            this.clients = response.data.data;
        }).catch((error)=>{
            console.error(error);
        }).finally(()=>{
            this.processing = false
        })
    },
    // Open the modal and pass the selected client data
    openSummaryModal(client) {
      this.selectedClient = client;
      this.showModal = true;
    },
    
    // Close the modal
    closeModal() {
      this.showModal = false;
      this.selectedClient = null; // Reset the selected client
    },
  },
};
</script>


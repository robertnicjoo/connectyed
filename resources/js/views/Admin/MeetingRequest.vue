<template>
  <div class="p-6 bg-gray-50 rounded-lg shadow-lg mx-auto">
    <!-- Tabs -->
    <div class="mb-4">
      <ul class="flex border-b">
        <li @click="activeTab = 1" :class="activeTab === 1 ? 'border-blue-500 text-blue-600' : 'border-transparent text-gray-600'" class="mr-6 cursor-pointer py-2 px-4 text-sm font-medium">Requests</li>
        <li @click="activeTab = 2" :class="activeTab === 2 ? 'border-blue-500 text-blue-600' : 'border-transparent text-gray-600'" class="cursor-pointer py-2 px-4 text-sm font-medium">Request Form</li>
      </ul>
    </div>

    <!-- Tab Content -->
    <div v-if="activeTab === 1">
      <!-- Requests Tab (Meetings) -->
      <div v-if="serverData.length > 0">
        <div class="grid grid-cols-1 gap-4">

          <div class="overflow-x-auto">
            <table class="min-w-full table-auto bg-white shadow-sm rounded-lg">
              <thead>
                <tr class="bg-gray-100 border-b">
                  <th class="px-4 py-2 text-left">Code</th>
                  <th class="px-4 py-2 text-left">First Party</th>
                  <th class="px-4 py-2 text-left">Selected date times</th>
                  <th class="px-4 py-2 text-left">Timezone</th>
                  <th class="px-4 py-2 text-left">Second Party</th>
                  <th class="px-4 py-2 text-left">Approved date time</th>
                  <th class="px-4 py-2 text-left">Finished</th>
                  <th class="px-4 py-2 text-left">Requested At</th>
                  <th class="px-4 py-2 text-left">Requested By</th>
                  <th class="px-4 py-2 text-left">Manage</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="meeting in serverData" :key="meeting.id" class="border-b">
                  <td class="px-4 py-2">{{ meeting.code }}</td>
                  <td class="px-4 py-2">
                    <span v-if="meeting.first_party && meeting.first_party.name">{{ meeting.first_party.name }}</span>
                    <span v-else>-</span>
                  </td>
                  <td class="px-4 py-2">
                    <ol class="list-decimal pl-5">
                      <li>{{ formatDate(meeting.start_date_one) }}</li>
                      <li>{{ formatDate(meeting.start_date_two) }}</li>
                      <li>{{ formatDate(meeting.start_date_three) }}</li>
                    </ol>
                  </td>
                  <td class="px-4 py-2">{{ meeting.timezone }}</td>
                  <td class="px-4 py-2">
                    <span v-if="meeting.second_party && meeting.second_party.name">{{ meeting.second_party.name }}</span>
                    <span v-else>-</span>
                  </td>
                  <td class="px-4 py-2">
                    <span v-if="meeting.chosen_date">{{ formatDate(meeting.chosen_date) }}</span>
                    <span v-else>-</span>
                  </td>
                  <td class="px-4 py-2">{{ meeting.finished ? 'Yes' : 'No' }}</td>
                  <td class="px-4 py-2">{{ formatDate(meeting.created_at) }}</td>
                  <td class="px-4 py-2">
                    <span v-if="meeting.user && meeting.user.name">{{ meeting.user.name }}</span>
                    <span v-else>-</span>
                  </td>
                  <td class="px-4 py-2">
                    <button 
                    v-if="meeting.second_party == null"
                      @click="openModal(meeting)"
                      class="bg-green-500 text-white px-4 py-2 rounded-lg hover:bg-green-600 focus:outline-none focus:ring-2 focus:ring-green-500 focus:ring-opacity-50">
                      Send Invitation
                    </button>
                    <span v-else>-</span>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>

          <div v-if="showModal" class="fixed inset-0 bg-gray-900 bg-opacity-50 flex items-center justify-center z-50">
            <div class="bg-white p-6 rounded-lg shadow-lg w-full sm:w-2/3 md:w-1/2 lg:w-1/3 max-h-[80%] overflow-auto">
              <h3 class="text-xl font-semibold mb-4">Send Invitation</h3>
              <p class="mb-4">Date and times will be automatically included in the email that the user receives.</p>
              
              <!-- User Dropdown -->
              <div class="mb-4">
                <label for="userSelect" class="block text-sm font-medium text-gray-700 mb-2">Select Second Party</label>
                <select 
                  id="userSelect" 
                  v-model="selectedUserId" 
                  class="block w-full p-2 border rounded-lg mb-4"
                  required
                >
                  <option value="" disabled>Select a user</option>
                  <option v-for="user in users" :key="user.id" :value="user.id">
                    {{ user.name }}
                  </option>
                </select>
              </div>

              <!-- Textarea -->
              <textarea 
                v-model="invitationMessage" 
                placeholder="Write your message..." 
                rows="6" 
                class="w-full p-2 border rounded-lg mb-4" 
                required
              ></textarea>

              <!-- Buttons -->
              <div class="flex justify-end">
                <button 
                  @click="sendInvitation" 
                  class="bg-blue-500 text-white px-4 py-2 rounded-lg hover:bg-blue-600 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-opacity-50">
                  Send
                </button>
                <button 
                  @click="showModal = false" 
                  class="ml-2 bg-gray-500 text-white px-4 py-2 rounded-lg hover:bg-gray-600 focus:outline-none focus:ring-2 focus:ring-gray-500 focus:ring-opacity-50">
                  Close
                </button>
              </div>
            </div>
          </div>

        </div>
      </div>
      <div v-else>
        <p>No requests available.</p>
      </div>
    </div>

    <div v-if="activeTab === 2">
      <!-- Request Form Tab -->
      <form @submit.prevent="submitAppointment">
        <label for="receiver" class="block text-sm font-medium text-gray-700 mb-2">
          Select the receiver of your request:
        </label>
        <select
          id="receiver"
          v-model="selectedReceiver"
          class="block w-full p-2 border rounded-lg mb-4"
          required
        >
          <option value="" disabled>Select Receiver</option>
          <option v-for="receiver in users" :key="receiver.id" :value="receiver.id">
            {{ receiver.name }}
          </option>
        </select>

        <label for="adminMessage" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Your message to receiver</label>
        <textarea v-model="adminMessage" required id="adminMessage" rows="4" class="block p-2.5 w-full text-sm text-gray-900 bg-gray-50 rounded-lg border border-gray-300 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" placeholder="Write your thoughts here..."></textarea>

        <button
          type="submit"
          class="mt-6 bg-blue-600 text-white px-4 py-2 rounded-lg shadow-lg hover:bg-blue-700 w-full"
        >
          Send Availability Request
        </button>
      </form>
    </div>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "AppointmentForm",
  data() {
    return {
      showModal: false,
      invitationMessage: "",
      selectedUserId: "",
      selectedMeeting: null,
      activeTab: 1, // Set default active tab to "Requests"
      users: [],
      serverData: [],
      adminMessage: "",
      selectedReceiver: "",
    };
  },
  computed: {
    user() {
      return this.$store.state.auth.user;
    },
  },
  methods: {
    openModal(meeting) {
      this.selectedMeeting = meeting;
      this.showModal = true;
    },
    async sendInvitation() {
      if (this.selectedUserId === "" || this.invitationMessage.trim() === "") {
        alert("Please select a user and write a message before sending.");
        return;
      }

      // Dynamically get the start dates from the selected meeting
      const meetingData = {
        start_date_one: this.selectedMeeting.start_date_one,
        start_date_two: this.selectedMeeting.start_date_two,
        start_date_three: this.selectedMeeting.start_date_three,
      };

      const payload = {
        ...meetingData,
        receiver: this.selectedUserId,
        admin_message: this.invitationMessage,
        code: this.selectedMeeting.code,
      };

      // Simulate API call or log the data
      console.log("Sending invitation with payload:", payload);

      ///////////////
      try {
        const response = await axios.post("/api/admin/send-meeting-request-second-party", {
          payload: payload,
        });

        if (response.data.success) {
          this.getData();
        } else {
          alert("Failed to submit the appointment. Please try again.");
        }
      } catch (error) {
        console.error("Error submitting appointment:", error);
        alert("An error occurred while submitting the appointment.");
      }
      ///////////////
      // Close the modal after sending
      this.showModal = false;
    },
    async getData() {
      try {
        const response = await axios.get("/api/admin/get-request-data");

        if (response.data.success) {
          this.serverData = response.data.data;
        } else {
          alert("Failed to submit the appointment. Please try again.");
        }
      } catch (error) {
        console.error("Error submitting appointment:", error);
        alert("An error occurred while submitting the appointment.");
      }
    },
    async submitAppointment() {
      try {
        const response = await axios.post("/api/admin/send-meeting-request", {
          user_id: this.user.id,
          admin_message: this.adminMessage,
          receiver: this.selectedReceiver,
        });

        if (response.data.success) {
          this.serverData = response.data.data;
        } else {
          alert("Failed to submit the appointment. Please try again.");
        }
      } catch (error) {
        console.error("Error submitting appointment:", error);
        alert("An error occurred while submitting the appointment.");
      }
    },
    async getUsers() {
      try {
        const response = await axios.get("/api/admin/clients");

        if (response.data.success) {
          this.users = response.data.data;
        } else {
          alert("Failed to load users. Please try again.");
        }
      } catch (error) {
        console.error("Error loading users:", error);
        alert("An error occurred while loading users.");
      }
    },
    formatDate(timestamp) {
      const date = new Date(timestamp);
      return date.toLocaleString('en-US', {
        weekday: 'short', // Day of the week (e.g., Mon)
        month: 'short',   // Month (e.g., Jan)
        day: 'numeric',   // Day (e.g., 22)
        year: 'numeric',  // Year (e.g., 2025)
        hour: '2-digit',  // Hour (e.g., 09)
        minute: '2-digit',// Minute (e.g., 00)
        second: '2-digit',// Second (e.g., 00)
        hour12: false,     // 12-hour format (AM/PM)
      });
    },
  },
  mounted() {
    this.getUsers();
    this.getData();
  },
};
</script>


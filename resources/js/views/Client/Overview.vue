<template>
<div ></div>
  <div :class="serverData.length > 0 || serverDataOld.length > 0 ? 'w-full' : 'max-w-7xl'" class="p-6 bg-gray-50 rounded-lg shadow-lg mx-auto">
    <h2 class="text-xl font-bold mb-4">Welcome {{ user && user.name ? user.name : 'Guest' }}!</h2>

    <div v-if="serverData.length > 0">
      <p>Meetings created successfully</p>
      <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
        <div v-for="meeting in serverData" :key="meeting.google_meet_id" class="card p-4 mb-3 shadow-sm bg-white rounded-lg">
          <p><strong>ID:</strong> {{ meeting.google_meet_id }}</p>
          <p><strong>Meeting Link:</strong> <a class="text-[#f24570] hover:text-[#213366]" :href="meeting.google_meet_link" target="_blank">
            Open
          </a></p>
          <p><strong>Meeting Start Link:</strong> <a class="text-[#f24570] hover:text-[#213366]" :href="JSON.parse(meeting.meeting_response).start_url" target="_blank">
            Open
          </a></p>
          <p><strong>Timezone:</strong> {{ JSON.parse(meeting.meeting_response).timezone }}</p>
          <p><strong>Start At:</strong> <span class="text-[#213366] font-semibold">{{ formatDate(meeting.start_time) }}</span></p>
          <p><strong>Password:</strong> {{ meeting.google_meet_password }}</p>
          <p><strong>Duration:</strong> {{ meeting.duration }} Minutes</p>
        </div>
      </div>
    </div>
    <div v-else-if="serverDataOld.length > 0">
      <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
        <div v-for="meeting in serverDataOld" :key="meeting.id" class="card p-4 mb-3 shadow-sm bg-white rounded-lg">
          <p><strong>ID:</strong> {{ meeting.google_meet_id }}</p>
          <p><strong>Meeting Link:</strong> <a class="text-[#f24570] hover:text-[#213366]" :href="meeting.google_meet_link" target="_blank">
            Open
          </a></p>
          <p><strong>Start At:</strong> <span class="text-[#213366] font-semibold">{{ formatDate(meeting.start_time) }}</span></p>
          <p><strong>Status:</strong> {{ meeting.status }}</p>
          <p><strong>Duration:</strong> {{ meeting.duration }} Minutes</p>
        </div>
      </div>
    </div>
    <div v-else>
      <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
        <!-- optional message -->
        <div class="p-4">
          <p>Before you proceed, we need to verify your identity.</p>
          <p>
            This optional meeting with our administrators is designed to confirm your identity. While you may choose to skip this step, we encourage you to review the
            <button
              @click="openModal"
              class="text-blue-500 hover:underline focus:outline-none"
            >
              benefits of identity verification
            </button>
            to make an informed decision.
          </p>

          <!-- Modal -->
          <div
            v-if="isModalOpen"
            class="fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-50"
            @click.self="closeModal"
          >
            <div class="relative max-w-lg rounded-lg bg-white p-6 shadow-lg">
              <button
                @click="closeModal"
                class="absolute right-4 top-4 text-gray-400 hover:text-gray-600 focus:outline-none"
              >
                &times;
              </button>
              <h2 class="mb-4 text-xl font-semibold">Benefits of Identity Verification</h2>
              <div class="max-h-80 overflow-y-auto">
                <ul class="list-disc space-y-2 pl-6 text-gray-700">
                  <li>Enhances trust and safety across our platform for everyone.</li>
                  <li>Increases your chances of finding genuine and compatible matches.</li>
                  <li>Ensures the profiles you interact with are authentic and verified.</li>
                  <li>Creates a safer environment for meaningful connections.</li>
                  <li>Helps us offer personalized recommendations based on your verified profile.</li>
                </ul>
              </div>
            </div>
          </div>
        </div>

        <!-- Appointment Form -->
        <form @submit.prevent="submitAppointment">
          <label for="timezone" class="block text-sm font-medium text-gray-700 mb-2">
            Select the timezone you will be located in when your date occurs:
          </label>
          <select
            id="timezone"
            v-model="selectedTimezone"
            class="block w-full p-2 border rounded-lg mb-4"
            required
          >
            <option value="" disabled>Select Timezone</option>
            <option v-for="timezone in timezones" :key="timezone.value" :value="timezone.value">
              {{ timezone.label }}
            </option>
          </select>

          <p class="text-sm font-medium text-gray-700 mb-2">
            Then please share your soonest available options.
          </p>

          <!-- Dropdowns for date and time -->
          <div class="space-y-4">
            <div v-for="(slot, index) in appointmentSlots" :key="index" class="flex space-x-4">
              <!-- Date -->
              <select
                v-model="slot.date"
                class="block w-1/3 p-2 border rounded-lg"
                @change="validateSlot(index)"
                required
              >
                <option value="" disabled>Select Date</option>
                <option v-for="date in availableDates" :key="date" :value="date">
                  {{ date }}
                </option>
              </select>

              <!-- Start Time -->
              <select
                v-model="slot.startTime"
                class="block w-1/3 p-2 border rounded-lg"
                :disabled="!slot.date"
                @change="setEndTime(index)"
                required
              >
                <option value="" disabled>Start Time</option>
                <option
                  v-for="time in filteredStartTimes(index)"
                  :key="time"
                  :value="time"
                >
                  {{ time }}
                </option>
              </select>

              <!-- End Time -->
              <input
                type="text"
                :value="slot.endTime"
                class="block w-1/3 p-2 border rounded-lg bg-gray-100 cursor-not-allowed"
                readonly
              />
            </div>
          </div>

          <button
            type="submit"
            class="mt-6 bg-blue-600 text-white px-4 py-2 rounded-lg shadow-lg hover:bg-blue-700 w-full"
          >
            Submit Appointment
          </button>
        </form>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "AppointmentForm",
  data() {
    return {
      isModalOpen: false,
      serverDataOld: [],
      serverData: [],
      selectedTimezone: "",
      timezones: [
        { label: "Pacific Time (Los Angeles)", value: "America/Los_Angeles" },
        { label: "Mountain Time", value: "America/Denver" },
        { label: "Central Time", value: "America/Chicago" },
        { label: "Eastern Time", value: "America/New_York" },
      ],
      appointmentSlots: [
        { date: "", startTime: "", endTime: "" },
        { date: "", startTime: "", endTime: "" },
        { date: "", startTime: "", endTime: "" },
      ],
      availableDates: [], // To be populated dynamically
      availableTimes: [], // To be populated dynamically
    };
  },
  computed: {
    user() {
      return this.$store.state.auth.user;
    },
  },
  methods: {
    openModal() {
      this.isModalOpen = true;
    },
    closeModal() {
      this.isModalOpen = false;
    },
    generateAvailableDates() {
      const dates = [];
      const today = new Date();

      for (let i = 0; i < 14; i++) {
        const date = new Date(today);
        date.setDate(today.getDate() + i);

        // Format the date as "Day, Mon DD"
        const formattedDate = date.toLocaleDateString("en-US", {
          weekday: "short",
          month: "short",
          day: "numeric",
        });

        dates.push(formattedDate);
      }

      this.availableDates = dates;
    },
    generateAvailableTimes() {
      const times = [];
      const startHour = 16; // 4 PM
      const endHour = 18; // 6 PM

      for (let hour = startHour; hour < endHour; hour++) {
        for (let minute = 0; minute < 60; minute += 15) {
          const time = `${hour % 12 || 12}:${minute === 0 ? "00" : minute} ${
            hour >= 12 ? "PM" : "AM"
          }`;
          times.push(time);
        }
      }

      this.availableTimes = times;
    },
    setEndTime(index) {
      const slot = this.appointmentSlots[index];
      const startTimeIndex = this.availableTimes.indexOf(slot.startTime);

      if (startTimeIndex !== -1 && startTimeIndex < this.availableTimes.length - 1) {
        slot.endTime = this.availableTimes[startTimeIndex + 1]; // Set end time to 15 minutes after start
      } else {
        slot.endTime = ""; // Reset end time if invalid
      }

      this.validateSlot(index);
    },
    validateSlot(index) {
      const slot = this.appointmentSlots[index];

      // Ensure the same date and time combination isn't used in other slots
      for (let i = 0; i < this.appointmentSlots.length; i++) {
        if (i !== index) {
          const otherSlot = this.appointmentSlots[i];
          if (
            slot.date === otherSlot.date &&
            slot.startTime === otherSlot.startTime &&
            slot.endTime === otherSlot.endTime
          ) {
            alert("This time slot is already selected in another dropdown. Please choose a different slot.");
            slot.startTime = "";
            slot.endTime = "";
            return;
          }
        }
      }
    },
    filteredStartTimes(index) {
      const slot = this.appointmentSlots[index];
      const selectedTimesForSameDate = this.appointmentSlots
        .filter(s => s.date === slot.date && s !== slot) // Only slots with the same date
        .map(s => s.startTime);

      return this.availableTimes.filter(
        time => !selectedTimesForSameDate.includes(time) || slot.startTime === time
      );
    },
    async submitAppointment() {
      try {
        const response = await axios.post("/api/google/appointment-meeting", {
          pickadate: false,
          user_id: this.user.id,
          timezone: this.selectedTimezone,
          slots: this.appointmentSlots,
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
    async getAppointments() {
      try {
        const response = await axios.post("/api/google/pending-appointment-meeting", {
          user_id: this.user.id,
        });

        if (response.data.success) {
          this.serverDataOld = response.data.data;
        } else {
          alert("Failed to submit the appointment. Please try again.");
        }
      } catch (error) {
        console.error("Error submitting appointment:", error);
        alert("An error occurred while submitting the appointment.");
      }
    },
  },
  mounted() {
    this.generateAvailableDates();
    this.generateAvailableTimes();
    this.getAppointments();
  },
};
</script>

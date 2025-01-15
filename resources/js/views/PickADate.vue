<template>
    <div class="mx-auto max-w-7xl py-6 sm:px-6 lg:px-8 flex items-center justify-center">
        <div v-if="serverData != null">
            <div class="grid grid-cols-1 gap-4">
                <p class="text-green-500 font-bold text-5xl">Your form submitted successfully</p>
                <p>We will send your further information via email.</p>
            </div>
        </div>
        <div v-else class="w-full max-w-sm mt-20">
            <h2 class="text-xl font-bold mb-4">Welcome {{ user && user.name ? user.name : 'Guest' }}!</h2>
            <div class="font-bold text-xl mb-2">Select your availability</div>
            <div class="p-6 bg-gray-50 rounded-lg shadow-lg mx-auto max-w-md">
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
                        Then please share your soonest available options. Second party will join you in a meeting in one of the following date and times.
                    </p>
                    
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
                        Submit the form
                    </button>
                </form>
            </div>
        </div>
    </div>
  </template>
  
  <script>
  export default {
    data() {
      return {
        serverData: {},
        availableDates: [], // To be populated dynamically
        availableTimes: [], // To be populated dynamically
        selectedTimezone: "",
        timezones: [
            { label: "Pacific Time (Los Angeles)", value: "America/Los_Angeles" },
            { label: "Mountain Time", value: "America/Denver" },
            { label: "Central Time", value: "America/Chicago" },
            { label: "Eastern Time", value: "America/New_York" },
        ],
        appointmentSlots: [
          { date: '', startTime: '', endTime: '' },
          { date: '', startTime: '', endTime: '' },
          { date: '', startTime: '', endTime: '' },
        ],
      };
    },
    computed: {
        routeId() {
            return this.$route.params.id;
        },
        user() {
            return this.$store.state.auth.user;
        },
    },
    methods: {
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
        filteredStartTimes(index) {
            const slot = this.appointmentSlots[index];
            const selectedTimesForSameDate = this.appointmentSlots
            .filter(s => s.date === slot.date && s !== slot) // Filter out the current slot
            .map(s => s.startTime);
            
            return this.availableTimes.filter(
            time => !selectedTimesForSameDate.includes(time) || slot.startTime === time
            );
        },
        setEndTime(index) {
            const slot = this.appointmentSlots[index];
            const startTimeIndex = this.availableTimes.indexOf(slot.startTime);
    
            if (startTimeIndex !== -1 && startTimeIndex < this.availableTimes.length - 1) {
            slot.endTime = this.availableTimes[startTimeIndex + 1]; // Set end time to 15 minutes after start
            } else {
            slot.endTime = ""; // Reset end time if invalid
            }
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
        async submitAppointment() {
            try {
                const response = await axios.post("/api/admin/availability-response", {
                    pickadate: true,
                    route_id: this.routeId,
                    user_id: this.user.id,
                    timezone: this.selectedTimezone,
                    slots: this.appointmentSlots,
                });

                if (response.data.success) {
                    this.serverData = response.data.data;
                } else {
                    alert("Failed to submit the data. Please try again.");
                }
            } catch (error) {
                console.error("Error submitting data:", error);
                alert("An error occurred while submitting the data.");
            }
        },
        async getData() {
            try {
                const response = await axios.post("/api/admin/get-availability-form", {
                    route_id: this.routeId,
                    user_id: this.user.id,
                });

                if (response.data.success) {
                    this.serverData = response.data.data;
                    console.log('response.data.data:', response.data.data);
                } else {
                    alert("Failed to submit the data. Please try again.");
                }
            } catch (error) {
                console.error("Error submitting data:", error);
                alert("An error occurred while submitting the data.");
            }
        },
    },
    mounted() {
        this.generateAvailableDates();
        this.generateAvailableTimes();
        this.getData();
    },
  };
  </script>
  
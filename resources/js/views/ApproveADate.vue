<template>
    <div class="mx-auto max-w-7xl py-6 sm:px-6 lg:px-8 flex items-center justify-center">
        <div v-if="serverData != null && serverData.chosen_date != null">
            <div class="grid grid-cols-1 gap-4">
                <p class="text-green-500 font-bold text-5xl">Your form submitted successfully</p>
                <p>We will send your further information via email.</p>
            </div>
        </div>
        <div v-else class="w-full max-w-sm mt-20">
            <h2 class="text-xl font-bold mb-4">Welcome {{ user && user.name ? user.name : 'Guest' }}!</h2>
            <div class="p-6 bg-gray-50 rounded-lg shadow-lg mx-auto max-w-md">
                <form @submit.prevent="submitAppointment">
                    <p>Hearby I confirm the meeting on {{ name }}</p>
                    <button
                        type="submit"
                        class="mt-6 bg-blue-600 text-white px-4 py-2 rounded-lg shadow-lg hover:bg-blue-700 w-full"
                        >
                        I Confirm
                    </button>
                </form>
            </div>
        </div>
    </div>
  </template>
  
  <script>
  export default {
    props: ['id', 'name'],
    data() {
      return {
        serverData: {},
      };
    },
    computed: {
        routeId() {
            return this.id;
        },
        routeName() {
            return this.name;
        },
        user() {
            return this.$store.state.auth.user;
        },
    },
    methods: {
        async submitAppointment() {
            try {
                const response = await axios.post("/api/admin/confirmation-response", {
                    route_id: this.routeId,
                    field_name: this.routeName,
                    user_id: this.user.id,
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
                const response = await axios.post("/api/admin/get-availability-second-party", {
                    route_id: this.routeId,
                    name: this.routeName,
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
        this.getData();
    },
  };
  </script>
  
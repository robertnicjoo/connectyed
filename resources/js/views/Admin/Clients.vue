<template>
    <div class="p-8 bg-gray-100 min-h-screen">
        <h1 class="text-2xl font-bold mb-6 text-gray-700">
            List of registered clients
        </h1>

        <div v-if="clients.length === 0" class="text-gray-500">
            No clients Registered
        </div>

        <div
            v-else
            class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6"
        >
            <div
                v-for="(client, index) in clients"
                :key="client.id"
                class="p-6 bg-white shadow-md rounded-lg"
            >
                <div v-if="client.profile">
                    <div v-if="client.profile.profile_image1">
                        <img
                            :src="client.profile.profile_image1"
                            alt="Profile Image 1"
                            class="w-full h-48 object-cover rounded-lg"
                        />
                    </div>
                    <h2 class="text-lg font-semibold text-[#213366]">
                        <router-link :to="`/${client.username}`">
                            {{ index+1 }}: {{ client.name }}
                        </router-link>
                    </h2>
                    <p class="text-gray-500 break-words">{{ client.email }}</p>

                    <!-- Location -->
                    <p class="text-gray-500">
                        <i
                            v-if="
                                client.profile.city ||
                                client.profile.state ||
                                client.profile.country
                            "
                            class="fas fa-map-marker-alt mr-2"
                        ></i>
                        <span v-if="client.profile.city"
                            >{{ client.profile.city }},</span
                        >
                        <span v-if="client.profile.state"
                            >{{ client.profile.state }},</span
                        >
                        <span v-if="client.profile.country">{{
                            client.profile.country
                        }}</span>
                    </p>

                    <!-- Age and Years of Experience -->
                    <p class="text-gray-500">Age: {{ client.profile.age }}</p>
                    <p class="text-gray-500">
                        Joined At: {{ formatDate(client.profile.created_at) }}
                    </p>
                </div>
                <div v-else>
                    <h2 class="text-lg font-semibold text-[#213366]">
                        {{ client.name }}
                    </h2>
                    <p class="text-gray-500 break-words">{{ client.email }}</p>
                </div>

                <div class="mt-4">
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4 mt-4">
                        <button
                            v-if="!client.email_verified_at"
                            @click="approveClient(client.id)"
                            class="px-4 py-2 bg-orange-500 text-white rounded hover:bg-orange-600"
                        >
                            Verify
                        </button>
                        <span
                            v-else
                            class="px-4 py-2 bg-green-500 text-white rounded hover:bg-green-600"
                            >Verified</span
                        >
                        <button
                            class="flex-1 px-4 py-2 bg-gray-100 text-gray-700 rounded-md hover:bg-gray-200 transition-colors"
                            type="button"
                            @click="openSummaryModal(client)"
                        >
                            View Details
                        </button>

                        <!-- <button 
              @click="deleteUser(client.id)"
              class="px-4 py-2 bg-red-500 text-white rounded hover:bg-red-600">
              Delete
            </button> -->

                        <!-- Confirmation Modal -->
                        <div
                            v-if="showConfirmDelete"
                            class="fixed inset-0 bg-indigo-600 bg-opacity-25 flex justify-center items-center z-50"
                        >
                            <div class="bg-white p-6 rounded-lg shadow-lg">
                                <h3 class="text-xl font-bold mb-4">
                                    Are you sure you want to delete this client?
                                </h3>
                                <div class="flex justify-end space-x-4">
                                    <button
                                        @click="cancelDelete"
                                        class="px-4 py-2 bg-gray-400 text-white rounded"
                                    >
                                        Cancel
                                    </button>
                                    <button
                                        @click="confirmDelete"
                                        class="px-4 py-2 bg-red-500 text-white rounded"
                                    >
                                        Delete
                                    </button>
                                </div>
                            </div>
                        </div>

                        <!-- Delete Button -->
                        <button
                            @click="initiateDelete(client.id)"
                            class="px-4 py-2 bg-red-500 text-white rounded hover:bg-red-600"
                        >
                            Delete
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal Section -->
        <div
            v-if="showModal"
            class="fixed inset-0 z-50 bg-black bg-opacity-50 flex justify-center items-center"
        >
            <div
                class="bg-white p-6 rounded-lg shadow-lg max-w-lg w-full overflow-y-auto"
                style="max-height: 90vh"
            >
                <h2 class="text-xl font-semibold">
                    {{ selectedClient.name }}'s Information
                </h2>
                <p><strong>Username:</strong> {{ selectedClient.username }}</p>
                <p><strong>Email:</strong> {{ selectedClient.email }}</p>
                <p>
                    <strong>Joined At:</strong> {{ selectedClient.created_at }}
                </p>
                <p>
                    <strong>Last Update:</strong>
                    {{ selectedClient.updated_at }}
                </p>
                <p>
                    <strong>Country:</strong>
                    {{ selectedClient.profile.country }}
                </p>
                <p>
                    <strong>State:</strong> {{ selectedClient.profile.state }}
                </p>
                <p><strong>City:</strong> {{ selectedClient.profile.city }}</p>
                <p><strong>Age:</strong> {{ selectedClient.profile.age }}</p>
                <p><strong>Phone Number:</strong> {{ selectedClient.phone_number }}</p>
                <p v-if="selectedClient.profile.children">
                    <strong>Children:</strong>
                    {{ getDisplayValue(selectedClient.profile.children) }}
                </p>
                ---
                <div v-if="selectedClient.seeking">
                    <p>
                        I’m seeking a
                        {{ selectedClient.seeking.gender || "N/A" }} between
                        ages {{ selectedClient.seeking.min_age || "N/A" }} to
                        {{ selectedClient.seeking.max_age || "N/A" }} in
                        {{ selectedClient.seeking.location || "N/A" }} with the
                        following details: <br />
                        <strong>Ethnicities:</strong>
                        {{ getDisplayValue(selectedClient.seeking.ethnicity) }}
                        <br />
                        <strong>Children:</strong>
                        {{
                            selectedClient.seeking.current_kids_number || "N/A"
                        }}
                        <br />
                        <strong>Wants kids:</strong>
                        {{
                            selectedClient.seeking.desired_kids_number || "N/A"
                        }}
                        <br />
                        <strong>Hair Color:</strong>
                        {{ selectedClient.seeking.haircolor || "N/A" }} <br />
                        <strong>Body Type:</strong>
                        {{ getDisplayValue(selectedClient.seeking.bodytype) }}
                        <br />
                        <strong>Religion:</strong>
                        {{ getDisplayValue(selectedClient.seeking.religion) }}
                        <br />
                        <strong>Smoker:</strong>
                        {{ selectedClient.seeking.smoker ? "Yes" : "No" }}
                        <br />
                        <strong>Drinker:</strong>
                        {{ selectedClient.seeking.drinker || "N/A" }} <br />
                        <strong>Marital Status:</strong>
                        {{
                            getDisplayValue(
                                selectedClient.seeking.maritalstatus
                            )
                        }}
                    </p>
                </div>
                <p>
                    <strong>Verification Status:</strong>
                    {{
                        selectedClient.email_verified_at
                            ? "Verified"
                            : "Not Verified"
                    }}
                </p>
                <button
                    @click="closeModal"
                    class="mt-4 px-4 py-2 bg-red-500 text-white rounded hover:bg-red-600"
                >
                    Close
                </button>
            </div>
        </div>
    </div>
</template>

<script>
import axios from "axios";

export default {
    data() {
        return {
            authorization: this.$store.state.auth.authorization,
            clients: [],
            showModal: false,
            selectedClient: null,
            showConfirmDelete: false, // Whether to show the confirmation modal
            clientIdToDelete: null, // The client ID to be deleted
        };
    },
    mounted() {
        this.fetchClients();
    },
    methods: {
        // Initiates the deletion by showing the confirmation modal
        initiateDelete(id) {
            this.clientIdToDelete = id; // Store the client ID to be deleted
            this.showConfirmDelete = true; // Show the confirmation modal
        },

        // Cancels the deletion process
        cancelDelete() {
            this.showConfirmDelete = false; // Hide the confirmation modal
            this.clientIdToDelete = null; // Clear the client ID
        },
        // Confirms and proceeds with the deletion
        async confirmDelete() {
            this.showConfirmDelete = false; // Hide the confirmation modal
            this.processing = true;

            try {
                const response = await axios.post(
                    "/api/admin/deleteUser",
                    {
                        user_id: this.clientIdToDelete,
                    },
                    {
                        headers: {
                            Authorization: `Bearer ${this.authorization.token}`,
                        },
                    }
                );

                if (response.status === 200) {
                    // Remove the deleted client from the clients list
                    this.clients = this.clients.filter(
                        (client) => client.id !== this.clientIdToDelete
                    );
                } else {
                    console.error(
                        "Unexpected response status:",
                        response.status
                    );
                }
            } catch (error) {
                console.error(
                    "Error deleting user:",
                    error.response?.data || error.message
                );
            } finally {
                this.processing = false;
                this.clientIdToDelete = null; // Clear the client ID after deletion
            }
        },
        getDisplayValue(value) {
            if (typeof value === "string") {
                try {
                    // If the string is a valid JSON array, parse it
                    const parsedValue = JSON.parse(value);
                    if (Array.isArray(parsedValue)) {
                        return parsedValue.join(", ");
                    }
                } catch (e) {
                    // If JSON.parse fails, it's likely not a valid JSON string, so split by commas
                    return value.replace(/\\\//g, "/").split(",").join(", ");
                }
            }
            // Return 'N/A' if the value is not a valid string or empty
            return value || "N/A";
        },
        async fetchClients() {
            this.processing = true;
            axios.defaults.headers.common.Authorization = `Bearer ${this.authorization.token}`;
            await axios
                .get("/api/admin/clients")
                .then((response) => {
                    this.clients = response.data.data;
                })
                .catch((error) => {
                    console.error(error);
                })
                .finally(() => {
                    this.processing = false;
                });
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
        formatDate(dateTime) {
            const options = {
                year: "numeric",
                month: "long",
                day: "numeric",
                hour: "2-digit",
                minute: "2-digit",
            };
            return new Date(dateTime).toLocaleDateString(undefined, options);
        },
    },
};
</script>

<template>
    <div class="max-w-full mx-auto bg-white rounded-xl shadow-md overflow-hidden md:max-w-7xl sm:max-w-2xl">
        <div class="p-6 bg-gray-50">
            <!-- Tabs -->
            <div class="mb-4">
                <ul class="flex border-b">
                <li @click="activeTab = 1" :class="activeTab === 1 ? 'border-blue-500 text-blue-600' : 'border-transparent text-gray-600'" class="mr-6 cursor-pointer py-2 px-4 text-sm font-medium">Affiliate List</li>
                <li @click="activeTab = 2" :class="activeTab === 2 ? 'border-blue-500 text-blue-600' : 'border-transparent text-gray-600'" class="cursor-pointer py-2 px-4 text-sm font-medium">Create Affiliate</li>
                </ul>
            </div>
        
            <!-- Tab Content -->
            <div v-if="activeTab === 1">
                <!-- Affiliates List -->
                <div v-if="affiliates.length > 0">
                    <div class="relative overflow-x-auto">
                        <table class="w-full text-sm text-left rtl:text-right text-gray-500 dark:text-gray-400">
                            <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                                <tr class="bg-gray-100 border-b">
                                    <th scope="col" class="px-4 py-2 text-left">Code</th>
                                    <th scope="col" class="px-4 py-2 text-left">User</th>
                                    <th scope="col" class="px-4 py-2 text-left">Percentage</th>
                                    <th scope="col" class="px-4 py-2 text-left">Number of Usages</th>
                                    <th scope="col" class="px-4 py-2 text-left">Start Date</th>
                                    <th scope="col" class="px-4 py-2 text-left">Expire Date</th>
                                    <th scope="col" class="px-4 py-2 text-left">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="affiliate in affiliates" :key="affiliate.id" class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
                                <td class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">{{ affiliate.code }}</td>
                                <td class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">{{ affiliate.user.name }}</td>
                                <td class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">{{ affiliate.percentage }}%</td>
                                <td class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">{{ affiliate.number_of_usage }}</td>
                                <td class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">{{ formatDate(affiliate.start_date) }}</td>
                                <td class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">{{ formatDate(affiliate.expire_date) }}</td>
                                <td class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                    <!-- Delete Button -->
                                    <button 
                                    @click="showDeleteModal = true; deleteAffiliateId = affiliate.id"
                                    class="bg-red-500 text-white px-4 py-2 rounded-lg hover:bg-red-600 focus:outline-none focus:ring-2 focus:ring-red-500 focus:ring-opacity-50">
                                    Delete
                                    </button>
                                </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <!-- Modal -->
                    <div 
                        v-if="showDeleteModal" 
                        class="fixed inset-0 flex items-center justify-center bg-black bg-opacity-50 z-50"
                    >
                        <div class="bg-white rounded-lg p-6 w-full max-w-sm">
                        <h2 class="text-lg font-semibold mb-4">Confirm Deletion</h2>
                        <p class="mb-4">Are you sure you want to delete this affiliate?</p>
                        <div class="flex justify-end">
                            <button 
                            @click="showDeleteModal = false" 
                            class="px-4 py-2 bg-gray-300 rounded-lg mr-2 hover:bg-gray-400">
                            Cancel
                            </button>
                            <button 
                            @click="confirmDelete" 
                            class="px-4 py-2 bg-red-500 text-white rounded-lg hover:bg-red-600">
                            Delete
                            </button>
                        </div>
                        </div>
                    </div>
                </div>
                <div v-else>
                <p>No affiliates available.</p>
                </div>
            </div>
        
            <div v-if="activeTab === 2">
                <!-- Create Affiliate Form -->
                <form @submit.prevent="createAffiliate">
                    <label for="user" class="block text-sm font-medium text-gray-700 mb-2">Select Matchmaker:</label>
                    <select
                        id="user"
                        v-model="newAffiliate.user_id"
                        class="block w-full p-2 border rounded-lg mb-4"
                        required
                    >
                        <option value="" disabled>Select User</option>
                        <option v-for="user in users" :key="user.id" :value="user.id">
                        {{ user.name }}
                        </option>
                    </select>
            
                    <label for="code" class="block text-sm font-medium text-gray-700 mb-2">Affiliate Code:</label>
                    <input
                        type="text"
                        id="code"
                        v-model="newAffiliate.code"
                        class="block w-full p-2 border rounded-lg mb-4"
                        required
                    />
            
                    <label for="percentage" class="block text-sm font-medium text-gray-700 mb-2">Percentage:</label>
                    <input
                        type="number"
                        id="percentage"
                        v-model="newAffiliate.percentage"
                        class="block w-full p-2 border rounded-lg mb-4"
                        required
                    />
            
                    <label for="start_date" class="block text-sm font-medium text-gray-700 mb-2">Start Date:</label>
                    <input
                        type="date"
                        id="start_date"
                        v-model="newAffiliate.start_date"
                        class="block w-full p-2 border rounded-lg mb-4"
                        required
                    />
            
                    <label for="expire_date" class="block text-sm font-medium text-gray-700 mb-2">Expire Date:</label>
                    <input
                        type="date"
                        id="expire_date"
                        v-model="newAffiliate.expire_date"
                        class="block w-full p-2 border rounded-lg mb-4"
                        required
                    />
            
                    <button
                        type="submit"
                        class="mt-6 bg-blue-600 text-white px-4 py-2 rounded-lg shadow-lg hover:bg-blue-700 w-full"
                    >
                        Create Affiliate
                    </button>
                </form>
            </div>
        </div>
    </div>
</template>
  
<script>
  import axios from "axios";
  
  export default {
    name: "Affiliate",
    data() {
      return {
        activeTab: 1,
        affiliates: [],
        users: [],
        newAffiliate: {
          user_id: "",
          code: "",
          percentage: 0,
          start_date: "",
          expire_date: "",
        },
        showDeleteModal: false,
        deleteAffiliateId: null, // Store the ID of the affiliate to delete
      };
    },
    methods: {
      async fetchAffiliates() {
        try {
          const response = await axios.get("/api/admin/affiliates");
          this.affiliates = response.data.data;
        } catch (error) {
          console.error("Error fetching affiliates:", error);
          alert("An error occurred while fetching affiliates.");
        }
      },
      async fetchUsers() {
        try {
          const response = await axios.get("/api/admin/affiliate-matchmakers");
          this.users = response.data.data;
        } catch (error) {
          console.error("Error fetching users:", error);
          alert("An error occurred while fetching users.");
        }
      },
      async createAffiliate() {
        try {
          const response = await axios.post("/api/admin/affiliate-assign-code", this.newAffiliate);
          this.affiliates.push(response.data.data);
          this.activeTab = 1; // Switch to the affiliates list tab
        } catch (error) {
          console.error("Error creating affiliate:", error);
          alert("An error occurred while creating the affiliate.");
        }
      },
        async deleteAffiliate(id) {
            this.deleteAffiliateId = id;
            this.showDeleteModal = true; // Show the modal
        },
        async confirmDelete() {
            try {
            await axios.delete(`/api/admin/affiliates/${this.deleteAffiliateId}`);
            this.affiliates = this.affiliates.filter((affiliate) => affiliate.id !== this.deleteAffiliateId);
            this.showDeleteModal = false; // Close the modal
            } catch (error) {
            console.error("Error deleting affiliate:", error);
            alert("An error occurred while deleting the affiliate.");
            }
        },
      formatDate(date) {
        return new Date(date).toLocaleDateString();
      },
    },
    mounted() {
      this.fetchAffiliates();
      this.fetchUsers();
    },
  };
</script>
<template>
  <div>
    <h2 class="text-xl font-bold mb-4">Welcome!</h2>
    <!-- Static Overview Section -->
    <p class="text-gray-700 mb-4">
      This dashboard provides an overview of key metrics and insights into the platform's performance. Use the sections below to monitor user activity, revenue trends, and other important data points.
    </p>
    <!-- Dashboard Overview Cards -->
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
      <div v-for="(item, index) in overviewData" :key="index" class="bg-white shadow rounded p-4">
        <h3 class="text-lg font-semibold">{{ item.title }}</h3>
        <p class="text-sm text-gray-600">{{ item.description }}</p>
        <span class="text-xl font-bold text-blue-500">{{ item.value }}</span>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios"; // Import axios for API calls

export default {
  name: "overview",
  data() {
    return {
      overviewData: [], // Initialize as an empty array
    };
  },
  mounted() {
    // Fetch the data when the component is mounted
    this.fetchOverviewData();
  },
  methods: {
    async fetchOverviewData() {
      try {
        const response = await axios.get('/api/admin/overviews'); // Call the API
        this.overviewData = [
          {
            title: "Total Users",
            description: "Number of users registered on the platform.",
            value: response.data.totalUsers,
          },
          {
            title: "Active Matchmakers",
            description: "Users with 'matchmaker' role on the platform.",
            value: response.data.totalMatchmakers,
          },
          {
            title: "Total Candidates",
            description: "Users with 'candidate' role on the platform.",
            value: response.data.totalCandidates,
          },
          {
            title: "Total Clients",
            description: "Users with 'client' role on the platform.",
            value: response.data.totalClients,
          },
          {
            title: "Total Meetings",
            description: "Total number of meetings held on the platform.",
            value: response.data.totalMeetings,
          },
        ]; // Map the response data to the format you need
      } catch (error) {
        console.error("There was an error fetching the overview data:", error);
      }
    },
  },
};
</script>

<style scoped>
/* Add any specific styling if needed */
</style>

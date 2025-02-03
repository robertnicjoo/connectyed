<script setup>
import { ref, onMounted } from "vue";
import axios from "axios";

// State Variables
const socialMedias = ref([]);
const newPlatform = ref("");
const newUrl = ref("");
const editingId = ref(null);
const editPlatform = ref("");
const editUrl = ref("");
const errorMessage = ref("");

// Fetch social media links
const fetchSocialMedias = async () => {
  try {
    const response = await axios.get("/api/profile/social-media");
    socialMedias.value = response.data.data;
  } catch (error) {
    errorMessage.value = "Failed to load social media links.";
  }
};

// Add a new social media link
const addSocialMedia = async () => {
  if (!newPlatform.value || !newUrl.value) return;
  try {
    const response = await axios.post("/api/profile/social-media", {
      platform: newPlatform.value,
      url: newUrl.value,
    });
    socialMedias.value.push(response.data.data);
    newPlatform.value = "";
    newUrl.value = "";
  } catch (error) {
    errorMessage.value = "Failed to add social media link.";
  }
};

// Start editing
const startEdit = (socialMedia) => {
  editingId.value = socialMedia.id;
  editPlatform.value = socialMedia.platform;
  editUrl.value = socialMedia.url;
};

// Save edit
const saveEdit = async (id) => {
  try {
    const response = await axios.put(`/api/profile/social-media/${id}`, {
      platform: editPlatform.value,
      url: editUrl.value,
    });
    const index = socialMedias.value.findIndex((item) => item.id === id);
    socialMedias.value[index] = response.data.data;
    editingId.value = null;
  } catch (error) {
    errorMessage.value = "Failed to update social media link.";
  }
};

// Delete social media link
const deleteSocialMedia = async (id) => {
  try {
    await axios.delete(`/api/profile/social-media/${id}`);
    socialMedias.value = socialMedias.value.filter((item) => item.id !== id);
  } catch (error) {
    errorMessage.value = "Failed to delete social media link.";
  }
};

onMounted(fetchSocialMedias);
</script>

<template>
  <div class="w-full mx-auto bg-white p-6 rounded-lg shadow-md">
    <h2 class="text-2xl font-bold mb-4 text-center">Manage Social Media</h2>

    <div v-if="errorMessage" class="text-red-500 text-center mb-4">{{ errorMessage }}</div>

    <!-- Add New Social Media -->
    <div class="flex space-x-2 mb-4">
      <input v-model="newPlatform" placeholder="Platform (e.g., Twitter)" class="w-1/3 p-2 border rounded" />
      <input v-model="newUrl" placeholder="Profile URL" class="w-2/3 p-2 border rounded" />
      <button @click="addSocialMedia" class="bg-blue-500 text-white px-4 py-2 rounded">Add</button>
    </div>

    <!-- List Social Media Links -->
    <ul v-if="socialMedias.length > 0" class="space-y-2">
      <li v-for="socialMedia in socialMedias" :key="socialMedia.id" class="flex justify-between items-center p-3 border rounded">
        <div v-if="editingId === socialMedia.id" class="flex w-full space-x-2">
          <input v-model="editPlatform" class="w-1/3 p-2 border rounded" />
          <input v-model="editUrl" class="w-2/3 p-2 border rounded" />
          <button @click="saveEdit(socialMedia.id)" class="bg-green-500 text-white px-3 py-1 rounded">Save</button>
          <button @click="editingId = null" class="bg-gray-400 text-white px-3 py-1 rounded">Cancel</button>
        </div>
        <div v-else class="flex justify-between w-full">
          <span class="text-lg">
            {{ socialMedia.platform }} - 
            <a :href="socialMedia.url" target="_blank" class="text-blue-500 underline">{{ socialMedia.url }}</a>
          </span>
          <div class="space-x-2">
            <button @click="startEdit(socialMedia)" class="bg-yellow-500 text-white px-3 py-1 rounded">Edit</button>
            <button @click="deleteSocialMedia(socialMedia.id)" class="bg-red-500 text-white px-3 py-1 rounded">Delete</button>
          </div>
        </div>
      </li>
    </ul>

    <p v-else class="text-center text-gray-500 mt-4">No social media links found.</p>
  </div>
</template>

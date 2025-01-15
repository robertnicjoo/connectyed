<template>
  <div class="flex min-h-screen bg-gray-100">

    <!-- Left Sidebar Navigation Menu -->
    <div class="hidden md:block h-screen w-64 bg-[#213366] text-[#e7dccf]">
      <aside
        class="
          w-64 bg-[#213366] text-[#e7dccf] flex flex-col fixed md:relative z-50 transition-transform duration-300
        "
      >
        <!-- Platform Title Section -->
        <div class="p-6 bg-[#333333] text-white text-xl font-bold">
          {{ appname }}
        </div>

        <!-- Navigation Links -->
        <ul class="nnax">
          <!-- Dashboard -->
          <li class="mb-4">
            <router-link
              to="/admin/dashboard"
              class="block px-4 py-3 text-white hover:bg-[#e7dccf] hover:text-custom transition-colors duration-200"
              active-class="bg-[#e7dccf] text-custom"
            >
              <i class="fas fa-tachometer-alt mr-2"></i> Dashboard
            </router-link>
          </li>

          <!-- Manage Matchmakers -->
          <li class="mb-4">
            <router-link
              to="/admin/matchmakers"
              class="block px-4 py-3 text-white hover:bg-[#e7dccf] hover:text-custom transition-colors duration-200"
              active-class="bg-[#e7dccf] text-custom"
            >
              <i class="fas fa-user-friends mr-2"></i> Matchmakers
            </router-link>
          </li>

          <!-- Manage Clients -->
          <li class="mb-4">
            <router-link
              to="/admin/clients"
              class="block px-4 py-3 text-white hover:text-custom hover:bg-[#e7dccf] transition-colors duration-200"
              active-class="bg-[#e7dccf] text-custom"
            >
              <i class="fas fa-users mr-2"></i> Clients
            </router-link>
          </li>

          <!-- Blind Requests -->
          <li class="mb-4">
            <router-link
              to="/admin/blind_requests"
              class="block px-4 py-3 text-white hover:text-custom hover:bg-[#e7dccf] transition-colors duration-200"
              active-class="bg-[#e7dccf] text-custom !important"
            >
              <i class="fas fa-users mr-2"></i> Free Blind Date Request
            </router-link>
          </li>
          <!-- Meeting Requests -->
          <li class="mb-4">
            <router-link
              to="/admin/meeting_request"
              class="block px-4 py-3 text-white hover:text-custom hover:bg-[#e7dccf] transition-colors duration-200"
              active-class="bg-[#e7dccf] text-custom"
            >
            <i class="fas fa-handshake  mr-2"></i> Request availability
            </router-link>
          </li>
        </ul>
      </aside>
    </div>

    <!-- Main Content Area -->
    <div class="flex-1 p-8 bg-[#e7dccf] relative">
      <!-- Render specific content here based on the selected route -->
      <router-view />
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      appname: import.meta.env.VITE_APP_NAME,
      profile: {
        name: 'Admin',
        avatar: 'https://via.placeholder.com/150', // Admin avatar or user profile
      },
      isSidebarOpen: false, // Sidebar starts hidden on mobile
    };
  },
};
</script>

<style scoped>
.router-link-active {
  background-color: #e7dccf;
  color: #213366;
}
.text-custom {
  color: #213366 !important;
}
.nnax a:hover {
  background-color: #e7dccf !important;
  color: #213366 !important;
}
</style>

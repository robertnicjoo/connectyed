<template>
  <div class="flex min-h-screen bg-gray-100">
    <!-- Sidebar Navigation Menu -->
    <div class="hidden md:block h-screen w-64 bg-[#213366] text-[#e7dccf]">
      <aside
      class="
          w-64 bg-[#213366] text-[#e7dccf] flex flex-col fixed md:relative z-50 transition-transform duration-300
        "
      >
        <!-- Profile Section -->
        <div class="flex items-center p-4 bg-[#333333] text-white">
          <img
            v-if="profile && profile.avatar"
            :src="profile.avatar"
            alt="Profile Picture"
            class="w-12 h-12 rounded-full object-cover mr-3"
          />
          <div>
            <h2 class="text-lg font-semibold text-connectyed-button-light">
              {{ user && user.name ? user.name : 'Guest' }}
            </h2>
            <p class="text-sm text-[#e7dccf]">Client</p>
          </div>
        </div>

        <!-- Navigation Links -->
        <ul class="nnax flex-1 mt-6">
          <li v-for="item in menuItems" :key="item.title" class="mb-1">
            <router-link
              :to="'/client' + item.link"
              class="block px-4 py-3 text-white hover:bg-[#e7dccf] hover:text-custom transition-colors duration-200"
              active-class="bg-[#e7dccf] text-custom"
            >
              <font-awesome-icon :icon="item.icon" class="w-5 h-5 mr-4" />
              <span>{{ item.title }}</span>
            </router-link>
          </li>
        </ul>
      </aside>
    </div>

    <!-- Main Content Area -->
    <main class="flex-1 p-6 bg-[#e7dccf]">
      <!-- Router View Placeholder -->
      <router-view />
    </main>
  </div>
</template>

<script>
import {
  faTachometerAlt,
  faUser,
  faDollarSign,
  faEnvelope,
  faRightFromBracket,
} from '@fortawesome/free-solid-svg-icons';
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome';

export default {
  name: "ClientDashboard",
  components: {
    FontAwesomeIcon,
  },
  data() {
    return {
      faRightFromBracket,
      menuItems: [
        { title: "Dashboard", icon: faTachometerAlt, link: "/dashboard" },
        { title: "My Profile", icon: faUser, link: "/profile" },
        { title: "Billing and Subscription", icon: faDollarSign, link: "/billing" },
        { title: "Communication", icon: faEnvelope, link: "/communication" },
      ],
    };
  },
  computed: {
    user() {
      return this.$store.state.auth.user;
    },
    profile() {
      return this.$store.state.auth.profile;
    },
  }
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

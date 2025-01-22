<template>
  <header class="header bg-[#213366]">
    <nav class="navbar navbar-expand-lg">
      <a class="navbar-brand" href="#">
        <router-link :to="{ name: 'home' }" class="nav-link">
          <img src="/assets/images/logo/connectyedlogo.png" alt="Connectyed Logo" class="w-[70px]" />
        </router-link>
      </a>

      <button
        class="navbar-toggler collapsed"
        type="button"
        @click="isNavbarOpen = !isNavbarOpen"
      >
        <span class="navbar-toggler--icon"></span>
      </button>

      <div
        :class="['navbar-collapse justify-content-end', { hidden: !isNavbarOpen }]"
        id="navbarNavAltMarkup"
      >
      <div class="navbar-nav mainmenu block md:hidden">
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
              active-class="bg-[#e7dccf] text-custom"
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
              <i class="fas fa-handshake mr-2"></i> Request availability
            </router-link>
          </li>
          <li class="mb-4">
            <router-link
              to="/admin/affiliates"
              class="block px-4 py-3 text-white hover:text-custom hover:bg-[#e7dccf] transition-colors duration-200"
              active-class="bg-[#e7dccf] text-custom"
            >
              <i class="fa-brands fa-affiliatetheme mr-2"></i> Affiliates
            </router-link>
          </li>
        </ul>
      </div>


        <div class="header__more">
          <button v-if="!user?.name">
            <router-link
              :to="{ name: 'login' }"
              class="py-2 px-4 bg-blue-500 text-white"
            >
              Login
            </router-link>
          </button>
          <button v-if="user?.name" @click="logout" class="py-2 px-4 bg-red-500 text-white">
            Logout
          </button>
        </div>
      </div>
    </nav>
  </header>

  <main>
    <!-- Router View Placeholder -->
    <router-view />
  </main>

  <footer class="footer bg-gray-800 text-white">
    <p class="text-center py-4">© 2025 Connectyed</p>
  </footer>
</template>

<script setup>
import { ref, computed } from 'vue';
import { useStore } from 'vuex';
import { useRouter } from 'vue-router';

const store = useStore();
const router = useRouter();
const isNavbarOpen = ref(false);

const user = computed(() => store.state.auth.user);

const logout = () => {
  store.dispatch('auth/logout');
  router.push({ name: 'home' });
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

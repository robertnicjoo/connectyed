<template>
  <!-- Header Section Start -->
  <header class="header bg-[#213366]">
    <nav class="navbar navbar-expand-lg">
      <!-- Logo -->
      <a class="navbar-brand" href="#">
        <router-link :to="{ name: 'home' }" class="nav-link">
          <img src="/assets/images/logo/connectyedlogo.png" alt="Connectyed Logo" class="w-[70px]" />
        </router-link>
      </a>

      <!-- Mobile Navbar Toggle -->
      <button
        class="navbar-toggler collapsed"
        type="button"
        @click="isNavbarOpen = !isNavbarOpen"
      >
        <span class="navbar-toggler--icon"></span>
      </button>

      <!-- Navbar Links -->
      <div
        :class="['navbar-collapse justify-content-end', { hidden: !isNavbarOpen }]"
        id="navbarNavAltMarkup"
      >
        <!-- Dynamic Navigation Links -->
        <div class="navbar-nav mainmenu block md:hidden">
          <ul class="nnax">
            <li v-for="item in menuItems" :key="item.title" class="mb-1">
              <router-link
                :to="'/matchmaker' + item.link"
                class="block px-4 py-3 text-white hover:bg-[#e7dccf] hover:text-custom transition-colors duration-200"
                active-class="bg-[#e7dccf] text-custom"
              >
                <font-awesome-icon :icon="item.icon" class="w-5 h-5 mr-4" />
                <span>{{ item.title }}</span>
              </router-link>
            </li>
            <li class="mb-4">
              <router-link
                :to="{name: 'profiledetail', params: {username: `${user?.username}`}}"
                class="block px-4 py-3 text-white hover:bg-[#e7dccf] hover:text-custom transition-colors duration-200"
                active-class="bg-[#e7dccf] text-custom"
              >
                <font-awesome-icon :icon="faUser" class="w-5 h-5 mr-4" />
                <span>My Profile</span>
              </router-link>
            </li>
          </ul>
        </div>

        <!-- User Action Buttons -->
        <div class="header__more">
          <button v-if="!user?.name">
            <router-link :to="{ name: 'login' }" class="py-2 px-4 bg-blue-500 text-white">
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
  <!-- Header Section End -->

  <main>
    <router-view></router-view>
  </main>

  <!-- Footer Section Start -->
  <footer class="footer bg-gray-800 text-white">
    <p class="text-center py-4">
      All Rights Reserved &copy; <a href="#">Connectyed</a> || Design By: Connectyed
    </p>
  </footer>
  <!-- Footer Section End -->
</template>

<script setup>
import { faTachometerAlt, faUser, faBriefcase, faUsers, faDollarSign, faEnvelope, faTasks, faCalendar, faRightFromBracket, faEdit } from '@fortawesome/free-solid-svg-icons';
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome';
import { ref, computed } from 'vue';
import { useStore } from 'vuex';
import { useRouter } from 'vue-router';

const store = useStore();
const router = useRouter();

// Mobile Navbar state
const isNavbarOpen = ref(false);

const user = computed(() => store.state.auth.user);
const authorization = computed(() => store.state.auth.authorization);

// Menu items for the navigation
const menuItems = ref([
  { title: "Dashboard", icon: faTachometerAlt, link: "/dashboard" },        
  { title: "Edit Profile", icon: faEdit, link: "/profile" },
  { title: "My Specialties", icon: faBriefcase, link: "/specialties" },
  { title: "My Availability", icon: faCalendar, link: "/availability" },
  { title: "Clients", icon: faUsers, link: "/clients" },
  { title: "Billing and Subscription", icon: faDollarSign, link: "/billing" },
  { title: "Communication Tools", icon: faEnvelope, link: "/communication" },
  { title: "Match Management", icon: faTasks, link: "/match-management" },
]);

const logout = async () => {
  if (authorization.value && authorization.value.token) {
    const token = authorization.value.token;
    axios.defaults.headers.common.Authorization = `Bearer ${token}`;
    await axios
      .post('/api/user/logout')
      .then(() => {
        store.dispatch('auth/logout');
        router.push({ name: 'home' });
      })
      .catch((error) => {
        console.error(error);
        store.dispatch('auth/logout');
        router.push({ name: 'home' });
      });
  } else {
    store.dispatch('auth/logout');
    router.push({ name: 'home' });
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

<template>
    <div class="mx-auto max-w-7xl py-6 sm:px-6 lg:px-8 items-center justify-center">
        <div class="mx-full shadow-connectyed rounded-xl bg-connectyed-card-mm-light flex flex-col mb-5">             
            <div class="flex rounded-xl">
                <!-- Sidebar -->
                <aside class="w-72 bg-connectyed-sidenav-light text-connectyed-icon rounded-l-xl">
                    <nav class="mt-10">
                    <ul>
                        <li v-for="item in menuItems" :key="item.title" class="mb-1">
                        <router-link :to="'/matchmaker' + item.link"                            
                            class="flex items-center p-4 text-gray-300 hover:hover:bg-connectyed-card-mm-light hover:text-connectyed-textnav-dark transition-colors duration-200"
                            active-class="bg-connectyed-card-mm-light text-gray-900"
                        >
                            <font-awesome-icon :icon="item.icon" class="w-5 h-5 mr-4" />
                            <span>{{ item.title }}</span>
                        </router-link>
                        </li>
                        <li class="mb-1">
                            <button
                                @click="logout"
                                class="block w-full text-left px-4 py-3 hover:bg-[#333333] hover:text-white transition-colors duration-200"
                            >
                                <font-awesome-icon :icon="faRightFromBracket" class="w-5 h-5 mr-4" />
                                <span>Logout</span>
                            </button>
                        </li>
                    </ul>
                    </nav>
                </aside>
            
                <!-- Main Content -->
                <div class="flex-1 p-6">
                    <router-view />
                </div>
            </div>            
        </div>
    </div>   
</template>
  
<script>
import { faTachometerAlt, faUser, faBriefcase, faUsers, faDollarSign, faEnvelope, faTasks, faCalendar, faRightFromBracket } from '@fortawesome/free-solid-svg-icons';
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome';

export default {
    name:"matchmaker",
    components: {
        FontAwesomeIcon
    },
    methods: {
        async logout() {
        try {
            const response = await axios.post('/api/user/logout', {}, {
            headers: {
                Authorization: `Bearer ${this.authorization}`,
            },
            });
            this.$store.dispatch('auth/logout'); // Update Vuex state
            this.$router.push('/'); // Redirect to the login page
            console.log(response.data.message);
        } catch (error) {
            console.error('Logout failed:', error.response ? error.response.data : error.message);
        }
        },
    },
    data() {
        return {
            faRightFromBracket,
            menuItems: [
                { title: "Dashboard", icon: faTachometerAlt, link: "/dashboard" },        
                { title: "My Profile", icon: faUser, link: "/profile" },
                { title: "My Specialties", icon: faBriefcase, link: "/specialties" },
                { title: "My Availability", icon: faCalendar, link: "/availability" },
                { title: "Clients", icon: faUsers, link: "/clients" },
                { title: "Billing and Subscription", icon: faDollarSign, link: "/billing" },
                { title: "Communication Tools", icon: faEnvelope, link: "/communication" },
                { title: "Match Management", icon: faTasks, link: "/match-management" },
            ]
        };
    },
};
</script>
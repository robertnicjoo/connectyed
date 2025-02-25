import './bootstrap';
import '../css/app.css';
import Router from '@/router';
import store from '@/store';
import { createApp } from 'vue';
import App from './App.vue'; // Import your root component

// Import vue-gtag for Google Analytics
import VueGtag from 'vue-gtag';

// Initialize the store
store.dispatch('auth/initialize').then(() => {
    const app = createApp(App); // Pass App to createApp

    // Use vue-gtag for Google Analytics
    app.use(VueGtag, {
        config: { id: 'AW-16739328770' } // Replace with your Google Analytics Measurement ID
    }, Router);

    app.use(Router);
    app.use(store);
    app.mount('#app');
});

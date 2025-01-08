<template>
    <div class="min-h-screen flex flex-col justify-center items-center bg-gray-100">
      <h1 class="text-6xl font-bold text-gray-800 mb-4">404</h1>
      <p class="text-xl text-gray-600 mb-6">Oops! The page you're looking for doesn't exist.</p>
      <router-link to="/" class="bg-indigo-600 text-white px-6 py-3 rounded-lg text-lg font-semibold hover:bg-indigo-500 transition duration-300">
        Go Back Home
      </router-link>
    </div>
  </template>
  
  <script>
  export default {
    name: "NotFound",
    mounted() {
      this.addGlobalMetaTags();   
      setTimeout(() => {
        this.$router.push({ name: "home" });
      }, 3000);
    },
    methods: {
      addGlobalMetaTags() {
            // Set the title
            document.title = "Not Found | Premium Matchmaking for Busy Professionals";

            // Add meta description
            const description = document.createElement("meta");
            description.setAttribute("name", "description");
            description.setAttribute("content", "Discover personalized matchmaking services with Comnectyed. Connect with expert matchmakers who understand your needs as a busy professional and start your journey to meaningful relationships today.");
            document.head.appendChild(description);

            // Add Open Graph tags for social sharing
            const ogTitle = document.createElement("meta");
            ogTitle.setAttribute("property", "og:title");
            ogTitle.setAttribute("content", "Not Found | Premium Matchmaking for Busy Professionals");
            document.head.appendChild(ogTitle);


            const ogDescription = document.createElement("meta");
            ogDescription.setAttribute("property", "og:description");
            ogDescription.setAttribute("content", "Discover personalized matchmaking services with Comnectyed. Connect with expert matchmakers who understand your needs as a busy professional and start your journey to meaningful relationships today.");
            document.head.appendChild(ogDescription);


            const ogImage = document.createElement("meta");
            ogImage.setAttribute("property", "og:image");
            ogImage.setAttribute("content", "https://www.comnectyed.com/logo.png");
            document.head.appendChild(ogImage);


            const ogUrl = document.createElement("meta");
            ogUrl.setAttribute("property", "og:url");
            ogUrl.setAttribute("content", "https://www.comnectyed.com/notfound");
            document.head.appendChild(ogUrl);
        },
    }
  };
  </script>
  
  <style scoped>
  /* Add custom styles here if needed */
  </style>
  
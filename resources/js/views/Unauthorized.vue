<template>
    <div>
        <h1>Access Restricted</h1>
        <p>Your profile is awaiting approval by the administrator to allow you to log in to the dashboard.</p>
        <router-link to="/">Return to Home</router-link>
    </div>
</template>

<script>
    export default {
        name: 'AccessRestricted',
        mounted() {
            this.addGlobalMetaTags();
        },
        methods: {
            addGlobalMetaTags() {
                // Set the title
                document.title = "Unauthorized | Premium Matchmaking for Busy Professionals";

                // Add meta description
                const description = document.createElement("meta");
                description.setAttribute("name", "description");
                description.setAttribute("content", "Discover personalized matchmaking services with Comnectyed. Connect with expert matchmakers who understand your needs as a busy professional and start your journey to meaningful relationships today.");
                document.head.appendChild(description);

                // Add Open Graph tags for social sharing
                const ogTitle = document.createElement("meta");
                ogTitle.setAttribute("property", "og:title");
                ogTitle.setAttribute("content", "Unauthorized | Premium Matchmaking for Busy Professionals");
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
                ogUrl.setAttribute("content", "https://www.comnectyed.com/unauthorized");
                document.head.appendChild(ogUrl);
            }
        }
    };
</script>

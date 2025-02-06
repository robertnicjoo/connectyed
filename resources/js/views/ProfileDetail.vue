<template>  
    <matchmakerProfileCard :profile="profile" v-if="isMatchmaker" /> 
    <clientProfileCard :profile="profile" v-if="!isMatchmaker" />     
</template>

<script>
import matchmakerProfileCard from './Matchmaker/ProfileCard.vue';
import clientProfileCard from './Client/ProfileCard.vue';

export default {
    name: "profiledetail",
    components: {
        matchmakerProfileCard,
        clientProfileCard
    },
    data(){
      return {        
        processing: false,        
        profile: [],
        currentAvatar: '',
        isMatchmaker: false,
        matchmakerProfile: {
            name: '',
            jobTitle: '',
            description: '',
            email: '',
            image: '',
            twitter: '',
            linkedin: '',
        }
      }
    },
    mounted() {
        this.addGlobalMetaTags();
        this.getProfile();
    },
    methods: {
        addGlobalMetaTags() {
            // Set the title
            document.title = "Profile Details | Premium Matchmaking at Affordable Prices";

            // Add meta description
            const description = document.createElement("meta");
            description.setAttribute("name", "description");
            description.setAttribute("content", "Discover personalized matchmaking services with Comnectyed. Connect with expert matchmakers who understand your needs as a busy professional and start your journey to meaningful relationships today.");
            document.head.appendChild(description);

            // Add Open Graph tags for social sharing
            const ogTitle = document.createElement("meta");
            ogTitle.setAttribute("property", "og:title");
            ogTitle.setAttribute("content", "Profile Details | Premium Matchmaking at Affordable Prices");
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
            ogUrl.setAttribute("content", `https://www.comnectyed.com/${this.$route.params.username}`);
            document.head.appendChild(ogUrl);
        },
        async getProfile() {
            this.processing = true            
            const username = this.$route.params.username
            await axios.get('/api/profile/getprofileForAdmin/'+username)
                .then((response) => {
                    if (response.data) {      
                        const profile = response.data.data
                        this.currentAvatar = response.data.data.avatar
                        this.profile = profile
                        this.profile.clients = response.data.data.profile_list ?? []
                        // this.profile.specialties = response.data.data.specialties ?? []
                        // this.profile.parsedLocations = (response.data.data.specialties) ? JSON.parse(response.data.data.specialties.locations) : []
                        this.isMatchmaker = (profile.user.role === 'matchmaker' || profile.user.role === 'candidate') 
                    } else {                        
                        this.$router.push({ name: "notfound" });
                    }
                                       
            }).catch((error)=>{                
                console.log(error)
            }).finally(()=>{
                this.processing = false
            })
        }
    },
}
</script>
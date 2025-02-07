<!-- resources/js/views/Register.vue -->

<template>
  <div class="max-w-lg mx-auto p-4 bg-white relative">
    <h2 class="text-xl font-semibold mb-4">
      {{ form.ismatchmaker ? 'Matchmaker Registration' : 'Client Registration' }}
    </h2>

    <!-- Display Success Message -->
    <div v-if="successMessage" class="bg-green-200 text-green-800 p-4 mt-4 rounded">
      {{ successMessage }}
    </div>

    <!-- Display General Errors -->
    <div v-if="errors.general" class="bg-red-200 text-red-800 p-4 mt-4 rounded">
      {{ errors.general }}
    </div>

    <!-- Display Validation Errors -->
    <div v-if="validationErrorsList.length" class="bg-red-200 text-red-800 p-4 mt-4 rounded">
      <ul>
        <li v-for="(error, index) in validationErrorsList" :key="index">
          {{ error }}
        </li>
      </ul>
    </div>

    <!-- Matchmaker Switch -->
    <div class="font-bold text-xl mb-2">
      <div class="relative">
        <label class="flex items-center cursor-pointer mb-4 bg-orange-50 py-2 px-1 rounded-xl">
          <!-- Switch Container -->
          <div class="relative">
            <!-- Hidden checkbox input -->
            <input
              type="checkbox"
              v-model="form.ismatchmaker"
              class="sr-only"
              @click="switchMatchmaker"
            />

            <!-- Switch background -->
            <div
              :class="{
                'bg-connectyed-button-light': !form.ismatchmaker,
                'bg-connectyed-button-dark': form.ismatchmaker
              }"
              class="block w-14 h-8 rounded-full transition-colors duration-300"
            ></div>

            <!-- Switch handle -->
            <div
              class="dot absolute left-1 top-1 bg-white w-6 h-6 rounded-full transition-transform duration-300"
              :class="{ 'translate-x-6': form.ismatchmaker }"
            ></div>
          </div>
          <span class="ml-3 text-gray-700 text-base uppercase">
            {{ form.ismatchmaker ? 'Switch to Register as a Client' : 'Switch to Register as a Matchmaker' }}
          </span>
        </label>
      </div>
      <span class="float-right" v-if="processing">
        <img class="h-5 ml-3" src="assets/images/icons/process.gif" alt="Processing..." />
      </span>
    </div>

    <!-- Step Indicator -->
    <div class="flex items-center mb-6">
      <div v-for="(step, index) in steps" :key="index">
        <div
          @click="goToStep(step)"
          class="text-center py-2 px-3 mx-1 rounded-full cursor-pointer"
          :class="{
            'bg-connectyed-button-light text-connectyed-button-dark': currentStep === step,
            'bg-gray-200 text-gray-600': currentStep !== step
          }"
        >
          {{ step }}
        </div>
      </div>
    </div>

    <form @submit.prevent="register" enctype="multipart/form-data">
        <!-- Step 1: Account Information -->
        <div v-if="currentStep === 1">
          <h3 class="font-semibold text-lg mb-4">Account Information</h3>
          <div class="grid grid-cols-1 md:grid-cols-1 gap-1">
            <input-text
              label="Name"
              v-model="form.name"
              :required="true"
              :error="errors.name"
              maxlength="255"
            />
            <input-text
              label="Username"
              v-model="form.username"
              :required="true"
              :error="errors.username"
              maxlength="50"
            />
            <input-text
              label="Email"
              v-model="form.email"
              :required="true"
              :error="errors.email"
              maxlength="255"
              type="email"
            />
            <input-text
              label="Password"
              type="password"
              v-model="form.password"
              :required="true"
              :error="errors.password"
              maxlength="100"
            />
            <input-text
              label="Confirm Password"
              type="password"
              v-model="form.password_confirmation"
              :required="true"
              :error="errors.password_confirmation"
              maxlength="100"
            />
          </div>
        </div>

        <!-- Step 2: Profile Images & Basic Info (Matchmaker) -->
        <div v-if="currentStep === 2 && form.ismatchmaker">
          <h3 class="font-semibold text-lg mb-4">Profile Images & Basic Info</h3>

          <!-- Profile Image 1 -->
          <div class="mb-4">
            <label class="block text-gray-700">
              Upload Profile Image 1 <span class="text-red-500">*</span>
            </label>
            <input type="file" @change="onFileChange($event, 'profile_image1')" accept="image/*" required />
            <p v-if="errors.profile_image1" class="text-red-500 text-xs italic">{{ errors.profile_image1 }}</p>
          </div>

          <!-- Profile Image 2 -->
          <div class="mb-4">
            <label class="block text-gray-700">Upload Profile Image 2</label>
            <input type="file" @change="onFileChange($event, 'profile_image2')" accept="image/*" />
            <p v-if="errors.profile_image2" class="text-red-500 text-xs italic">{{ errors.profile_image2 }}</p>
          </div>

          <!-- Age -->
          <input-text
            label="Age"
            v-model="form.age"
            type="number"
            :error="errors.age"
            maxlength="3"
            min="18"
            max="100"
          />

          <!-- Years of Experience -->
          <input-text
            label="Years of Experience"
            v-model="form.yearsexperience"
            type="number"
            :error="errors.yearsexperience"
            min="0"
          />

          <!-- Bio -->
          <div class="mb-4">
            <label class="block text-gray-700">
              Bio <span class="text-red-500">*</span>
            </label>
            <textarea
              v-model="form.bio"
              placeholder="Tell us about yourself"
              class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
              required
            ></textarea>
            <p v-if="errors.bio" class="text-red-500 text-xs italic">{{ errors.bio }}</p>
          </div>
        </div>

        <!-- Step 2: Location Details (Client) -->
        <div v-if="currentStep === 2 && !form.ismatchmaker">
          <h3 class="font-semibold text-lg mb-4">Location Details</h3>
          <div class="grid grid-cols-1 md:grid-cols-1 gap-1">
            <select-option
              label="Country"
              :options="filteredCountries"
              v-model="form.country"
              :required="true"
              :error="errors.country"
              @change="handleCountrySearch(form.country)"
            />

            <!-- State Dropdown -->
            <select-option
              label="State"
              :options="filteredStates"
              v-model="form.state"
              :required="true"
              :error="errors.state"
              @change="handleStateSearch(form.state)"
            />

            <!-- City Dropdown -->
            <select-option
              label="City"
              :options="filteredCities"
              v-model="form.city"
              :required="true"
              :error="errors.city"
              @change="handleCitySearch(form.city)"
            />

            <h3 class="font-semibold text-lg mb-4">Profile Details</h3>
            <!-- Profile Image 1 -->
            <div class="mb-4">
              <label class="block text-gray-700">
                Upload Profile Image <span class="text-red-500">*</span>
              </label>
              <input 
                type="file" 
                @change="onFileChange($event, 'profile_image1')" 
                accept="image/*" 
                required
                class="block w-full text-sm text-gray-500 file:mr-4 file:py-2 file:px-4
                      file:rounded-lg file:border-0 file:text-sm file:font-semibold
                      file:bg-blue-500 file:text-white hover:file:bg-blue-600"
              />
              <p v-if="errors.profile_image1" class="text-red-500 text-xs italic">{{ errors.profile_image1 }}</p>
            </div>

            <div class="mb-4">
              <label class="block text-gray-700">
                Summarize what you are seeking in a match <span class="text-red-500">*</span>
              </label>
              <textarea
                v-model="form.seeking"
                placeholder="Please explain"
                class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                required
              ></textarea>
              <p v-if="errors.seeking" class="text-red-500 text-xs italic">{{ errors.seeking }}</p>
            </div>
          </div>
        </div>

        <!-- Step 3: Location Details (Matchmaker) -->
        <div v-if="currentStep === 3 && form.ismatchmaker">
          <h3 class="font-semibold text-lg mb-4">Location Details</h3>
          <div class="grid grid-cols-1 md:grid-cols-1 gap-1">
            <select-option
              label="Country"
              :options="filteredCountries"
              v-model="form.country"
              :required="true"
              :error="errors.country"
              @change="handleCountrySearch(form.country)"
            />

            <!-- State Dropdown -->
            <select-option
              label="State"
              :options="filteredStates"
              v-model="form.state"
              :required="true"
              :error="errors.state"
              @change="handleStateSearch(form.state)"
            />

            <!-- City Dropdown -->
            <select-option
              label="City"
              :options="filteredCities"
              v-model="form.city"
              :required="true"
              :error="errors.city"
              @change="handleCitySearch(form.city)"
            />
          </div>
        </div>

        <!-- Step 4: Terms and Privacy (Both Matchmaker and Client) -->
        <div v-if="(currentStep === 4 && form.ismatchmaker) || (currentStep === 3 && !form.ismatchmaker)">
          <h3 class="font-semibold text-lg mb-4">Terms and Conditions</h3>
          <div class="space-y-4 flex items-start">
            <label class="text-gray-500 text-sm mb-2 flex items-center">
              <input
                type="checkbox"
                v-model="form.privacypolicy"
                id="privacypolicy"
                name="privacypolicy"
                :required="true"
                class="mr-2 form-checkbox"
              />
              <span class="text-lg">I have read and agree to the</span>
            </label>
            <a
              @click="showPrivacy()"
              class="text-connectyed-link-dark cursor-pointer underline"
            >
              Privacy Policy
            </a>
          </div>
          <div class="space-y-4 flex items-start mt-2">
            <label class="text-gray-500 text-sm mb-2 flex items-center">
              <input
                type="checkbox"
                v-model="form.termsofuse"
                id="termsofuse"
                name="termsofuse"
                :required="true"
                class="mr-2 form-checkbox"
              />
              <span class="text-lg">I have read and agree to the</span>
            </label>
            <a
              @click="showTerm()"
              class="text-connectyed-link-dark cursor-pointer underline"
            >
              Terms of Use
            </a>
          </div>
        </div>

        <!-- Navigation Buttons -->
        <div class="mt-6 flex justify-between">
          <button
            v-if="currentStep > 1"
            type="button"
            class="bg-connectyed-button-pagination-light text-connectyed-button-dark py-2 px-4 rounded min-w-32 cursor-pointer"
            @click="prevStep"
          >
            Previous
          </button>
          <div class="flex-1"></div>
          <button
            v-if="currentStep < steps.length"
            type="button"
            class="bg-connectyed-button-pagination-light text-connectyed-button-dark py-2 px-4 rounded min-w-32 cursor-pointer"
            @click="nextStep"
          >
            Next
          </button>
          <button
            v-else
            class="bg-connectyed-button-light text-connectyed-button-dark hover:bg-connectyed-button-hover-light hover:text-connectyed-button-hover-dark py-2 px-4 rounded cursor-pointer"
            type="submit"
            :disabled="processing"
          >
            {{ processing ? "Please wait" : "Register" }}
          </button>
        </div>
      </form>

      <label class="my-4 w-full block text-center">
        Already have an account?
        <router-link class="text-connectyed-link-dark underline" :to="{ name: 'login' }">Login Now!</router-link>
      </label>

    <pdf-modal :isOpen="isModalOpen" :pdfUrl="pdfUrl" @close="closeModal" />
  </div>
</template>

<script>
import { mapActions } from 'vuex';
import PdfModal from '../components/PdfModal.vue';
import InputText from '../components/InputText.vue';
import SelectOption from '../components/SelectOption.vue';
import MultiSelectOption from '../components/MultiSelectOption.vue';
import { countries } from '../components/countries'; // Adjust the path as necessary

export default {
  name: "Register",
  components: {
    InputText,
    SelectOption,
    MultiSelectOption,
    PdfModal,
  },
  data() {
    return {
      currentStep: 1,
      steps: [1, 2, 3],
      form: {
        haveKids: "",
        haveKidsFuture: "",
        name: "",
        username: "",
        email: "",
        password: "",
        password_confirmation: "",
        city: "",
        state: "",
        country: "",
        age: "",
        gender: "",
        hairColor: "",
        bodyType: [],
        religion: [],
        ethnicity: [],
        heightFeet: "",
        heightInches: "",
        maritalStatus: [],
        children: [],
        smoker: false, // Initialized as boolean
        drinker: "",
        education: "",
        occupation: "",
        jobTitle: "",
        sports: "",
        hobbies: "",
        languages: [],  // This will hold an array of selected languages
        privacypolicy: false, // Initialized as boolean
        termsofuse: false,     // Initialized as boolean
        ismatchmaker: false,   // Initialized as boolean
        yearsexperience: "",
        bio: "",
        seeking: "", //New field for seeking 
        min_age: "",
        max_age: "",
        current_kids_number:"",
        desired_children:"",
        seeking_location: "",
        seeking_hair_color: "",
        seeking_gender: "",
        seeking_marital_status: "",
        seeking_smoker: "",
        seeking_drinker: "",
        seeking_ethnicity: [],
        seeking_religion: [],
        seeking_body_type: [],
      },
      errors: {},
      countries: countries,
      filteredCountries: countries.map(country => country.name), // For search functionality
      filteredStates: [], // Initially empty, will be populated based on selected country
      filteredCities: [], // Initially empty, will be populated based on selected state
      haveKidsAnswers: ['Yes', 'No'],
      genders: ['Male', 'Female', 'Other'],
      bodyTypes: ['Slender', 'Average', 'Athletic', 'Curvy', 'Big and Beautiful'],
      maritalStatuses: ['Single', 'Separated', 'Divorced', 'Married', 'Widowed'],
      childrenOptions: ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10'],
      religions: [
        'Buddhism', 'Catholic', 'Christian', 'Confucianism', 'Hinduism',
        'Islam', 'Jainism', 'Judaism', 'Shinto', 'Sikhism',
        'Taoism', 'Zoroastrianism', 'Other'
      ],
      ethnicity: ['White/Caucasian','Black/African','Hispanic/Latin','Indian','Asian/Pacific Islander','Mixed race','Other'],
      yesNoOptions: ['Yes', 'No'],
      drinkerOptions: ['None', 'Occasionally', 'Often'],
      englishLevels: ['Native', 'Beginner', 'Intermediate', 'Proficient'],
      educationLevels: ['Associates', 'Technical Associates', 'Bachelor', 'Master', 'PHD'],
      languages: [
        'English', 'Spanish', 'Mandarin', 'Hindi', 'Arabic', 'Bengali', 'Portuguese', 
        'Russian', 'Japanese', 'Punjabi', 'German', 'Javanese', 'Korean', 'French', 
        'Turkish', 'Vietnamese', 'Telugu', 'Chinese', 'Marathi', 'Tamil'
      ],
      successMessage: '',
      validationErrors: {},
      isModalOpen: false,
      pdfUrl: '',
      modalMode: {
        header: "",
      },
      processing: false,
      files: {
        profile_image1: null,
      },
      // New Data for File Uploads
      files: {
        profile_image1: null,
        profile_image2: null,
      },
    };
  },
  mounted() {
    this.addGlobalMetaTags();
  },
  computed: {
    validationErrorsList() {
      // Extract all validation errors except 'general'
      return Object.keys(this.errors)
        .filter(key => this.errors[key] && key !== 'general')
        .map(key => this.errors[key]);
    }
  },
  methods: {
    ...mapActions({
      registerUser: 'auth/register'
    }),
    addGlobalMetaTags() {
      // Set the title
      document.title = "Register | Premium Matchmaking at Affordable Prices";

      // Add meta description
      const description = document.createElement("meta");
      description.setAttribute("name", "description");
      description.setAttribute("content", "Register to Discover personalized matchmaking services with Comnectyed. Connect with expert matchmakers who understand your needs as a busy professional and start your journey to meaningful relationships today.");
      document.head.appendChild(description);

      // Add Open Graph tags for social sharing
      const ogTitle = document.createElement("meta");
      ogTitle.setAttribute("property", "og:title");
      ogTitle.setAttribute("content", "Register | Premium Matchmaking at Affordable Prices");
      document.head.appendChild(ogTitle);


      const ogDescription = document.createElement("meta");
      ogDescription.setAttribute("property", "og:description");
      ogDescription.setAttribute("content", "Register to Discover personalized matchmaking services with Comnectyed. Connect with expert matchmakers who understand your needs as a busy professional and start your journey to meaningful relationships today.");
      document.head.appendChild(ogDescription);


      const ogImage = document.createElement("meta");
      ogImage.setAttribute("property", "og:image");
      ogImage.setAttribute("content", "https://www.comnectyed.com/logo.png");
      document.head.appendChild(ogImage);


      const ogUrl = document.createElement("meta");
      ogUrl.setAttribute("property", "og:url");
      ogUrl.setAttribute("content", "https://www.comnectyed.com/register");
      document.head.appendChild(ogUrl);
    },
    // Add a new language-level pair to the form
    addLanguage() {
      if (this.form.languages.length < 4) {
        // Add an empty language-level pair
        this.form.languages.push({ language: '', level: this.englishLevels[0] });
      }
    },
    // Remove a language-level pair from the form
    removeLanguage(index) {
      this.form.languages.splice(index, 1);
    },
    // Update the available languages after each selection
    updateLanguage(index) {
      const selectedLanguage = this.form.languages[index].language;
      
      // After selecting a language, ensure it is removed from the options of other rows
      if (selectedLanguage) {
        this.form.languages.forEach((item, i) => {
          if (i !== index && item.language === selectedLanguage) {
            item.language = ''; // Clear duplicate selection
          }
        });
      }
    },
    // Get available languages for the current index (exclude already selected languages)
    availableLanguages(index) {
      const selectedLanguages = this.form.languages.map(item => item.language);
      return this.languages.filter(language => !selectedLanguages.includes(language) || language === this.form.languages[index].language);
    },
    nextStep() {
      this.clearErrors();
      let hasError = false;

      // Validate current step fields
      switch (this.currentStep) {
        case 1:
          if (!this.form.name) {
            this.errors.name = 'Name is required';
            hasError = true;
          }
          if (!this.form.username) {
            this.errors.username = 'Username is required';
            hasError = true;
          }
          if (!this.form.email) {
            this.errors.email = 'Email is required';
            hasError = true;
          } else if (!this.validateEmail(this.form.email)) {
            this.errors.email = 'Please enter a valid email';
            hasError = true;
          }
          if (!this.form.password) {
            this.errors.password = 'Password is required';
            hasError = true;
          } else if (this.form.password.length < 6) {
            this.errors.password = 'Password must be at least 6 characters';
            hasError = true;
          }
          if (!this.form.password_confirmation) {
            this.errors.password_confirmation = 'Password confirmation is required';
            hasError = true;
          } else if (this.form.password !== this.form.password_confirmation) {
            this.errors.password_confirmation = 'Passwords do not match';
            hasError = true;
          }
          break;

        case 2:
          if (this.form.ismatchmaker) {
            // Matchmaker Registration Step 2: Profile Images & Basic Info
            if (!this.files.profile_image1) {
              this.errors.profile_image1 = 'Profile Image 1 is required';
              hasError = true;
            }
            if (!this.files.profile_image2) {
              this.errors.profile_image2 = 'Profile Image 2 is required';
              hasError = true;
            }
            if (!this.form.age) {
              this.errors.age = 'Age is required';
              hasError = true;
            } else if (isNaN(this.form.age) || this.form.age < 18 || this.form.age > 100) {
              this.errors.age = 'Please enter a valid age between 18 and 100';
              hasError = true;
            }
            if (this.form.yearsexperience === '' || this.form.yearsexperience === null) {
              this.errors.yearsexperience = 'Years of Experience is required';
              hasError = true;
            } else if (isNaN(this.form.yearsexperience) || this.form.yearsexperience < 0) {
              this.errors.yearsexperience = 'Please enter a valid number of years';
              hasError = true;
            }
            if (!this.form.bio) {
              this.errors.bio = 'Bio is required';
              hasError = true;
            }
          } else {
            // Client Registration Step 2: Location Details
            if (!this.form.country) {
              this.errors.country = 'Country is required';
              hasError = true;
            }
            if (!this.form.state) {
              this.errors.state = 'State is required';
              hasError = true;
            }
            if (!this.form.city) {
              this.errors.city = 'City is required';
              hasError = true;
            }
            if (!this.files.profile_image1) {
              this.errors.profile_image1 = 'Profile Image is required';
              hasError = true;
            }
            if (!this.form.seeking) {
              this.errors.seeking = 'Please summerize what you are seeking in your match';
              hasError = true;
            }
          }
          break;

        case 3:
          if (this.form.ismatchmaker) {
            // Matchmaker Registration Step 3: Location Details
            if (!this.form.city) {
              this.errors.city = 'City is required';
              hasError = true;
            }
            if (!this.form.state) {
              this.errors.state = 'State is required';
              hasError = true;
            }
            if (!this.form.country) {
              this.errors.country = 'Country is required';
              hasError = true;
            }
          } else {
            // Client Registration Step 6: Terms and Privacy
            if (!this.form.privacypolicy) {
              this.errors.general = 'You must agree to the Privacy Policy';
              hasError = true;
            }
            if (!this.form.termsofuse) {
              this.errors.general = 'You must agree to the Terms of Use';
              hasError = true;
            }
          }
          break;

        case 4:
          if (this.form.ismatchmaker) {
            // Matchmaker Registration Step 4: Terms and Privacy
            if (!this.form.privacypolicy) {
              this.errors.general = 'You must agree to the Privacy Policy';
              hasError = true;
            }
            if (!this.form.termsofuse) {
              this.errors.general = 'You must agree to the Terms of Use';
              hasError = true;
            }
          } else {
            // Matchmaker Registration Step 2: Profile Images & Basic Info
            // if (!this.files.profile_image1) {
            //   this.errors.profile_image1 = 'Profile Image 1 is required';
            //   hasError = true;
            // }
            // Matchmaker Registration Step 2: Profile Images & Basic Info
            // if (!this.files.profile_image2) {
            //   this.errors.profile_image2 = 'Profile Image 2 is required';
            //   hasError = true;
            // }
            // Client Registration Step 3: Personal Information
            // if (!this.form.age) {
            //   this.errors.age = 'Age is required';
            //   hasError = true;
            // } else if (isNaN(this.form.age) || this.form.age <= 0 || this.form.age > 120) {
            //   this.errors.age = 'Please enter a valid age';
            //   hasError = true;
            // }
          //   if (!this.form.gender) {
          //     this.errors.gender = 'Gender is required';
          //     hasError = true;
          //   }
          //   if (!this.form.hairColor) {
          //     this.errors.hairColor = 'Hair Color is required';
          //   hasError = true;
          //   }
          //   if (!this.form.bodyType) {
          //     this.errors.bodyType = 'Body Type is required';
          //   hasError = true;
          //   }
          //   if (!this.form.ethnicity) {
          //   this.errors.ethnicity = 'Ethnicity is required';
          //   hasError = true;
          // }
          // if (!this.form.heightFeet) {
          //   this.errors.heightFeet = 'Height in Feet is required';
          //   hasError = true;
          // } else if (isNaN(this.form.heightFeet) || this.form.heightFeet <= 0 || this.form.heightFeet > 8) {
          //   this.errors.heightFeet = 'Please enter a valid height in feet';
          //   hasError = true;
          // }
          // if (this.form.heightInches === '' || this.form.heightInches === null) {
          //   this.errors.heightInches = 'Inches is required';
          //   hasError = true;
          // } else if (isNaN(this.form.heightInches) || this.form.heightInches < 0 || this.form.heightInches >= 12) {
          //   this.errors.heightInches = 'Please enter a valid number of inches';
          //   hasError = true;
          // }
          }
          break;

        case 5:
          // if (!this.form.ismatchmaker) {
          //   //Client Registration Step 4: Lifestyle Information
          //   if (!this.form.maritalStatus) {
          //      this.errors.maritalStatus = 'Marital Status is required';
          //      hasError = true;
          //    }

          //    if (!this.form.haveKids) {
          //      this.errors.haveKids = 'Have Kids is required';
          //      hasError = true;
          //    }
             
          //    if (!this.form.haveKidsFuture) {
          //      this.errors.haveKidsFuture = 'Have Kids in future is required';
          //      hasError = true;
          //    }

          //    if(this.form.haveKids === 'Yes') {
          //     if (this.form.children === '' || this.form.children === null) {
          //       this.errors.children = 'Have Kids is required';
          //       hasError = true;
          //     }
          //    } else {
          //     if (this.form.children === '' || this.form.children === null) {
          //       this.form.children = ["0"];
          //     }
          //    }
             
          //    if (!this.form.religion) {
          //      this.errors.religion = 'Religion is required';
          //      hasError = true;
          //    }
          //   if (this.form.smoker === false && this.form.smoker === '') { // Adjusted for boolean
          //     this.errors.smoker = 'Smoker status is required';
          //     hasError = true;
          //   }
          //   if (!this.form.drinker) {
          //     this.errors.drinker = 'Drinker status is required';
          //     hasError = true;
          //   }
          // }
          break;
        case 6:
          // if (!this.form.ismatchmaker) {
          //     // Client Registration Step 5: Professional and Hobbies
          //   if (!this.form.education) {
          //     this.errors.education = 'Education is required';
          //     hasError = true;
          //   }
          //   if (!this.form.occupation) {
          //     this.errors.occupation = 'Occupation is required';
          //     hasError = true;
          //   }
          //   if (!this.form.jobTitle) {
          //     this.errors.jobTitle = 'Job Title is required';
          //     hasError = true;
          //   }
          //   if (!this.form.languages) {
          //     this.errors.languages = 'Languages is required';
          //     hasError = true;
          //   }
          // }
        break;
        case 7:
          // if (!this.form.seeking) {
          //   this.errors.seeking = 'Please summerize what you are seeking in your match';
          //   hasError = true;
          // }
          // if(!this.form.min_age) {
          //   this.errors.min_age = 'Please Enter Minimum Age';
          //   hasError = true;
          // } else if (isNaN(this.form.min_age) || this.form.min_age < 18 || this.form.min_age > 100) {
          //   this.errors.age = 'Please enter a valid minimum age between 18 and 100';
          //   hasError = true;
          // }
          // if(!this.form.max_age) {
          //   this.errors.max_age = 'Please Enter Maximum Age';
          //   hasError = true;
          // } else if (isNaN(this.form.max_age) || this.form.max_age < 18 || this.form.max_age > 100) {
          //   this.errors.age = 'Please enter a valid maximum age between 18 and 100';
          //   hasError = true;
          // }
          // if (this.form.current_kids_number === '' || this.form.current_kids_number === null) {
          //   this.errors.current_kids_number = 'Current Children is required';
          //   hasError = true;
          // }
          // if (this.form.desired_children === '' || this.form.desired_children === null) {
          //   this.errors.desired_children = 'Desired Children is required';
          //   hasError = true;
          // }
          // if (!this.form.seeking_hair_color) {
          //   this.errors.seeking_hair_color = 'Hair Color is required';
          //   hasError = true;
          // }
          // if (!this.form.seeking_gender) {
          //   this.errors.gender = 'Gender is required';
          //   hasError = true;
          // }
          // if (!this.form.seeking_body_type) {
          //   this.errors.bodyType = 'Body Type is required';
          //   hasError = true;
          // }
          // if (!this.form.seeking_marital_status) {
          //   this.errors.maritalStatus = 'Marital Status is required';
          //   hasError = true;
          // }
          // if (!this.form.seeking_religion) {
          //   this.errors.religion = 'Religion is required';
          //   hasError = true;
          // }
          // if (!this.form.seeking_smoker) {
          //   this.errors.smoker = 'Smoker is required';
          //   hasError = true;
          // }
          // if (!this.form.seeking_drinker) {
          //   this.errors.drinker = 'Drinker is required';
          //   hasError = true;
          // }
          // if (!this.form.seeking_location) {
          //   this.errors.seeking_location = 'Location is required';
          //   hasError = true;
          // }
          // if (!this.form.seeking_ethnicity) {
          //   this.errors.seeking_ethnicity = 'Ethnicity is required';
          //   hasError = true;
          // }
        break;
          
        default:
          break;
      }

      if (!hasError) {
        const currentStepIndex = this.steps.indexOf(this.currentStep);
        if (currentStepIndex < this.steps.length - 1) {
          this.currentStep = this.steps[currentStepIndex + 1];
        }
      }
    },
    prevStep() {
      const currentStepIndex = this.steps.indexOf(this.currentStep);
      if (currentStepIndex > 0) {
        this.currentStep = this.steps[currentStepIndex - 1];
      }
    },
    switchMatchmaker() {
      this.form.ismatchmaker = !this.form.ismatchmaker;
      if (this.form.ismatchmaker) {
        this.steps = [1, 2, 3, 4]; // Matchmaker has fewer steps
      } else {
        this.steps = [1, 2, 3]; // Client has all steps
      }

      // Reset currentStep if it's not in the new steps array
      if (!this.steps.includes(this.currentStep)) {
        this.currentStep = 1;
      }

      // Optionally, clear errors and form data specific to steps that are no longer visible
      this.clearErrors();
    },
    goToStep(number) {
      if (this.steps.includes(number)) {
        this.currentStep = number;
      }
    },
    showPrivacy() {
      this.modalMode.header = "Privacy Policy";
      this.pdfUrl = "/upload/pdf/privacypolicy.pdf";
      this.isModalOpen = true;
    },
    showTerm() {
      this.modalMode.header = "Terms of Use Agreement";
      this.pdfUrl = "/upload/pdf/termsofuse.pdf";
      this.isModalOpen = true;
    },
    closeModal() {
      this.isModalOpen = false;
      this.pdfUrl = '';
    },
    onFileChange(event, fieldName) {
      const file = event.target.files[0];
      console.log('fieldName:', fieldName);
      console.log('file:', file);
      if (file) {
        this.files[fieldName] = file;
        console.log('file data:', this.files[fieldName]);

        this.errors[fieldName] = ''; // Clear any existing error for this field
      } else {
        this.errors[fieldName] = 'This field is required.';
      }
    },
    async register() {
      this.processing = true;
      this.clearErrors();
      this.successMessage = '';

      // Validate all required fields before submission
      // if (!this.validateAllFields()) {
      //   this.processing = false;
      //   return;
      // }

      // Create a FormData object
      const formData = new FormData();

      // Append basic fields
      formData.append('name', this.form.name);
      formData.append('username', this.form.username);
      formData.append('email', this.form.email);
      formData.append('password', this.form.password);
      formData.append('password_confirmation', this.form.password_confirmation);
      
      // Explicitly convert boolean values
      formData.append('ismatchmaker', this.form.ismatchmaker === true ? '1' : '0');
      formData.append('privacypolicy', this.form.privacypolicy === true ? '1' : '0');
      formData.append('termsofuse', this.form.termsofuse === true ? '1' : '0');

      // Append location details
      formData.append('city', this.form.city);
      formData.append('state', this.form.state);
      formData.append('country', this.form.country);
      formData.append('age', this.form.age);
      if (this.files.profile_image1) {
        formData.append('profile_image1', this.files.profile_image1);
      }
      if (this.files.profile_image2) {
        formData.append('profile_image2', this.files.profile_image2);
      }

      if (!this.form.ismatchmaker) {
        // Append all client-specific fields
        formData.append('gender', this.form.gender);
        formData.append('hairColor', this.form.hairColor);
        this.form.bodyType.forEach(item => {
          formData.append('bodyType[]', item); // Append directly without JSON.stringify
        });
        this.form.ethnicity.forEach(item => {
          formData.append('ethnicity[]', item);
        });
        formData.append('heightFeet', this.form.heightFeet);
        formData.append('heightInches', this.form.heightInches);
        // formData.append('maritalStatus', this.form.maritalStatus);
        // formData.append('children', this.form.children);
        this.form.maritalStatus.forEach((status) => {
          formData.append('maritalStatus[]', status);
        });

        if (this.form.children.length > 0) {
          this.form.children.forEach((child) => {
            formData.append('children[]', child);
          });
        } else {
          formData.append('children[]', "0"); // Or skip if optional
        }
        this.form.religion.forEach(item => {
          formData.append('religion[]', item); // Append directly without JSON.stringify
        });
        formData.append('smoker', this.form.smoker === true ? '1' : '0');
        formData.append('drinker', this.form.drinker);
        formData.append('education', this.form.education);
        formData.append('occupation', this.form.occupation);
        formData.append('jobTitle', this.form.jobTitle);
        formData.append('sports', this.form.sports);
        formData.append('hobbies', this.form.hobbies);
        this.form.languages.forEach((item, index) => {
          formData.append(`languages[${index}][language]`, item.language); // Append the language
          formData.append(`languages[${index}][level]`, item.level);     // Append the level
        });
        formData.append('seeking', this.form.seeking); // Add this line
        formData.append('min_age', this.form.min_age); 
        formData.append('max_age', this.form.max_age); 
        formData.append('current_kids_number', this.form.current_kids_number); 
        formData.append('desired_children', this.form.desired_children); 
        formData.append('seeking_location', this.form.seeking_location); 
        formData.append('seeking_hair_color', this.form.seeking_hair_color); 
        formData.append('seeking_gender', this.form.seeking_gender); 
        formData.append('seeking_body_type', this.form.seeking_body_type); 
        formData.append('seeking_marital_status', this.form.seeking_marital_status); 
        formData.append('seeking_religion', this.form.seeking_religion); 
        formData.append('seeking_smoker', this.form.seeking_smoker); 
        formData.append('seeking_drinker', this.form.seeking_drinker);
        formData.append('seeking_ethnicity', this.form.seeking_ethnicity);
        formData.append('having_kids', this.form.haveKids);
        formData.append('having_kids_in_future', this.form.haveKidsFuture);
      }

      // Append matchmaker specific fields
      if (this.form.ismatchmaker) {
        formData.append('yearsexperience', this.form.yearsexperience);
        formData.append('bio', this.form.bio);
      }

      try {
        const response = await this.registerUser(formData);
        if (response.success === true) {          
          this.successMessage = response.message;
          this.validationErrors = {};
          setTimeout(() => {
            this.$router.push({ name: "login" });
          }, 1500);
        }
      } catch (error) {
        if (error.response && error.response.status === 422) {
          this.validationErrors = error.response.data.errors || error.response.data.message;
          this.mapValidationErrors();
        } else if (error.response && error.response.status === 500) {
          this.errors.general = 'Server error. Please try again later.';
        } else {
          this.errors.general = error.response?.data?.message || 'An unexpected error occurred.';
        }
      } finally {
        this.processing = false;
      }
    },
    // New method to validate all fields before submission
    validateAllFields() {
      // if (!this.form.ismatchmaker) {
      //   // Validate all required client fields
      //   const requiredFields = {
      //     gender: 'Gender',
      //     hairColor: 'Hair Color',
      //     bodyType: 'Body Type',
      //     heightFeet: 'Height (Feet)',
      //     heightInches: 'Height (Inches)',
      //     maritalStatus: 'Marital Status',
      //     children: 'Children',
      //     religion: 'Religion',
      //     smoker: 'Smoker',
      //     drinker: 'Drinker',
      //     education: 'Education',
      //     occupation: 'Occupation',
      //     jobTitle: 'Job Title',
      //     languages: 'Languages',
      //     seeking: 'Seeking',
      //   };

      //   for (const [field, label] of Object.entries(requiredFields)) {
      //     if (!this.form[field]) {
      //       this.errors[field] = `${label} is required`;
      //       return false;
      //     }
      //   }
      // }

      // Always validate common fields
      const commonFields = {
        name: 'Name',
        username: 'Username',
        email: 'Email',
        password: 'Password',
        country: 'Country',
        state: 'State',
        city: 'City',
        privacypolicy: 'Privacy Policy',
        termsofuse: 'Terms of use',
      };

      for (const [field, label] of Object.entries(commonFields)) {
        if (!this.form[field]) {
          this.errors[field] = `${label} is required`;
          return false;
        }
      }

      // Additional validations can be added here if necessary

      return true;
    },
    mapValidationErrors() {
      for (const [key, messages] of Object.entries(this.validationErrors)) {
        if (this.errors.hasOwnProperty(key)) {
          this.errors[key] = messages[0]; // Display the first error message
        } else {
          // Handle general errors
          this.errors.general = messages[0];
        }
      }
    },
    clearErrors() {
      this.errors = {};
      this.successMessage = '';
    },
    validateEmail(email) {
      const re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@(([^<>()[\]\\.,;:\s@"]+\.)+[^<>()[\]\\.,;:\s@"]{2,})$/i;
      return re.test(String(email).toLowerCase());
    },
    // Handle country search
    handleCountrySearch(query) {
      // Filter states based on the selected country
      const selected = this.countries.find(country => country.name === query);
      this.filteredStates = selected ? selected.states.map(state => state.name) : [];
      
      // Reset the selected state and city when the country changes
      this.form.state = null;
      this.form.city = null;
    },
    // Handle state search
    handleStateSearch(query) {
      // Filter cities based on the selected state
      const country = this.countries.find(country => country.name === this.form.country);
      const selected = country ? country.states.find(state => state.name === query) : null;
      this.filteredCities = selected ? selected.cities : [];
      
      // Reset the selected city when the state changes
      this.form.city = null;
    },
    // Handle city search based on selected state
    handleCitySearch(query) {
      // If no state is selected, reset the city options
      if (!this.form.state) {
        this.filteredCities = [];
        return;
      }

      // Find the country that has the selected state
      const country = this.countries.find(c => c.name === this.form.country);
      if (!country) return;

      // Find the selected state within the country
      const state = country.states.find(s => s.name === this.form.state);
      if (!state) return;

      // If no query is entered, show all cities in the selected state
      if (!query) {
        this.filteredCities = state.cities;
        return;
      }
    }
  },
  watch: {
    // Watch for changes in selected country to reset filtered states and cities
    'form.country'(newCountry) {
      const country = this.countries.find(c => c.name === newCountry);
      if (country) {
        console.log('New country:', newCountry);
        this.form.state = null; // Reset selected state when country changes
        this.form.city = null; // Reset selected city when country changes
        this.filteredStates = country.states.map(state => state.name);
        this.filteredCities = []; // Clear cities when country changes
      } else {
        this.filteredStates = [];
        this.filteredCities = [];
      }
    },

    // Watch for changes in selected state to reset filtered cities
    'form.state'(newState) {
      if (!this.form.country) return;

      const country = this.countries.find(c => c.name === this.form.country);
      if (!country) return;

      const state = country.states.find(s => s.name === newState);
      if (state) {
        console.log('New state:', newState);

        this.form.city = null; // Reset selected city when state changes
        this.filteredCities = state.cities;
      } else {
        this.filteredCities = [];
      }
    },

    // Watch for changes in selected city
    'form.city'(newCity) {
      if (newCity) {
        // You can perform any additional actions or logic when a city is selected
        console.log(`New city: ${newCity}`);
      }
    },
  }
};
</script>

<style scoped>
/* Component-specific styles */

/* Switch Handle */
.dot {
  transition: transform 0.3s;
}

/* Error Message Styles */
.bg-red-200 {
  background-color: #fee2e2;
}
.text-red-800 {
  color: #991b1b;
}

/* Success Message Styles */
.bg-green-200 {
  background-color: #d1fae5;
}
.text-green-800 {
  color: #065f46;
}

/* Checkbox Styles */
.form-checkbox {
  @apply h-4 w-4 text-blue-600 border-gray-300 rounded;
}

/* Optional: Add custom styles for error messages or other elements if needed */
</style>

<template>
  <!-- verification data -->
  <div :class="serverData.length > 0 || serverDataOld.length > 0 ? 'w-full' : 'max-w-7xl'" class="p-6 bg-gray-50 rounded-lg shadow-lg mx-auto">
    <h2 class="text-xl font-bold mb-4">Welcome {{ user && user.name ? user.name : 'Guest' }}!</h2>

   
    <div v-if="serverData.length > 0">
      <p>Meetings created successfully</p>
      <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
        <div v-for="meeting in serverData" :key="meeting.google_meet_id" class="card p-4 mb-3 shadow-sm bg-white rounded-lg">
          <p><strong>ID:</strong> {{ meeting.google_meet_id }}</p>
          <p><strong>Meeting Link:</strong> <a class="text-[#f24570] hover:text-[#213366]" :href="meeting.google_meet_link" target="_blank">
            Open
          </a></p>
          <p><strong>Meeting Start Link:</strong> <a class="text-[#f24570] hover:text-[#213366]" :href="JSON.parse(meeting.meeting_response).start_url" target="_blank">
            Open
          </a></p>
          <p><strong>Timezone:</strong> {{ JSON.parse(meeting.meeting_response).timezone }}</p>
          <p><strong>Start At:</strong> <span class="text-[#213366] font-semibold">{{ formatDate(meeting.start_time) }}</span></p>
          <p><strong>Password:</strong> {{ meeting.google_meet_password }}</p>
          <p><strong>Duration:</strong> {{ meeting.duration }} Minutes</p>
        </div>
      </div>
    </div>
    <div v-else-if="serverDataOld.length > 0">
      <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
        <div v-for="meeting in serverDataOld" :key="meeting.id" class="card p-4 mb-3 shadow-sm bg-white rounded-lg">
          <p><strong>ID:</strong> {{ meeting.google_meet_id }}</p>
          <p><strong>Meeting Link:</strong> <a class="text-[#f24570] hover:text-[#213366]" :href="meeting.google_meet_link" target="_blank">
            Open
          </a></p>
          <p><strong>Start At:</strong> <span class="text-[#213366] font-semibold">{{ formatDate(meeting.start_time) }}</span></p>
          <p><strong>Status:</strong> {{ meeting.status }}</p>
          <p><strong>Duration:</strong> {{ meeting.duration }} Minutes</p>
        </div>
      </div>
    </div>
    <div v-else>
      <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
        <!-- optional message -->
        <div class="p-4">
          <p>Before you proceed, we need to verify your identity.</p>
          <p>
            This optional meeting with our administrators is designed to confirm your identity. While you may choose to skip this step, we encourage you to review the
            <button
              @click="openModal"
              class="text-blue-500 hover:underline focus:outline-none"
            >
              benefits of identity verification
            </button>
            to make an informed decision.
          </p>

          <!-- Modal -->
          <div
            v-if="isModalOpen"
            class="fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-50"
            @click.self="closeModal"
          >
            <div class="relative max-w-lg rounded-lg bg-white p-6 shadow-lg">
              <button
                @click="closeModal"
                class="absolute right-4 top-4 text-gray-400 hover:text-gray-600 focus:outline-none"
              >
                &times;
              </button>
              <h2 class="mb-4 text-xl font-semibold">Benefits of Identity Verification</h2>
              <div class="max-h-80 overflow-y-auto">
                <ul class="list-disc space-y-2 pl-6 text-gray-700">
                  <li>Enhances trust and safety across our platform for everyone.</li>
                  <li>Increases your chances of finding genuine and compatible matches.</li>
                  <li>Ensures the profiles you interact with are authentic and verified.</li>
                  <li>Creates a safer environment for meaningful connections.</li>
                  <li>Helps us offer personalized recommendations based on your verified profile.</li>
                </ul>
              </div>
            </div>
          </div>
        </div>

        <!-- Appointment Form -->
        <form @submit.prevent="submitAppointment">
          <label for="timezone" class="block text-sm font-medium text-gray-700 mb-2">
            Select the timezone you will be located in when your date occurs:
          </label>
          <select
            id="timezone"
            v-model="selectedTimezone"
            class="block w-full p-2 border rounded-lg mb-4"
            required
          >
            <option value="" disabled>Select Timezone</option>
            <option v-for="timezone in timezones" :key="timezone.value" :value="timezone.value">
              {{ timezone.label }}
            </option>
          </select>

          <p class="text-sm font-medium text-gray-700 mb-2">
            Then please share your soonest available options.
          </p>

          <!-- Dropdowns for date and time -->
          <div class="space-y-4">
            <div v-for="(slot, index) in appointmentSlots" :key="index" class="flex space-x-4">
              <!-- Date -->
              <select
                v-model="slot.date"
                class="block w-1/3 p-2 border rounded-lg"
                @change="validateSlot(index)"
                required
              >
                <option value="" disabled>Select Date</option>
                <option v-for="date in availableDates" :key="date" :value="date">
                  {{ date }}
                </option>
              </select>

              <!-- Start Time -->
              <select
                v-model="slot.startTime"
                class="block w-1/3 p-2 border rounded-lg"
                :disabled="!slot.date"
                @change="setEndTime(index)"
                required
              >
                <option value="" disabled>Start Time</option>
                <option
                  v-for="time in filteredStartTimes(index)"
                  :key="time"
                  :value="time"
                >
                  {{ time }}
                </option>
              </select>

              <!-- End Time -->
              <input
                type="text"
                :value="slot.endTime"
                class="block w-1/3 p-2 border rounded-lg bg-gray-100 cursor-not-allowed"
                readonly
              />
            </div>
          </div>

          <button
            type="submit"
            class="mt-6 bg-blue-600 text-white px-4 py-2 rounded-lg shadow-lg hover:bg-blue-700 w-full"
          >
            Submit Appointment
          </button>
        </form>
      </div>
    </div>

  </div>

  <!-- profile data -->
  <div v-if="userProfileScore < 100" class="max-w-7xl p-6 bg-gray-50 rounded-lg shadow-lg mx-auto mt-10">
    <h2 class="text-xl font-bold mb-4">Your profile score is <span :class="scoreStyle">{{ userProfileScore }}/100</span>!</h2>

    <div>
      <p><strong>Dear {{ user && user.name ? user.name : 'Guest' }}</strong>, we noticed that your profile is not fully complete. To enhance your experience and improve your chances of finding the best matches, we encourage you to update your information now. The more details you provide, the better opportunities we can find for you!</p>

      <div class="max-w-lg mx-auto p-4 bg-white relative">
        <h2 class="text-xl font-semibold mb-4">
          {{ 'Update Your Personal Data' }}
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

        <!-- Form Steps -->
        <form @submit.prevent="updateData" enctype="multipart/form-data">
          <!-- Step 1: Account Information -->
          <div v-if="currentStep === 1">

            <div v-if="user.profile.profile_image1 == null">
              <!-- Profile Image 1 -->
              <div class="mb-4">
                <label class="block text-gray-700">
                  Upload Profile Image 1 <span class="text-red-500">*</span>
                </label>
                <input type="file" @change="onFileChange($event, 'profile_image1')" accept="image/*" required />
                <p v-if="errors.profile_image1" class="text-red-500 text-xs italic">{{ errors.profile_image1 }}</p>
              </div>
            </div>

            <div v-if="user.profile.profile_image2 == null">
              <!-- Profile Image 2 -->
              <div class="mb-4">
                <label class="block text-gray-700">Upload Profile Image 2</label>
                <input type="file" @change="onFileChange($event, 'profile_image2')" accept="image/*" required />
                <p v-if="errors.profile_image2" class="text-red-500 text-xs italic">{{ errors.profile_image2 }}</p>
              </div>
            </div>

            <h3 class="font-semibold text-lg mb-4">Personal Information</h3>
            <div class="grid grid-cols-1 md:grid-cols-1 gap-1">
              <template v-if="
                user.phone_number &&
                user.profile && 
                user.profile.age && 
                user.profile.gender &&
                user.profile.haircolor &&
                user.profile.bodytype &&
                user.profile.height &&
                user.profile.inches
              ">
                <div class="flex flex-col items-center justify-center text-center">
                  <svg xmlns="http://www.w3.org/2000/svg" class="w-16 h-16 text-green-500 mb-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                  </svg>
                  <p class="text-2xl text-green-700 font-semibold">Personal Information looks good!</p>
                  <p class="text-xl text-green-600">Well done!</p>
                </div>
              </template>
              <template v-else>
                <div v-if="!user.phone_number">
                  <input-text
                  label="Phone Number"
                  v-model="form.phone_number"
                  :error="errors.phone_number"
                  maxlength="50"
                  />
                </div>
                <div v-if="!user.profile.age">
                  <input-text
                  label="Age"
                  v-model="form.age"
                  type="number"
                  :error="errors.age"
                  maxlength="3"
                  min="1"
                  max="120"
                  />
                </div>
                <div v-if="!user.profile.gender">
                  <select-option
                    label="Gender"
                    :options="genders"
                    v-model="form.gender"
                    :error="errors.gender"
                  />
                </div>
                <div v-if="!user.profile.haircolor">
                  <input-text
                    label="Hair Color"
                    v-model="form.hairColor"
                    :error="errors.hairColor"
                    maxlength="50"
                  />
                </div> 
                <div v-if="!user.profile.bodytype">
                  <MultiSelectOption
                    label="Body Type"
                    :options="bodyTypes"
                    v-model="form.bodyType"
                    :error="errors.bodyType"
                  />
                </div>
                <div v-if="!user.profile.ethnicity">
                  <MultiSelectOption
                    label="Ethnicity"
                    :options="ethnicity"
                    v-model="form.ethnicity"
                    :error="errors.ethnicity"
                  />
                </div>
                <div class="flex gap-4">
                  <div v-if="!user.profile.height">
                    <input-text
                      label="Height (Feet)"
                      v-model="form.heightFeet"
                      type="number"
                      :error="errors.heightFeet"
                      maxlength="2"
                      min="1"
                      max="8"
                    />
                  </div>
                  <div v-if="!user.profile.inches">
                    <input-text
                      label="Inches"
                      v-model="form.heightInches"
                      type="number"
                      :error="errors.heightInches"
                      maxlength="2"
                      min="0"
                      max="11"
                    />
                  </div>
                </div>
              </template>
            </div>
          </div>

          <!-- Step 2: Location Details (Client) -->
          <div v-if="currentStep === 2">
            <h3 class="font-semibold text-lg mb-4">Lifestyle Information</h3>
            <div class="grid grid-cols-1 md:grid-cols-1 gap-1">
              <template v-if="
                user.profile &&
                (user.profile.maritalstatus || user.profile.maritalstatus?.length === 0) &&
                (user.profile.children !== null && (user.profile.children || user.profile.children?.length === 0)) &&
                user.profile.smoker !== null &&
                (user.profile.religion || user.profile.religion?.length === 0) &&
                user.profile.drinker
              ">
                <div class="flex flex-col items-center justify-center text-center">
                  <svg xmlns="http://www.w3.org/2000/svg" class="w-16 h-16 text-green-500 mb-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                  </svg>
                  <p class="text-2xl text-green-700 font-semibold">Lifestyle Information looks good!</p>
                  <p class="text-xl text-green-600">Well done!</p>
                </div>
              </template>
              <template v-else>
                <div v-if="!user.profile.maritalstatus || user.profile.maritalstatus.length === 0">
                  <MultiSelectOption
                    label="Marital Status"
                    :options="maritalStatuses"
                    v-model="form.maritalStatus"
                    :error="errors.maritalStatus"
                  />
                </div>

                <div v-if="!user.profile.children || user.profile.children.length === 0">
                  <select-option
                    label="Do you have kids?"
                    :options="haveKidsAnswers"
                    v-model="form.haveKids"
                    :error="errors.haveKids"
                  />
                  <template v-if="form.haveKids === 'Yes'">
                    <MultiSelectOption
                      label="Children"
                      :options="childrenOptions"
                      v-model="form.children"
                      :error="errors.children"
                    />
                  </template>
                  <select-option
                    label="Do you want kids in the future?"
                    :options="haveKidsAnswers"
                    v-model="form.haveKidsFuture"
                    :error="errors.haveKidsFuture"
                  />
                </div>

                <div v-if="!user.profile.religion || user.profile.religion.length === 0">
                  <MultiSelectOption
                    label="Religion"
                    :options="religions"
                    v-model="form.religion"
                    :error="errors.religion"
                  />
                </div>

                <div v-if="user.profile.smoker == null">
                  <select-option
                    label="Smoker"
                    :options="yesNoOptions"
                    v-model="form.smoker"
                    :error="errors.smoker"
                  />
                </div>
                <div v-if="!user.profile.drinker">
                  <select-option
                    label="Drinker"
                    :options="drinkerOptions"
                    v-model="form.drinker"
                    :error="errors.drinker"
                  />
                </div>
              </template>
            </div>
          </div>

          <!-- Step 3: Location Details (Matchmaker) -->
          <div v-if="currentStep === 3">
            <h3 class="font-semibold text-lg mb-4">Professional and Hobbies</h3>
            <div class="grid grid-cols-1 md:grid-cols-1 gap-1">

              <template v-if="
                user.profile && 
                user.profile.education != null && 
                user.profile.occupation != null  &&
                user.profile.jobtitle != null &&
                user.profile.sports != null &&
                user.profile.hobbies != null &&
                (user.profile.languages != null && user.profile.languages.length === 0)
              ">
                <div class="flex flex-col items-center justify-center text-center">
                  <svg xmlns="http://www.w3.org/2000/svg" class="w-16 h-16 text-green-500 mb-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                  </svg>
                  <p class="text-2xl text-green-700 font-semibold">Professional and Hobbies looks good!</p>
                  <p class="text-xl text-green-600">Well done!</p>
                </div>
              </template>
              <template v-else>

                <div v-if="!user.profile.education">
                  <select-option
                    label="Education"
                    :options="educationLevels"
                    v-model="form.education"
                    :error="errors.education"
                  />
                </div>
                <div v-if="!user.profile.occupation">
                  <input-text
                    label="Occupation"
                    v-model="form.occupation"
                    :error="errors.occupation"
                    maxlength="100"
                  />
                </div>
                <div v-if="!user.profile.jobtitle">
                  <input-text
                    label="Job Title"
                    v-model="form.jobTitle"
                    :error="errors.jobTitle"
                    maxlength="100"
                  />
                </div>
                <div v-if="!user.profile.sports">
                  <input-text
                    label="Sports"
                    v-model="form.sports"
                    :error="errors.sports"
                    maxlength="100"
                  />
                </div>
                <div v-if="!user.profile.hobbies">
                  <input-text
                    label="Hobbies"
                    v-model="form.hobbies"
                    :error="errors.hobbies"
                    maxlength="100"
                  />
                </div>

                <div v-if="!user.profile.languages || user.profile.languages.length === 0">
                  <div class="grid grid-cols-1 md:grid-cols-1 gap-4 mt-4">
                    <!-- Languages and Levels -->
                    <div class="space-y-4">
                      <label for="languages" class="block">Languages</label>
                      <!-- Language-Level Pairing -->
                      <div v-for="(item, index) in form.languages" :key="index" class="flex space-x-4">
                        <select
                          v-model="item.language"
                          class="form-select"
                          @change="updateLanguage(index)"
                        >
                          <option value="" disabled>Select a language</option>
                          <option v-for="(language, i) in availableLanguages(index)" :key="i" :value="language">
                            {{ language }}
                          </option>
                        </select>

                        <select
                          v-model="item.level"
                          class="form-select"
                          required
                        >
                          <option value="" disabled>Select level</option>
                          <option v-for="(level, i) in englishLevels" :key="i" :value="level">
                            {{ level }}
                          </option>
                        </select>

                        <button
                          @click="removeLanguage(index)"
                          class="ml-2 text-red-500"
                          :disabled="form.languages.length <= 1"
                        >
                          Remove
                        </button>
                      </div>

                      <!-- Add Language Button -->
                      <button
                        @click="addLanguage"
                        class="mt-2 px-4 py-2 rounded"
                        type="button"
                        :class="{
                          'bg-blue-500 text-white': !(form.languages.length >= 5),
                          'bg-gray-400 text-gray-600 cursor-not-allowed': form.languages.length >= 4
                        }"
                        :disabled="form.languages.length >= 5"
                      >
                        Add Language
                      </button>
                    </div>
                  </div>
                </div>
              </template>
            </div>
          </div>

          <!-- Step 4: Terms and Privacy (Both Matchmaker and Client) -->
          <div v-if="(currentStep === 4)">
            <h3 class="font-semibold text-lg mb-4">Seeking</h3>
            <div v-if="!user.seeking.summarize">
              <div class="mb-4">
                <label class="block text-gray-700">
                  Summarize what you are seeking in a match
                </label>
                <textarea
                  v-model="form.seeking"
                  placeholder="Please explain"
                  class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                ></textarea>
                <p v-if="errors.seeking" class="text-red-500 text-xs italic">{{ errors.seeking }}</p>
              </div>
            </div>
            <div class="flex gap-4">

              <div v-if="!user.seeking.min_age">
                <input-text
                  label="Min. Age"
                  v-model="form.min_age"
                  type="number"
                  :error="errors.age"
                  maxlength="3"
                  min="1"
                  max="120"
                />
              </div>
              <div v-if="!user.seeking.max_age">
                <input-text
                  label="Max. Age"
                  v-model="form.max_age"
                  type="number"
                  :error="errors.age"
                  maxlength="3"
                  min="1"
                  max="120"
                />
              </div>
            </div>
            <div v-if="!user.seeking.location">
              <input-text
                label="Location"
                v-model="form.seeking_location"
                :error="errors.seeking_location"
                maxlength="100"
              />
            </div>

            <div class="flex gap-5">
              <div v-if="!user.seeking.current_kids_number">
                <select-option
                  label="Current Kid(s)"
                  :options="childrenOptions"
                  v-model="form.current_kids_number"
                  :error="errors.current_kids_number"
                />
              </div>
              <div v-if="!user.seeking.desired_kids_number">
                <select-option
                  label="Desired Kid(s)"
                  :options="childrenOptions"
                  v-model="form.desired_children"
                  :error="errors.desired_children"
                />
              </div>
            </div>
            <div v-if="!user.seeking.haircolor">
              <input-text
                label="Hair Color"
                v-model="form.seeking_hair_color"
                :error="errors.hairColor"
                maxlength="50"
              />
            </div>

            <div class="flex-row gap-4">
              <div v-if="!user.seeking.gender">
                <div class="flex-1">
                  <select-option
                    label="Gender&nbsp;"
                    :options="genders"
                    v-model="form.seeking_gender"
                    :error="errors.gender"
                  />
                </div>
              </div>
              <div v-if="!user.seeking.bodytype">
                <div class="flex-1">
                  <MultiSelectOption
                    label="Body Type&nbsp;"
                    :options="bodyTypes"
                    v-model="form.seeking_body_type"
                    :error="errors.bodyType"
                  />
                </div>
              </div>
            </div>

            <div class="flex-row gap-4">
              <div v-if="!user.seeking.maritalstatus">
                <div class="flex-1">
                  <MultiSelectOption
                    label="Marital Status"
                    :options="maritalStatuses"
                    v-model="form.seeking_marital_status"
                    :error="errors.maritalStatus"
                  />
                </div>
              </div>
              <div v-if="!user.seeking.religion">
                <div class="flex-1">
                  <MultiSelectOption
                    label="Religion"
                    :options="religions"
                    v-model="form.seeking_religion"
                    :error="errors.religion"
                  />
                </div>
              </div>
            </div>

            <div class="flex-row gap-4">
              <div v-if="!user.seeking.smoker">
                <div class="flex-1">
                  <select-option
                    label="Smoker"
                    :options="yesNoOptions"
                    v-model="form.seeking_smoker"
                    :error="errors.smoker"
                  />
                </div>
              </div>
              
              <div v-if="!user.seeking.drinker">
                <div class="flex-1">
                  <select-option
                    label="Drinker"
                    :options="drinkerOptions"
                    v-model="form.seeking_drinker"
                    :error="errors.drinker"
                  />
                </div>
              </div>
            </div>

            <div v-if="!user.seeking.ethnicity">
              <div class="flex gap-5">
                <div class="flex-1">
                <MultiSelectOption
                  label="Ethnicity"
                  :options="ethnicity"
                  v-model="form.seeking_ethnicity"
                  :error="errors.seeking_ethnicity"
                />
                </div>
              </div>
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
              {{ processing ? "Please wait" : "Submit" }}
            </button>
          </div>
        </form>
      </div>
      <!--  -->
    </div>
  </div>
</template>

<script>
import axios from "axios";
import InputText from '../../components/InputText.vue';
import SelectOption from '../../components/SelectOption.vue';
import MultiSelectOption from '../../components/MultiSelectOption.vue';

export default {
  name: "AppointmentForm",
  components: {
    InputText,
    SelectOption,
    MultiSelectOption,
  },
  data() {
    return {
      authorization: this.$store.state.auth.authorization,
      currentStep: 1,
      steps: [1, 2, 3, 4],
      form: {
        haveKids: "",
        haveKidsFuture: "",
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
      processing: false,
      // New Data for File Uploads
      files: {
        profile_image1: null,
        profile_image2: null,
      },



      
      isModalOpen: false,
      serverDataOld: [],
      serverData: [],
      selectedTimezone: "",
      userProfileScore: 0,
      timezones: [
        { label: "Pacific Time (Los Angeles)", value: "America/Los_Angeles" },
        { label: "Mountain Time", value: "America/Denver" },
        { label: "Central Time", value: "America/Chicago" },
        { label: "Eastern Time", value: "America/New_York" },
      ],
      appointmentSlots: [
        { date: "", startTime: "", endTime: "" },
        { date: "", startTime: "", endTime: "" },
        { date: "", startTime: "", endTime: "" },
      ],
      availableDates: [], // To be populated dynamically
      availableTimes: [], // To be populated dynamically
    };
  },
  computed: {
    validationErrorsList() {
      // Extract all validation errors except 'general'
      return Object.keys(this.errors)
        .filter(key => this.errors[key] && key !== 'general')
        .map(key => this.errors[key]);
    },
    user() {
      return this.$store.state.auth.user;
    },
    // Access user and profile from Vuex store
    userFromStore() {
      return this.$store.getters['auth/user'];
    },
    profileFromStore() {
      return this.$store.getters['auth/profile'];
    },
    scoreStyle() {      
      if (this.userProfileScore >= 90) {
        return 'text-green-500'; // High score (80 and above)
      } else if (this.userProfileScore >= 85) {
        return 'text-yellow-500'; // Medium score (50 to 79)
      } else if (this.userProfileScore >= 50) {
        return 'text-orange-500'; // Medium score (50 to 79)
      } else if (this.userProfileScore >= 25) {
        return 'text-blue-500'; // Low-medium score (25 to 49)
      } else {
        return 'text-red-500'; // Red for low scores
      }
    },
  },
  methods: {
    openModal() {
      this.isModalOpen = true;
    },
    closeModal() {
      this.isModalOpen = false;
    },
    generateAvailableDates() {
      const dates = [];
      const today = new Date();

      for (let i = 0; i < 14; i++) {
        const date = new Date(today);
        date.setDate(today.getDate() + i);

        // Format the date as "Day, Mon DD"
        const formattedDate = date.toLocaleDateString("en-US", {
          weekday: "short",
          month: "short",
          day: "numeric",
        });

        dates.push(formattedDate);
      }

      this.availableDates = dates;
    },
    generateAvailableTimes() {
      const times = [];
      const startHour = 16; // 4 PM
      const endHour = 18; // 6 PM

      for (let hour = startHour; hour < endHour; hour++) {
        for (let minute = 0; minute < 60; minute += 15) {
          const time = `${hour % 12 || 12}:${minute === 0 ? "00" : minute} ${
            hour >= 12 ? "PM" : "AM"
          }`;
          times.push(time);
        }
      }

      this.availableTimes = times;
    },
    setEndTime(index) {
      const slot = this.appointmentSlots[index];
      const startTimeIndex = this.availableTimes.indexOf(slot.startTime);

      if (startTimeIndex !== -1 && startTimeIndex < this.availableTimes.length - 1) {
        slot.endTime = this.availableTimes[startTimeIndex + 1]; // Set end time to 15 minutes after start
      } else {
        slot.endTime = ""; // Reset end time if invalid
      }

      this.validateSlot(index);
    },
    validateSlot(index) {
      const slot = this.appointmentSlots[index];

      // Ensure the same date and time combination isn't used in other slots
      for (let i = 0; i < this.appointmentSlots.length; i++) {
        if (i !== index) {
          const otherSlot = this.appointmentSlots[i];
          if (
            slot.date === otherSlot.date &&
            slot.startTime === otherSlot.startTime &&
            slot.endTime === otherSlot.endTime
          ) {
            alert("This time slot is already selected in another dropdown. Please choose a different slot.");
            slot.startTime = "";
            slot.endTime = "";
            return;
          }
        }
      }
    },
    filteredStartTimes(index) {
      const slot = this.appointmentSlots[index];
      const selectedTimesForSameDate = this.appointmentSlots
        .filter(s => s.date === slot.date && s !== slot) // Only slots with the same date
        .map(s => s.startTime);

      return this.availableTimes.filter(
        time => !selectedTimesForSameDate.includes(time) || slot.startTime === time
      );
    },
    async submitAppointment() {
      try {
        const response = await axios.post("/api/google/appointment-meeting", {
          pickadate: false,
          user_id: this.user.id,
          timezone: this.selectedTimezone,
          slots: this.appointmentSlots,
        });

        if (response.data.success) {
          this.serverData = response.data.data;
        } else {
          alert("Failed to submit the appointment. Please try again.");
        }
      } catch (error) {
        console.error("Error submitting appointment:", error);
        alert("An error occurred while submitting the appointment.");
      }
    },
    formatDate(timestamp) {
      const date = new Date(timestamp);
      return date.toLocaleString('en-US', {
        weekday: 'short', // Day of the week (e.g., Mon)
        month: 'short',   // Month (e.g., Jan)
        day: 'numeric',   // Day (e.g., 22)
        year: 'numeric',  // Year (e.g., 2025)
        hour: '2-digit',  // Hour (e.g., 09)
        minute: '2-digit',// Minute (e.g., 00)
        second: '2-digit',// Second (e.g., 00)
        hour12: false,     // 12-hour format (AM/PM)
      });
    },
    async getAppointments() {
      try {
        const response = await axios.post("/api/google/pending-appointment-meeting", {
          user_id: this.user.id,
        });

        if (response.data.success) {
          this.serverDataOld = response.data.data;
        } else {
          alert("Failed to submit the appointment. Please try again.");
        }
      } catch (error) {
        console.error("Error submitting appointment:", error);
        alert("An error occurred while submitting the appointment.");
      }
    },
    async getUserProfileScore() {
      try {
        const response = await axios.post("/api/user/get-profile-score", {
          user_id: this.user.id,
        });

        if (response.data.success) {
          this.userProfileScore = response.data.score;
        } else {
          alert("Failed to get user profile score. Please try again.");
        }
      } catch (error) {
        console.error("Error getting user profile score:", error);
        alert("An error occurred while getting user profile score.");
      }
    },

    ///
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
          if (this.user.phone_number == null && !this.form.phone_number) {
            this.errors.phone_number = 'Phone Number is required';
            hasError = true;
          }
          if (this.user.profile.profile_image1 == null && !this.files.profile_image1) {
            this.errors.profile_image1 = 'Profile Image 1 is required';
            hasError = true;
          }
          if (this.user.profile.profile_image2 == null && !this.files.profile_image2) {
            this.errors.profile_image2 = 'Profile Image 2 is required';
            hasError = true;
          }
          // Client Registration Step 1: Personal Information
          if (!this.user.profile.age && !this.form.age) {
            this.errors.age = 'Age is required';
            hasError = true;
          } else if (!this.user.profile.age && isNaN(this.form.age) || !this.user.profile.age && this.form.age <= 0 || !this.user.profile.age && this.form.age > 120) {
            this.errors.age = 'Please enter a valid age';
            hasError = true;
          }
          if (!this.user.profile.gender && !this.form.gender) {
            this.errors.gender = 'Gender is required';
            hasError = true;
          }
          if (!this.user.profile.haircolor && !this.form.hairColor) {
            this.errors.hairColor = 'Hair Color is required';
            hasError = true;
          }
          if (!this.user.profile.bodytype && !this.form.bodyType) {
            this.errors.bodyType = 'Body Type is required';
            hasError = true;
          }
          if (!this.user.profile.ethnicity && !this.form.ethnicity) {
            this.errors.ethnicity = 'Ethnicity is required';
            hasError = true;
          }

          if (!this.user.profile.height && !this.form.heightFeet) {
            this.errors.heightFeet = 'Height in Feet is required';
            hasError = true;
          } else if (!this.user.profile.height && isNaN(this.form.heightFeet) || !this.user.profile.height && this.form.heightFeet <= 0 || !this.user.profile.height && this.form.heightFeet > 8) {
            this.errors.heightFeet = 'Please enter a valid height in feet';
            hasError = true;
          }
          if (!this.user.profile.inches && this.form.heightInches === '' || !this.user.profile.inches && this.form.heightInches === null) {
            this.errors.heightInches = 'Inches is required';
            hasError = true;
          } else if (!this.user.profile.inches && isNaN(this.form.heightInches) || !this.user.profile.inches && this.form.heightInches < 0 || !this.user.profile.inches && this.form.heightInches >= 12) {
            this.errors.heightInches = 'Please enter a valid number of inches';
            hasError = true;
          }
          break;

        case 2:
          // Client Registration Step 4: Lifestyle Information
          if (!this.user.profile.maritalStatus && !this.form.maritalStatus) {
            this.errors.maritalStatus = 'Marital Status is required';
            hasError = true;
          }
          if(this.form.haveKids === 'Yes') {
            if (this.form.children === '' || this.form.children === null) {
              this.errors.children = 'Have Kids is required';
              hasError = true;
            }
          } else {
            if (this.form.children === '' || this.form.children === null) {
              this.form.children = ["0"];
            }
          }
          if (!this.user.profile.religion && !this.form.religion) {
            this.errors.religion = 'Religion is required';
            hasError = true;
          }
          if (this.user.profile.smoker == null && this.form.smoker === false && this.form.smoker === '') { // Adjusted for boolean
            this.errors.smoker = 'Smoker status is required';
            hasError = true;
          }
          if (!this.user.profile.drinker && !this.form.drinker) {
            this.errors.drinker = 'Drinker status is required';
            hasError = true;
          }
        break;

        case 3:
          // Client Registration Step 5: Professional and Hobbies
          if (!this.user.profile.education && !this.form.education) {
            this.errors.education = 'Education is required';
            hasError = true;
          }
          if (!this.user.profile.occupation && !this.form.occupation) {
            this.errors.occupation = 'Occupation is required';
            hasError = true;
          }
          if (!this.user.profile.jobtitle && !this.form.jobTitle) {
            this.errors.jobTitle = 'Job Title is required';
            hasError = true;
          }
          if (!this.user.profile.languages && !this.form.languages) {
            this.errors.languages = 'Languages is required';
            hasError = true;
          }
        break;

        case 4:
          if (!this.user.seeking.summarize && !this.form.seeking) {
            this.errors.seeking = 'Please summerize what you are seeking in your match';
            hasError = true;
          }
          if(!this.user.seeking.min_age && !this.form.min_age) {
            this.errors.min_age = 'Please Enter Minimum Age';
            hasError = true;
          } else if (!this.user.seeking.min_age && isNaN(this.form.min_age) || !this.user.seeking.min_age && this.form.min_age < 18 || !this.user.seeking.min_age && this.form.min_age > 100) {
            this.errors.age = 'Please enter a valid minimum age between 18 and 100';
            hasError = true;
          }
          if(!this.user.seeking.max_age && !this.form.max_age) {
            this.errors.max_age = 'Please Enter Maximum Age';
            hasError = true;
          } else if (!this.user.seeking.max_age && isNaN(this.form.max_age) || !this.user.seeking.max_age && this.form.max_age < 18 || !this.user.seeking.max_age && this.form.max_age > 100) {
            this.errors.age = 'Please enter a valid maximum age between 18 and 100';
            hasError = true;
          }
          if (!this.user.seeking.current_kids_number && this.form.current_kids_number === '' || !this.user.seeking.current_kids_number && this.form.current_kids_number === null) {
            this.errors.current_kids_number = 'Current Children is required';
            hasError = true;
          }
          if (!this.user.seeking.desired_kids_number && this.form.desired_children === '' || !this.user.seeking.desired_kids_number && this.form.desired_children === null) {
            this.errors.desired_children = 'Desired Children is required';
            hasError = true;
          }
          if (!this.user.seeking.haircolor && !this.form.seeking_hair_color) {
            this.errors.seeking_hair_color = 'Hair Color is required';
            hasError = true;
          }
          if (!this.user.seeking.gender && !this.form.seeking_gender) {
            this.errors.gender = 'Gender is required';
            hasError = true;
          }
          if (!this.user.seeking.bodytype && !this.form.seeking_body_type) {
            this.errors.bodyType = 'Body Type is required';
            hasError = true;
          }
          if (!this.user.seeking.maritalstatus && !this.form.seeking_marital_status) {
            this.errors.maritalStatus = 'Marital Status is required';
            hasError = true;
          }
          if (!this.user.seeking.religion && !this.form.seeking_religion) {
            this.errors.religion = 'Religion is required';
            hasError = true;
          }
          if (!this.user.seeking.smoker && !this.form.seeking_smoker) {
            this.errors.smoker = 'Smoker is required';
            hasError = true;
          }
          if (!this.user.seeking.drinker && !this.form.seeking_drinker) {
            this.errors.drinker = 'Drinker is required';
            hasError = true;
          }
          if (!this.user.seeking.location && !this.form.seeking_location) {
            this.errors.seeking_location = 'Location is required';
            hasError = true;
          }
          if (!this.user.seeking.ethnicity && !this.form.seeking_ethnicity) {
            this.errors.seeking_ethnicity = 'Ethnicity is required';
            hasError = true;
          }
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
    goToStep(number) {
      if (this.steps.includes(number)) {
        this.currentStep = number;
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
    async updateData() {
      this.processing = true;
      this.clearErrors();
      this.successMessage = '';

      // Create a FormData object
      const formData = new FormData();

      // Append basic fields      
      // Explicitly convert boolean values
      formData.append('ismatchmaker', this.form.ismatchmaker === true ? '1' : '0');
      // Append location details
      if(!this.user.phone_number) {
        formData.append('phone_number', this.form.phone_number);
      }
      if(!this.user.profile.age){
        formData.append('age', this.form.age);
      }
      if (this.user.profile.profile_image1 == null && this.files.profile_image1) {
        formData.append('profile_image1', this.files.profile_image1);
      }
      if (this.user.profile.profile_image2 == null && this.files.profile_image2) {
        formData.append('profile_image2', this.files.profile_image2);
      }
      // Append all client-specific fields
      if(!this.user.profile.gender) {
        formData.append('gender', this.form.gender);
      }
      if(!this.user.profile.haircolor) {
        formData.append('hairColor', this.form.hairColor);
      }
      if(!this.user.profile.bodytype) {
        this.form.bodyType.forEach(item => {
          formData.append('bodyType[]', item); // Append directly without JSON.stringify
        });
      }
      if(!this.user.profile.ethnicity) {
        this.form.ethnicity.forEach(item => {
          formData.append('ethnicity[]', item);
        });
      }
      if(!this.user.profile.height) {
        formData.append('heightFeet', this.form.heightFeet);
      }
      if(!this.user.profile.inches) {
        formData.append('heightInches', this.form.heightInches);
      }

      if(!this.user.profile.maritalStatus) {
        this.form.maritalStatus.forEach((status) => {
          formData.append('maritalStatus[]', status);
        });
      }
      if (this.form.children.length > 0) {
        this.form.children.forEach((child) => {
          formData.append('children[]', child);
        });
      } else {
        formData.append('children[]', "0"); // Or skip if optional
      }
      if(!this.user.profile.religion) {
        this.form.religion.forEach(item => {
          formData.append('religion[]', item); // Append directly without JSON.stringify
        });
      }
      formData.append('having_kids', this.form.haveKids);
      formData.append('having_kids_in_future', this.form.haveKidsFuture);
      if(this.user.profile.smoker == null) {
        formData.append('smoker', this.form.smoker === true ? '1' : '0');
      }
      if(!this.user.profile.drinker) {
        formData.append('drinker', this.form.drinker);
      }
      if(!this.user.profile.education) {
        formData.append('education', this.form.education);
      }
      if(!this.user.profile.occupation) {
        formData.append('occupation', this.form.occupation);
      }
      if(!this.user.profile.jobtitle) {
        formData.append('jobTitle', this.form.jobTitle);
      }
      if(!this.user.profile.sports) {
        formData.append('sports', this.form.sports);
      }
      if(!this.user.profile.hobbies) {
        formData.append('hobbies', this.form.hobbies);
      }
      if(!this.user.profile.languages) {
        this.form.languages.forEach((item, index) => {
          formData.append(`languages[${index}][language]`, item.language); // Append the language
          formData.append(`languages[${index}][level]`, item.level);     // Append the level
        });
      }
      if(!this.user.seeking.summarize) {
        formData.append('seeking', this.form.seeking);
      }
      if(!this.user.seeking.min_age) {
        formData.append('min_age', this.form.min_age);
      }
      if(!this.user.seeking.max_age) {
        formData.append('max_age', this.form.max_age); 
      }
      if(!this.user.seeking.current_kids_number) {
        formData.append('current_kids_number', this.form.current_kids_number); 
      }
      if(!this.user.seeking.desired_kids_number) {
        formData.append('desired_children', this.form.desired_children);
      }
      if(!this.user.seeking.haircolor) {
        formData.append('seeking_hair_color', this.form.seeking_hair_color); 
      }
      if(!this.user.seeking.gender) {
        formData.append('seeking_gender', this.form.seeking_gender); 
      }
      if(!this.user.seeking.bodytype) {
        formData.append('seeking_body_type', this.form.seeking_body_type); 
      }
      if(!this.user.seeking.maritalstatus) {
        formData.append('seeking_marital_status', this.form.seeking_marital_status); 
      }
      if(!this.user.seeking.location) {
        formData.append('seeking_location', this.form.seeking_location); 
      }
      if(!this.user.seeking.religion) {
        formData.append('seeking_religion', this.form.seeking_religion); 
      }
      if(!this.user.seeking.smoker) {
        formData.append('seeking_smoker', this.form.seeking_smoker); 
      }
      if(!this.user.seeking.drinker) {
        formData.append('seeking_drinker', this.form.seeking_drinker);
      }
      if(!this.user.seeking.ethnicity) {
        formData.append('seeking_ethnicity', this.form.seeking_ethnicity);
      }

      try {
        // axios.defaults.headers.common.Authorization = `Bearer ${this.authorization.token}`;
        const response = await axios.post('/api/user/update-profile-dashboard', formData);
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
          console.log('error: ', error)
          this.errors.general = error.response?.data?.message || 'An unexpected error occurred.';
        }
      } finally {
        this.processing = false;
      }
    },
  },
  mounted() {
    this.generateAvailableDates();
    this.generateAvailableTimes();
    this.getAppointments();
    this.getUserProfileScore();
  },
};
</script>

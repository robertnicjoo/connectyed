<template>
    <div class="password-form">
        <div class="row">
            <div class="col-md-12">
              <strong>Update Password</strong>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label for="password">Password</label>
                    <div class="input-wrapper">
                        <input
                            :class="inputClass"
                            :type="showPassword ? 'text' : 'password'"
                            id="password"
                            v-model="password"
                            :placeholder="'Enter new password'"
                        />
                        <button type="button" @click="toggleShowPassword">
                            <i
                                :class="
                                    showPassword
                                        ? 'fas fa-eye'
                                        : 'fas fa-eye-slash'
                                "
                            ></i>
                        </button>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label for="confirmPassword">Confirm Password</label>
                    <div class="input-wrapper">
                        <input
                            :class="inputClass"
                            :type="showConfirmPassword ? 'text' : 'password'"
                            id="confirmPassword"
                            v-model="confirmPassword"
                            :placeholder="'Confirm new password'"
                        />
                        <button
                            type="button"
                            @click="toggleShowPasswordConfirm"
                        >
                            <i
                                :class="
                                    showConfirmPassword
                                        ? 'fas fa-eye'
                                        : 'fas fa-eye-slash'
                                "
                            ></i>
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <div v-if="errorMessage" class="error-message">
            {{ errorMessage }}
        </div>
        <div v-if="successMessage" class="success-message">
            {{ successMessage }}
        </div>

        <button
            :class="buttonClass"
            @click.prevent="handleSubmit"
            :disabled="isSubmitting"
        >
            Update
        </button>
    </div>
</template>

<script setup>
import { ref, computed } from "vue";
import axios from "axios";

// Access props using defineProps
const props = defineProps({
    email: String, // Expecting the email to be passed from parent
    token: String, // Expecting the reset token to be passed from parent
});

// Refs for form fields
const password = ref("");
const confirmPassword = ref("");
const showPassword = ref(false);
const showConfirmPassword = ref(false);
const errorMessage = ref("");
const successMessage = ref("");
const isSubmitting = ref(false);

// Computed classes for styling
const inputClass = computed(() => "default-input-class");
const buttonClass = "save-button-class";

// Password visibility toggle functions
const toggleShowPassword = () => {
    showPassword.value = !showPassword.value;
};

const toggleShowPasswordConfirm = () => {
    showConfirmPassword.value = !showConfirmPassword.value;
};

// Password validation function
const validatePasswords = () => {
    if (!password.value || !confirmPassword.value) {
        errorMessage.value = "Both fields are required.";
        successMessage.value = "";
        return false;
    }
    if (password.value !== confirmPassword.value) {
        errorMessage.value = "Passwords do not match.";
        successMessage.value = "";
        return false;
    }
    errorMessage.value = "";
    return true;
};

// Form submission function
const handleSubmit = async () => {
    if (!validatePasswords()) return;

    isSubmitting.value = true;
    console.log("props.email", props.email);
    try {
        // Send email, token, and passwords to the backend for password reset
        const response = await axios.post("/api/password/reset", {
            email: props.email, // Use props directly
            token: props.token, // Use props directly
            password: password.value,
            password_confirmation: confirmPassword.value,
        });

        if (response.data.message === "Password reset successfully.") {
            successMessage.value = "Password successfully updated!";
            errorMessage.value = "";
        } else {
            errorMessage.value = "Failed to reset password. Please try again.";
            successMessage.value = "";
        }
    } catch (error) {
        console.error(error);
        errorMessage.value = "An error occurred while resetting the password.";
        successMessage.value = "";
    } finally {
        isSubmitting.value = false;
    }
};
</script>

<style scoped>
.password-form {
    margin: 2rem auto;
    padding: 20px;
    background-color: #f9f9f9;
    border-radius: 8px;
}

.input-wrapper {
    position: relative;
}

input {
    width: 100%;
    padding: 8px;
    margin: 8px 0;
    border: 1px solid #ccc;
    border-radius: 4px;
}

button[type="button"] {
    position: absolute;
    right: 10px;
    top: 50%;
    transform: translateY(-50%);
    background: none;
    border: none;
    cursor: pointer;
}

.error-message {
    color: red;
    margin-top: 10px;
}

.success-message {
    color: green;
    margin-top: 10px;
}

.save-button-class {
    background-color: #4caf50;
    color: white;
    padding: 10px 20px;
    border: none;
    cursor: pointer;
    border-radius: 4px;
}

.save-button-class:disabled {
    background-color: #ccc;
    cursor: not-allowed;
}
</style>

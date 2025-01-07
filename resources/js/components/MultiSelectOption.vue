<template>
    <div class="mb-2">
      <label class="block text-gray-700 text-sm font-bold mb-2">{{ label }}</label>
  
      <!-- Search Input -->
      <div v-if="enableSearch" class="relative mb-2">
        <input
          type="text"
          v-model="searchQuery"
          :placeholder="'Search ' + label"
          class="block w-full bg-white border border-gray-300 rounded-md py-2 px-3 shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500"
        />
      </div>
  
      <!-- Dropdown -->
      <div class="relative">
        <div
          class="block w-full bg-white border border-gray-300 rounded-md py-2 px-3 shadow-sm cursor-pointer"
          @click="toggleDropdown"
        >
          {{ selectedOptions.length > 0 ? selectedOptions.join(', ') : `Select ${label}` }}
        </div>
  
        <ul
          v-show="dropdownOpen"
          class="absolute z-10 bg-white border border-gray-300 rounded-md mt-1 max-h-60 w-full overflow-y-auto shadow-lg"
        >
          <li
            v-for="option in filteredOptions"
            :key="option"
            @click="toggleSelection(option)"
            :class="{
              'bg-blue-100 text-blue-700': selectedOptions.includes(option),
              'hover:bg-gray-200': !selectedOptions.includes(option),
            }"
            class="px-4 py-2 cursor-pointer"
          >
            {{ option }}
          </li>
        </ul>
      </div>
  
      <!-- Error Message -->
      <p v-if="error && errorMessage" class="mt-1 text-red-500 text-sm">
        {{ errorMessage }}
      </p>
    </div>
  </template>
  
  <script>
  export default {
    name: 'MultiSelectOption',
    props: {
      label: {
        type: String,
        required: true,
      },
      options: {
        type: Array,
        required: true,
      },
      modelValue: {
        type: Array,
        required: false,
        default: () => [],
      },
      required: {
        type: Boolean,
        default: false,
      },
      error: {
        type: Boolean,
        default: false,
      },
      errorMessage: {
        type: String,
        default: '',
      },
      enableSearch: {
        type: Boolean,
        default: false,
      },
    },
    data() {
      return {
        searchQuery: '',
        dropdownOpen: false,
        selectedOptions: [...this.modelValue],
      };
    },
    computed: {
      filteredOptions() {
        if (!this.searchQuery || !this.enableSearch) {
          return this.options;
        }
  
        const query = this.searchQuery.toLowerCase();
        return this.options.filter((option) =>
          option.toLowerCase().includes(query)
        );
      },
    },
    methods: {
      toggleDropdown() {
        this.dropdownOpen = !this.dropdownOpen;
      },
      toggleSelection(option) {
        const index = this.selectedOptions.indexOf(option);

        if (index === -1) {
          this.selectedOptions.push(option);
        } else {
          this.selectedOptions.splice(index, 1);
        }

        this.$emit('update:modelValue', this.selectedOptions);
      },
      handleClickOutside(event) {
        const dropdown = this.$el.querySelector('.relative');
        if (dropdown && !dropdown.contains(event.target)) {
          this.dropdownOpen = false;
        }
      },
    },
    mounted() {
      document.addEventListener('click', this.handleClickOutside);
    },
    beforeUnmount() {
      document.removeEventListener('click', this.handleClickOutside);
    },
    watch: {
      dropdownOpen(value) {
        if (!value) {
          this.searchQuery = '';
        }
      },
      modelValue(newValue) {
        this.selectedOptions = [...newValue];
      },
    },
  };
  </script>
  
  <style scoped>
  .block {
    font-size: 16px;
    line-height: 1.5;
  }
  
  ul {
    scrollbar-width: thin;
  }
  
  ul::-webkit-scrollbar {
    width: 6px;
  }
  
  ul::-webkit-scrollbar-thumb {
    background-color: #ccc;
    border-radius: 4px;
  }
  
  ul::-webkit-scrollbar-thumb:hover {
    background-color: #aaa;
  }
  
  /* Highlight selected items */
  .bg-blue-100 {
    background-color: #ebf8ff;
  }
  
  .text-blue-700 {
    color: #2b6cb0;
  }
  </style>
  
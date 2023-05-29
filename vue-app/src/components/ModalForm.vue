<script>
import NotificationToast from "./NotificationToast.vue";
export default {
  components: {
    NotificationToast,
  },
  emits: ["pharmacy-created"],
  data() {
    return {
      show: false,
      id: null,
      name: null,
      address: null,
      latitude: null,
      longitude: null,
      errors: [],
    };
  },
  methods: {
    openModal(pharmacy = null) {
      this.show = true;
      const { name, address, latitude, longitude } = pharmacy?.attributes || {};
      this.name = name || null;
      this.address = address || null;
      this.latitude = latitude || null;
      this.longitude = longitude || null;
    },
    submit() {
      const data = {
        name: this.name,
        address: this.address,
        latitude: this.latitude,
        longitude: this.longitude,
      };

      this.axios
        .post(`/api/pharmacies`, data)
        .then((response) => {
          this.showSuccessNotification(response.data.message);
          this.$emit("pharmacy-created", response.data.data);
          this.hide();
        })
        .catch((error) => {
          this.errors = error.response.data.errors;
          setTimeout(() => (this.errors = []), 3000);
          this.showSuccessNotification("Revisa bien los campos");
        });
    },
    hide() {
      this.show = false;
    },
    showSuccessNotification(message) {
      this.$refs.notification.showNotification(message, "success");
    },
  },
};
</script>

<template>
  <NotificationToast ref="notification" />

  <div
    v-if="show"
    @click.self="hide()"
    class="overflow-y-auto overflow-x-hidden flex fixed z-40 justify-center items-center w-full md:inset-0 h-modal md:h-full shadow-xl"
  >
    <div class="relative p-4 w-full max-w-2xl h-full md:h-auto">
      <div class="relative p-4 bg-white rounded-lg shadow">
        <div
          class="flex justify-between items-center pb-4 mb-4 rounded-t border-b sm:mb-5"
        >
          <h3 class="text-lg font-semibold text-gray-900">
            Registrar Farmacia
          </h3>
          <button
            @click="hide()"
            type="button"
            class="text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm p-1.5 ml-auto inline-flex items-center"
          >
            <svg
              aria-hidden="true"
              class="w-5 h-5"
              fill="currentColor"
              viewBox="0 0 20 20"
              xmlns="http://www.w3.org/2000/svg"
            >
              <path
                fill-rule="evenodd"
                d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z"
                clip-rule="evenodd"
              ></path>
            </svg>
            <span class="sr-only">Close modal</span>
          </button>
        </div>
        <!-- Modal body -->
        <form @submit.prevent="submit()">
          <div class="flex flex-col gap-4 mb-4">
            <div>
              <label
                for="name"
                class="block mb-2 text-sm font-medium text-gray-900"
                >Farmacia</label
              >
              <input
                type="text"
                id="name"
                v-model="name"
                class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5"
                placeholder=" Ingresa nombre de la farmacia"
              />
              <p class="text-sm text-red-500 ml-4 mt-1" v-if="errors.name">
                {{ errors.name[0] }}
              </p>
            </div>
            <div>
              <label
                for="address"
                class="block mb-2 text-sm font-medium text-gray-900"
                >Direccion</label
              >
              <input
                type="text"
                id="address"
                v-model="address"
                class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5"
                placeholder="Ingresa una direccion"
              />
              <p class="text-sm text-red-500 ml-4 mt-1" v-if="errors.address">
                {{ errors.address[0] }}
              </p>
            </div>
            <div>
              <label
                for="latitude"
                class="block mb-2 text-sm font-medium text-gray-900"
                >Latitud</label
              >
              <input
                type="number"
                id="latitude"
                v-model="latitude"
                step="any"
                class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5"
                placeholder="Ingresa una latitude"
              />
              <p class="text-sm text-red-500 ml-4 mt-1" v-if="errors.latitude">
                {{ errors.latitude[0] }}
              </p>
            </div>
            <div>
              <label
                for="longitude"
                class="block mb-2 text-sm font-medium text-gray-900"
                >Longitud</label
              >
              <input
                type="number"
                id="longitude"
                v-model="longitude"
                step="any"
                class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5"
                placeholder="Ingresa una direccion"
              />
              <p class="text-sm text-red-500 ml-4 mt-1" v-if="errors.longitude">
                {{ errors.longitude[0] }}
              </p>
            </div>
          </div>
          <button
            type="submit"
            class="text-gray-100 inline-flex items-center bg-gray-800 hover:bg-primary-800 focus:ring-4 focus:outline-none focus:ring-primary-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center"
          >
            Submit
          </button>
        </form>
      </div>
    </div>
  </div>
</template>
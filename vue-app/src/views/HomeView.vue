<script scoped>
import NotificationToast from "../components/NotificationToast.vue";
import ModalForm from "../components/ModalForm.vue";
import PharmacyDetails from "../components/PharmacyDetails.vue";

export default {
  name: "HomeView",
  components: {
    NotificationToast,
    ModalForm,
    PharmacyDetails,
  },
  data() {
    return {
      pharmacies: [],
      name: "",
      address: "",
      latitude: null,
      longitude: null,
      locationAvailable: false,
    };
  },
  methods: {
    onPharmacyCreated(pharmacy) {
      this.pharmacies.push(pharmacy);
    },
    showModal(id = null, index = null) {
      this.$refs.modalForm.openModal(!id ? null : id, this.pharmacies[index]);
    },
    viewPharmacy(id, index) {
      this.$refs.pharmacyDetails.viewPharmacy(id);
    },
    restorePharmacies() {
      this.axios
        .get(`/api/pharmacies?lat=${this.latitude}&lon=${this.longitude}`)
        .then((response) => (this.pharmacies = response.data.data));
    },
    showNearbyPharmacies() {
      this.axios
        .get(
          `/api/pharmacies-nearest?lat=${this.latitude}&lon=${this.longitude}`
        )
        .then((response) => (this.pharmacies = response.data.data));
    },
    showSuccessNotification(message) {
      this.$refs.notification.showNotification(message, "success");
    },
  },
  mounted() {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(
        (position) => {
          this.latitude = position.coords.latitude;
          this.longitude = position.coords.longitude;
          this.locationAvailable = true;

          this.axios
            .get(`/api/pharmacies?lat=${this.latitude}&lon=${this.longitude}`)
            .then((response) => (this.pharmacies = response.data.data))
            .catch((error) => console.log(error));
        },
        () => (this.locationAvailable = false)
      );
    } else {
      this.locationAvailable = false;
    }
  },
};
</script>

<template>
  <main class="p-5">
    <div>
      <p v-if="locationAvailable">
        Latitud: {{ latitude }} Longitud: {{ longitude }}
      </p>
      <p v-else>No se pudo obtener la ubicación del usuario</p>
    </div>
    <NotificationToast ref="notification" />

    <ModalForm ref="modalForm" @pharmacy-created="onPharmacyCreated" />

    <PharmacyDetails ref="pharmacyDetails" />

    <h1 class="text-center text-xl font-semibold mb-5">Farmacias</h1>

    <div class="flex items-center justify-between w-full">
      <button
        class="bg-green-500 py-2 px-4 mb-6 rounded text-white font-bold"
        @click="showNearbyPharmacies()"
      >
        Ver farmacias más cercanas a 10M
      </button>
      <button
        class="bg-green-500 py-2 px-4 mb-6 rounded text-white font-bold"
        @click="restorePharmacies()"
      >
        Resetar Lista
      </button>

      <button
        class="bg-green-500 py-2 px-4 mb-6 rounded text-white font-bold"
        @click="showModal()"
      >
        Nuevo registro
      </button>
    </div>

    <div class="relative overflow-x-auto">
      <table class="w-full text-sm text-left text-gray-500">
        <thead class="text-xs text-gray-700 uppercase bg-gray-100">
          <tr>
            <th scope="col" class="px-6 py-3 rounded-l-lg">Farmacia</th>
            <th scope="col" class="px-6 py-3">Direccion</th>
            <th scope="col" class="px-6 py-3">
              <span class="sr-only">Editar</span>
            </th>
          </tr>
        </thead>
        <tbody>
          <tr
            class="bg-white"
            v-for="(pharmacy, index) in pharmacies"
            :key="pharmacy"
          >
            <th
              scope="row"
              class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap"
            >
              {{ pharmacy.attributes.name }}
            </th>
            <td class="px-6 py-4">
              {{ pharmacy.attributes.address }}
            </td>
            <td class="px-6 py-4 text-right">
              <a
                href="#"
                class="font-medium text-blue-600 hover:underline"
                @click="viewPharmacy(pharmacy.id, index)"
              >
                Ver Farmacia
              </a>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </main>
</template>
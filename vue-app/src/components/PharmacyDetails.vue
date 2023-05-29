<script>
export default {
  data() {
    return {
      show: false,
      id: null,
      pharmacy: [],
      name: null,
      address: null,
      latitude: null,
      longitude: null,
    };
  },
  methods: {
    viewPharmacy(id) {
      this.show = true;
      this.axios
        .get("/api/pharmacies/" + id)
        .then((response) => (this.pharmacy = response.data.data));
    },
    hide() {
      this.pharmacy = [];
      this.show = false;
    },
  },
};
</script>

<template>
  <div
    @click.self="hide()"
    v-if="show"
    class="fixed flex justify-center items-center shadow-xl z-40 w-full p-4 overflow-x-hidden overflow-y-auto md:inset-0 h-[calc(100%-1rem)] md:h-full"
  >
    <div class="relative w-full h-full max-w-md md:h-auto">
      <!-- Modal content -->
      <div class="relative bg-white rounded-lg shadow">
        <!-- Modal header -->
        <div class="flex items-center justify-between p-5 border-b rounded-t">
          <h3 class="text-xl font-medium text-gray-900">
            {{ pharmacy && pharmacy.attributes && pharmacy.attributes.name }}
          </h3>
          <button
            @click="hide()"
            type="button"
            class="text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm p-1.5 ml-auto inline-flex items-center"
            data-modal-hide="small-modal"
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
        <div class="p-6 space-y-6">
          <p class="text-base leading-relaxed text-gray-500">
            <span class="text-gray-900 font-bold">Direccion</span>:
            {{ pharmacy && pharmacy.attributes && pharmacy.attributes.address }}
          </p>
          <p class="text-base leading-relaxed text-gray-500">
            {{
              pharmacy && pharmacy.attributes && pharmacy.attributes.latitude
            }}
          </p>
          <p class="text-base leading-relaxed text-gray-500">
            {{
              pharmacy && pharmacy.attributes && pharmacy.attributes.longitude
            }}
          </p>
        </div>
        <!-- Modal footer -->
        <div
          class="flex items-center p-6 space-x-2 border-t border-gray-200 rounded-b"
        >
          <button
            @click="hide()"
            type="button"
            class="text-white bg-gray-700 hover:bg-gray-800 focus:ring-4 focus:outline-none focus:ring-gray-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center"
          >
            Cerrar
          </button>
        </div>
      </div>
    </div>
  </div>
</template>
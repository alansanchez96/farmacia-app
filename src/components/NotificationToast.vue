<script>
export default {
  data() {
    return {
      show: false,
      message: "",
      type: "info",
    };
  },
  methods: {
    showNotification(message, type = "info", duration = 5000) {
      this.message = message;
      this.type = type;
      this.show = true;
      setTimeout(this.hide, duration);
    },
    hide() {
      this.show = false;
    },
  },
};
</script>


<template>
  <div
    v-if="show"
    :class="[
      'fixed top-0 left-0 py-4 px-6 m-6 rounded-md z-20 bg-gray-700 shadow',
      'bg-' + type + '-500 text-gray-100 text-center font-bold',
    ]"
  >
    <p class="text-sm">{{ message }}</p>
  </div>
</template>

<template>
  <q-page class="flex column flex-center">
    <img alt="Djengu logo" src="~assets/djengu-logo.svg" width="400px" />
    <div>
      <a href="https://github.com" target="_blank">
        <q-btn
          href="http://api.djengu.johnkealy.com:8000"
          label="Documentation"
          glossy
          class="q-ma-lg"
          color="primary"
        />
      </a>
      <a href="http://api.djengu.johnkealy.com" target="_blank">
        <q-btn
          label="visit Django API"
          glossy
          class="q-ma-lg"
          color="primary"
        />
      </a>
    </div>

    <q-btn @click="getUserProfile">Get User </q-btn>
  </q-page>
</template>

<script>
export default {
  name: "PageIndex",
  methods: {
    async getUserProfile() {
      const resp = await this.$axios.get("/profile/");
      console.log("response: ", resp);
    },
  },
};
</script>

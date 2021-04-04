<template>
  <q-page class="flex column flex-center">
    <img alt="Djengu logo" src="~assets/djengu-logo.svg" width="400px" />
    <div>
      <a href="https://github.com/johnckealy/djengu" target="_blank">
        <q-btn
          label="Documentation"
          glossy
          class="q-ma-lg"
          color="primary"
        />
      </a>
      <a :href="apiURL" target="_blank">
        <q-btn
          label="visit Django API"
          glossy
          class="q-ma-lg"
          color="primary"
        />
      </a>
    </div>
  </q-page>
</template>

<script>
export default {
  computed: {
    apiURL() {
      return `${process.env.API_URL}/admin`
    }
  }
};
</script>

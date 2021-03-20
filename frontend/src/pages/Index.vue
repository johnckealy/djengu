<template>
  <q-page class="flex column flex-center">
    <img alt="Djengu logo" src="~assets/djengu-logo.svg" width="400px" />
    <div>
    <q-btn
      href="https://api.djengu.johnkealy.com"
      label="Documentation"
      glossy
      class="q-ma-lg"
      color="primary"
    />
    <q-btn
      :href="'https://github.com'"
      target="blank"
      label="visit Django API"
      glossy
      class="q-ma-lg"
      color="primary"
    />
    </div>
  </q-page>
</template>

<script>
export default {
  name: "PageIndex",
};
</script>

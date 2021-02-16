<template>
  <q-page class="flex flex-center">
    <img
      alt="Quasar logo"
      src="~assets/quasar-logo-full.svg"
    >
    <q-btn @click="getUserProfile">Click me</q-btn>
  </q-page>
</template>

<script>
export default {
  name: 'PageIndex',
  methods: {
    async getUserProfile() {
      const resp = await this.$axios.get("/profile/");
      console.log('response: ', resp)
    }
  }
}
</script>

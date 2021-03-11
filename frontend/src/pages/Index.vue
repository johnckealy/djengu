<template>
  <q-page class="flex flex-center">
    <q-btn @click="getUserProfile">Click me</q-btn>
  </q-page>
</template>

<script>
export default {
  name: 'PageIndex',
  methods: {
    async getUserProfile() {
      const resp = await this.$axios.get("/user/");
      console.log(resp.data)
    }
  }
}
</script>

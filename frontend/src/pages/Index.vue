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
      const user = await this.$auth.axios({ url: '/user/', method: 'GET' });
      console.log('User: ', user)
    }
  }
}
</script>

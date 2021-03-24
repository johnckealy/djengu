<template>
  <q-page class="flex column flex-center">
    <img alt="Djengu logo" src="~assets/djengu-logo.svg" width="400px" />
    <h6>Welcome {{ authUserName }}! </h6>
      <p>You are logged in. You can use this page for authenticated actions. </p>
  </q-page>
</template>

<script>

export default {
  name: "PageIndex",
  computed: {
    authUserName() {
      const user = this.$auth.user()
      if (user) {
        return user.first_name
      };
    },
  },
};
</script>

<template>
  <q-toolbar>
    <q-btn
      flat
      dense
      class="q-ma-md"
      icon="person"
      no-caps
      aria-label="Menu"
      @click="openLoginDialog"
    >
      <span class="text-h6 q-mx-sm">Login</span></q-btn
    >

    Logged In: {{ authUser ? authUser.first_name : 'Anonymous' }}

    <q-space />

    <q-btn to="/dashboard" label="Dashboard"  color="black" />


    <q-btn @click="logout" icon="logout" class="q-ma-md" no-caps flat dense
      ><span class="text-h6 q-mx-sm">Logout</span></q-btn
    >
  </q-toolbar>
</template>

<script>
export default {
  name: "Navbar",

  methods: {
    openLoginDialog() {
      this.$store.commit("authInfo/openLoginDialog");
    },
    async logout() {
      await this.$store.dispatch("authInfo/AUTH_LOGOUT");
      this.$route.path == '/' ? this.$router.go() : this.$router.push('/')
    }
  },
  computed: {
    loginDialog() {
      return this.$store.state.authInfo.loginDialog;
    },
    authUser() {
      return this.$store.state.authInfo.authUser;
    },
  },
};
</script>

<style>
</style>
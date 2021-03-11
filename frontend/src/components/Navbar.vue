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

    <q-btn to="/" label="Home"  color="black" />
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
      this.$store.commit("auth/openLoginDialog");
    },
    async logout() {
      await this.$store.dispatch("auth/AUTH_LOGOUT");
      this.$route.path == '/' ? this.$router.go() : this.$router.push('/')
    }
  },
  computed: {
    loginDialog() {
      return this.$store.state.auth.loginDialog;
    },
    authUser() {
      return this.$store.state.auth.authUser;
    },
  },
};
</script>

<style>
</style>
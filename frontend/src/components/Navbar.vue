<template>
  <q-toolbar>
    <router-link to="/">
      <q-avatar @click="$router.push('/')">
        <img src="https://cdn.quasar.dev/logo/svg/quasar-logo.svg" />
      </q-avatar>
    </router-link>

    <span class="text-h6 q-mx-sm">{{ authUser ? authUser.first_name : "" }}</span>
    <q-space />
    <q-btn v-if="!authUser" to="/login" icon="person" class="q-ma-md" no-caps flat dense>
      <span class="text-h6 q-mx-sm">Login</span>
    </q-btn>
    <q-btn v-else @click="logout" icon="logout" class="q-ma-md" no-caps flat dense
      ><span class="text-h6 q-mx-sm">Logout</span>
    </q-btn>
  </q-toolbar>
</template>

<script>
export default {
  name: "Navbar",

  methods: {
    async logout() {
      try {
        await this.$auth.logout();
        this.$q.notify({ message: "Successfully logged out" });
        this.$router.push("/");
      } catch {
        this.$q.notify({
          message: "There was a problem logging out.",
          color: "red-6",
          icon: "error",
        });
      }
    },
  },
  computed: {
    authUser() {
      return this.$auth.user();
    },
  },
};
</script>

<style>
</style>
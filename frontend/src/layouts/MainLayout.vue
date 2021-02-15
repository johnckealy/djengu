<template>
  <q-layout view="lHh Lpr lFf">
    <q-header elevated>
      <q-toolbar class="glossy">
        <q-btn
          flat
          dense
          class="q-ma-md"
          round
          icon="person"
          no-caps
          aria-label="Menu"
          @click="openLoginDialog"
        >
          <span class="text-h6 q-mx-sm">Login</span></q-btn
        >
      </q-toolbar>
    </q-header>

    <login-form />

    <q-page-container>
      <router-view />
    </q-page-container>
  </q-layout>
</template>

<script>
import EssentialLink from "components/EssentialLink.vue";
import LoginForm from "components/LoginForm.vue";

export default {
  name: "MainLayout",
  components: {
    EssentialLink,
    LoginForm,
  },
  mounted() {
    this.$q.notify.setDefaults({
      color: "green-4",
      textColor: "white",
      icon: "warning",
      message: "Login was successful",
      position: "top-right",
      timeout: 2500,
      actions: [{ icon: "close", color: "white" }],
    });
  },
  methods: {
    openLoginDialog() {
      this.$store.commit("authInfo/toggleLoginDialog");
    },
  },
  computed: {
    loginDialog() {
      return this.$store.state.authInfo.loginDialog;
    },
  },
};
</script>

<template>
  <q-layout view="lHh Lpr lFf">
    <!-- Navigation bar -->
    <q-header elevated>
      <navbar />
    </q-header>

    <!-- Hidden Login form Modal -->
    <q-dialog v-model="loginDialog" persistent>
      <login-form />
    </q-dialog>

    <!-- Main content Body -->
    <q-page-container>
      <router-view />
    </q-page-container>
  </q-layout>
</template>

<script>
import EssentialLink from "components/EssentialLink.vue";
import Navbar from "components/Navbar.vue";
import LoginForm from "components/LoginForm.vue";

export default {
  name: "MainLayout",
  components: {
    EssentialLink,
    Navbar,
    LoginForm,
  },
  mounted() {
    this.$q.notify.setDefaults({
      color: "green-4",
      textColor: "white",
      icon: "cloud_done",
      message: "Successful",
      position: "bottom-right",
      timeout: 2000,
      actions: [{ icon: "close", color: "white" }],
    });
  },
  computed: {
    loginDialog() {
      return this.$store.state.authInfo.loginDialog;
    }
  }
};
</script>

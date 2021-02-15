<template>
  <q-dialog v-model="loginDialog" persistent>
    <div class="container">
      <q-card class="q-pa-lg">
        <q-toolbar class="q-pa-sm">
          <q-avatar>
            <img src="https://cdn.quasar.dev/logo/svg/quasar-logo.svg" />
          </q-avatar>

          <q-toolbar-title class="q-mx-16"> Login </q-toolbar-title>

          <q-btn
            flat
            round
            dense
            icon="close"
            v-close-popup
            @click="closeLoginDialog"
          />
        </q-toolbar>
        <q-form @submit="onSubmit" class="q-gutter-md">
          <q-input
            v-model="username"
            label="Username"
            lazy-rules="ondemand"
            :rules="[
              (val) =>
                (val && val.length > 0) || 'Please provide your username',
            ]"
            outlined
          />

          <q-input
            v-model="password"
            label="Password"
            type="password"
            lazy-rules="ondemand"
            :rules="[
              (val) =>
                (val && val.length > 0) || 'Please provide your password',
            ]"
            outlined
          />

          <div>
            <q-btn
              no-caps
              glossy
              class="q-ml-md full-width q-mx-auto"
              label="Submit"
              type="submit"
              color="primary"
            />
          </div>
        </q-form>
      </q-card>
    </div>
  </q-dialog>
</template>

<script>
export default {
  data() {
    return {
      username: null,
      password: null,
    };
  },
  methods: {
    closeLoginDialog() {
      this.$store.commit("authInfo/toggleLoginDialog");
    },
    onSubmit() {
      this.$q.notify({
        message: "Login was successful",
      });
    },
  },
  computed: {
    loginDialog() {
      return this.$store.state.authInfo.loginDialog;
    },
  },
};
</script>
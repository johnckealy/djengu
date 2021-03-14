<template>
  <div class="container">
    <q-card class="q-pa-lg">
      <q-toolbar class="q-pb-lg">
        <q-avatar>
          <img src="https://cdn.quasar.dev/logo/svg/quasar-logo.svg" />
        </q-avatar>

        <q-toolbar-title class="q-mx-sm"> Login </q-toolbar-title>

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
            (val) => (val && val.length > 0) || 'Please provide your username',
          ]"
          outlined
        />

        <q-input
          v-model="password"
          label="Password"
          type="password"
          lazy-rules="ondemand"
          :rules="[
            (val) => (val && val.length > 0) || 'Please provide your password',
          ]"
          outlined
        />

        <div class="text-body1 text-red" v-if="loginErrorMessage">
          There was a problem logging you in. Please check your details.
        </div>

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
</template>

<script>
export default {
  data() {
    return {
      username: null,
      password: null,
      loginErrorMessage: false,
    };
  },
  methods: {
    closeLoginDialog() {
      this.$store.commit("authenticator/closeLoginDialog");
    },
    async onSubmit() {

      const loginOk = await this.$auth.login({
        username: 'jokea',
        password: 'asdf'
      })
      console.log('loginOk', loginOk)
      if (loginOk) {
        this.$q.notify({ message: "Login was successful" });
        this.closeLoginDialog();
        this.$route.path == this.$store.state.authenticator.redirectUrl
          ? this.$router.go()
          : this.$router.push(this.$store.state.authenticator.redirectUrl);
      } else {
        this.$q.notify({
          message: "Login was not successful!",
          color: "red-6",
          icon: "error",
        });
        this.loginErrorMessage = true;
      }
    },
  },
};
</script>
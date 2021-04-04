<template>
  <div class="container">
    <q-card class="q-pa-lg">
      <q-toolbar class="q-pb-lg">
        <q-avatar>
          <img src="https://cdn.quasar.dev/logo/svg/quasar-logo.svg" />
        </q-avatar>

        <q-toolbar-title class="q-mx-sm"> Login </q-toolbar-title>

      </q-toolbar>
      <q-form @submit="onSubmit" class="q-gutter-md">
        <q-input
          v-model="username"
          label="Email"
          lazy-rules="ondemand"
          :rules="[
            (val) => (val && val.length > 0) || 'Please provide your email',
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


        <div v-if="errorMessages" class="text-body1 text-red">
          <p v-for="(message,i) in errorMessages" :key="i" >
            <q-icon color="red" size="18px" name="error_outline" />
            {{ message }}
          </p>
        </div>

        <span class="text-body2 q-pa-md q-ma-md" >Don't have an account? Register <a href="/register">here.</a> </span>

        <div>
          <q-btn
            no-caps
            glossy
            class="q-ml-md full-width q-mx-auto"
            type="submit"
            color="primary"
          >{{ loading ? 'Logging in...' : 'Login' }}
           <q-spinner-ball class="q-mx-lg" v-if="loading" color="white" />
          </q-btn>
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
      errorMessages: [],
      loading: false
    };
  },
  methods: {
    async onSubmit() {
      this.loading = true;
      const response = await this.$auth.login({
        username: this.username,
        password: this.password
      })
      if (response.status === 200) {
        this.$q.notify({ message: "Login was successful" });
        this.$router.push(this.$auth.redirectUrl());
      }
      else {
        this.$q.notify({
          message: "Login failed!",
          color: "red-6",
          icon: "error",
        });
        this.errorMessages = response;
      }
      this.loading = false;
    },
  },
};
</script>
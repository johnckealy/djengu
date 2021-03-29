<template>
  <div class="container">
    <q-card class="q-pa-lg">
      <q-toolbar class="q-pb-lg">
        <q-avatar>
          <img src="https://cdn.quasar.dev/logo/svg/quasar-logo.svg" />
        </q-avatar>

        <q-toolbar-title> Register </q-toolbar-title>
      </q-toolbar>
      <p class="text-subtitle2 q-pa-md">
        <!-- Registration isn't neccessary, but it's useful for saving your search
        preferences! We don't spam, and we take privacy very seriously. -->
      </p>
      <q-form @submit="onSubmit" class="q-gutter-md">
        <q-input
          v-model="firstName"
          label="First Name"
          lazy-rules="ondemand"
          :rules="[
            (val) => (val && val.length > 0) || 'Please provide a first name',
          ]"
          outlined
        />
        <q-input
          v-model="email"
          label="Email address"
          lazy-rules="ondemand"
          :rules="[
            (val) => (val && val.length > 0) || 'Please provide an email address',
          ]"
          outlined
        />

        <q-input
          v-model="password1"
          label="Choose a password"
          type="password"
          lazy-rules="ondemand"
          :rules="[
            (val) => (val && val.length > 0) || 'Please provide a password',
          ]"
          outlined
        />

        <q-input
          v-model="password2"
          label="Repeat password"
          type="password"
          lazy-rules="ondemand"
          :rules="[
            (val) => (val && val.length > 0) || 'Please provide a password',
          ]"
          outlined
        />

       <div v-if="errorMessages" class="text-body1 text-red">
          <p v-for="(message,i) in errorMessages" :key="i" >
            <q-icon color="red" size="18px" name="error_outline" />
            {{ message }}
          </p>
        </div>

        <span class="text-body2 q-pa-md q-ma-md" >Already have an account? Login <a href="/login">here.</a> </span>

        <div>
          <q-btn
            no-caps
            glossy
            class="q-ml-md full-width q-mx-auto"
            type="submit"
            color="primary"
          >{{ loading ? 'Registering...' : 'Register' }}
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
      email: null,
      firstName: null,
      password1: null,
      password2: null,
      errorMessages: '',
      loading: false
    };
  },
  methods: {
    async onSubmit() {
      this.loading = true
      const resp = await this.$auth.register({
        username: this.email,
        email: this.email,
        first_name: this.firstName,
        password1: this.password1,
        password2: this.password2,
      });
      if (resp.status == 201) {
        this.$q.notify({ message: "Account created successfully" });
        this.$router.push('/request-email-confirmation')
      } else {
        this.$q.notify({
          message: "Registration failed!",
          color: "red-6",
          icon: "error",
        });
        this.errorMessages = resp;
      }
      this.loading = false;
    },
  },
};
</script>
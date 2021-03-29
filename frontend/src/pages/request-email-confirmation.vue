<template>
  <div class="row">
    <div class="absolute-center col-md-3 col-12 q-ma-lg q-mx-auto">
      <h1 class="text-h4">
        <q-icon name="mail_outline" />
        We just need you to confirm your email address.</h1>
      <h2 class="text-subtitle1">Please open your email and click the confirm link from us.</h2>
      <div class="row q-ma-lg">
        <q-btn color="dark" glossy @click="resendEmail">
          <q-spinner-ball class="q-mx-lg" v-if="loading" color="white" />
          {{ loading ? '' : 'Resend Email' }}
        </q-btn>
        <q-space/>
        <q-btn color="secondary" glossy to="/login">Go to Login</q-btn>
        <q-space/>
        <q-btn color="primary" glossy to="/">Back to Home</q-btn>
      </div>
    </div>


    <div v-if="errorMessages" class="text-body1 text-red">
      <p v-for="(message,i) in errorMessages" :key="i" >
        <q-icon color="red" size="18px" name="error_outline" />
        {{ message }}
      </p>
    </div>

  </div>
</template>

<script>

export default {
  data: () => ({
    loading: false
  }),
  methods: {
    async resendEmail() {
      this.loading = true;
      try {
        const response = await this.$auth.axios({url: '/register/resend-confirmation-email/', method: 'GET' })
        this.$q.notify({ message: "Registration email resent" })
      }
      catch (e) {
        this.$q.notify({
          message: "There was an issue re-sending the registration email!",
          color: "red-6",
          icon: "error",
        })
      }
      this.loading = false;
    }
  }
};
</script>

<style>
</style>
<template>
  <div class="row">
    <div class="absolute-center col-md-3 col-12 q-ma-lg q-mx-auto">
      <login-form />
    </div>
  </div>
</template>

<script>
import LoginForm from "../components/LoginForm.vue";

export default {
  components: {
    LoginForm,
  },
};
</script>

<style>
</style>
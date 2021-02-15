<template>
  <q-layout view="lHh Lpr lFf">
    <q-header elevated>
      <q-toolbar>
        <q-btn
          flat
          dense
          class="q-pa-lg"
          round
          icon="menu"
          aria-label="Menu"
          @click="openDialog=true"
        > Login {{ openDialog }}</q-btn>
      </q-toolbar>
    </q-header>

    <login-form :openDialog="openDialog" />

    <q-page-container>
      <router-view />
    </q-page-container>
  </q-layout>
</template>

<script>
import EssentialLink from 'components/EssentialLink.vue'
import LoginForm from 'components/LoginForm.vue'

export default {
  name: 'MainLayout',
  components: {
    EssentialLink,
    LoginForm
  },
  data: () => ({
    openDialog: false
  })
}
</script>

import Vue from 'vue'
import axios from 'axios'

import authy from 'vue-auth-jwt'

export default (state) => {

    const store = state.store

    Vue.use(authy, { store });


    axios.defaults.withCredentials = true
    axios.defaults.baseURL = process.env.API_URL

    Vue.prototype.$axios = axios

    if (state.store.state.authy) {
        state.store.state.authy.$axios = axios
    }

}
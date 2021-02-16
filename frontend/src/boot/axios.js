import Vue from 'vue'
import axios from 'axios'

export default (state) => {
    /* Here we give the authorization tokens to Axios,
    and set the Vuex store with that axios instance. */

    axios.defaults.headers.common['Authorization'] =
      'Bearer ' + state.store.getters["authInfo/accessToken"];

    axios.defaults.baseURL = 'http://127.0.0.1:8000'

    Vue.prototype.$axios = axios
    state.store.state.authInfo.$axios = axios
}
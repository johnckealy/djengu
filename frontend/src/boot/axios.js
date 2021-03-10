import Vue from 'vue'
import axios from 'axios'


export default (state) => {
    /* Here we give the authorization tokens to Axios,
    and set the Vuex store with that axios instance. */

    // axios.defaults.headers.common['Authorization'] =
    //   'Bearer ' + state.store.getters["authInfo/accessToken"];

    axios.defaults.withCredentials = true
    axios.defaults.baseURL = process.env.API_URL


    Vue.prototype.$axios = axios
    state.store.state.authInfo.$axios = axios
}
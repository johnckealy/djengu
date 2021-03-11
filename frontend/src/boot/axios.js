import Vue from 'vue'
import axios from 'axios'


export default (state) => {

    axios.defaults.withCredentials = true
    axios.defaults.baseURL = process.env.API_URL

    Vue.prototype.$axios = axios
    state.store.state.authInfo.$axios = axios
}
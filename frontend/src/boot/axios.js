import Vue from 'vue';
import { auth } from 'vue-auth-jwt'



export default (state) => {

    const config = {
        API_URL: process.env.API_URL,
        loginEndpoint: '/login/',
        logoutEndpoint: '/logout/',
        tokenRefreshEndpoint: '/token/refresh',
    }

    Vue.prototype.$auth = auth(state, config)
}


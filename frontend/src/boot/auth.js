import Vue from 'vue';

import Auth from 'vue-auth-jwt';


export default ({ app, router, store, Vue }) => {


    const config = {
      API_BASE_URL: 'https://api.autodevops.com:8000/',
      loginEndpoint: '/login/',
      logoutEndpoint: '/logout/',
      tokenRefreshEndpoint: '/token/refresh/',
      userEndpoint: '/user/',
      loginRoute: '/login'
    }

    Vue.use(Auth, { router, store, config  });

}


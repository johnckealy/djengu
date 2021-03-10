// import { LocalStorage } from 'quasar';


export default {

  namespaced: true,

  getters: {
    // accessToken:  () => LocalStorage.getItem('access-token')
  },

  mutations: {
    closeLoginDialog: (state) => {
      state.loginDialog = false;
    },
    openLoginDialog: (state) => {
      state.loginDialog = true;
    },
    updateRedirectUrl: (state, url) => {
      state.redirectUrl = url;
    },
    checkTokens: (state) => {
      // state.isAuth = !!LocalStorage.getItem('access-token');
    }
  },

  actions: {
    AUTH_LOGIN: async (store, user) => {
      try {
        const response = await store.state.$axios({ url: '/dj-rest-auth/login/', data: user, method: 'POST' })
        // LocalStorage.set('refresh-token', response.data.refresh)
        // LocalStorage.set('access-token', response.data.access)
        return true
      }
      catch {
        // LocalStorage.remove('refresh-token')
        // LocalStorage.remove('access-token')
        return false
      }
    },
    AUTH_LOGOUT: (store) => {
      // LocalStorage.remove('refresh-token')
      // LocalStorage.remove('access-token')
      store.commit('checkTokens')
      store.commit("updateRedirectUrl", '/');
      return true
    }
  },

  state: {
    loginDialog: false,
    redirectUrl: '/',
    isAuth: false
  }

}

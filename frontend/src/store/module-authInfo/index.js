
export default {

  namespaced: true,

  getters: {
    // accessToken:  () => LocalStorage.getItem('access-token')
    // authUser: (state) => state.authUser
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
    setAuthUser: (state, authUser) => {
      state.authUser = authUser;
    }
  },

  actions: {
    AUTH_LOGIN: async (store, user) => {
      try {
        const response = await store.state.$axios({ url: '/login/', data: user, method: 'POST' })
        store.commit("setAuthUser", response.data.user);
        return true
      }
      catch {
        return false
      }
    },
    CHECK_TOKENS: async (store) => {
      try {
        const response = await store.state.$axios({ url: '/user/',  method: 'GET' })
        store.commit("setAuthUser", response.data.user);
      }
      catch (error) {
        console.log('Token verify check failed. Attempting token refresh...')
        try {
          await store.state.$axios({ url: '/token/refresh/', data: {},  method: 'POST' })
          const response = await store.state.$axios({ url: '/user/',  method: 'GET' })
          console.log('response', response)
          store.commit("setAuthUser", response.data.user);
        }
        catch {
          console.log('Token refresh attempt failed.')
        }
      }

    },
    AUTH_LOGOUT: (store) => {
      // store.commit('CHECK_TOKENS')
      store.commit("updateRedirectUrl", '/');
      return true
    }
  },

  state: {
    loginDialog: false,
    redirectUrl: '/',
    authToken: null,
    authUser: null
  }

}

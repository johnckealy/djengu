import Vue from 'vue'
import VueRouter from 'vue-router'
import routes from './routes'


Vue.use(VueRouter)

export default function ({ store, ssrContext }) {
  const Router = new VueRouter({
    scrollBehavior: () => ({ x: 0, y: 0 }),
    routes,
    mode: process.env.VUE_ROUTER_MODE,
    base: process.env.VUE_ROUTER_BASE
  })

  const authDirects = async (to, next) => {
    /* This method checks whether a route requires authentication,
    then redirects the user to the login screen if needed */
    await store.dispatch("authInfo/CHECK_TOKENS");
    if (to.matched.some(route => route.meta.requiresAuth)) {
      if (!!store.state.authInfo.authUser) {
        next();
      } else {
        store.commit("authInfo/updateRedirectUrl", to.path);
        next('/login');
      }
    } else {
      next();
    }
  }


  Router.beforeEach((to, from, next) => {
    authDirects(to, next);
  });

  return Router
}

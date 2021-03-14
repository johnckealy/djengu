import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)


export default function (/* { ssrContext } */) {
  const Store = new Vuex.Store({
    modules: {},

    // enable strict mode (adds overhead!)
    strict: process.env.DEBUGGING
  })

  return Store
}

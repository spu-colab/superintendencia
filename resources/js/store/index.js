import Vue from 'vue'
import Vuex from 'vuex'
import sistema from './modules/sistema'
import auth from './modules/auth'
import demandas from './modules/demandas'
import createPersistedState from 'vuex-persistedstate'

Vue.use(Vuex)

const debug = process.env.NODE_ENV !== 'production'

export default new Vuex.Store({
  modules: {
    sistema,
    auth,
    demandas
  },
  plugins: [createPersistedState()],
  strict: debug
})
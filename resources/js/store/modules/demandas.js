const state = {
    autores: []
}

const getters = {
    autores: (state) => {
        return state.autores
    }
}

const actions = {
}

const mutations = {
    setAutores (state, autores) {
        state.autores = autores
    }
}

export default {
    namespaced: true,
    state,
    getters,
    actions,
    mutations
  }
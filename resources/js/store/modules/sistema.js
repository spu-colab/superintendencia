const state = {
    mensagem: '',
    alerta: '',
    exibirMenu: true
}

const getters = {
    mensagem: (state) => {
        return state.mensagem
    },
    alerta: (state) => {
        return state.alerta
    },
    exibirMenu: (state) => {
        return state.exibirMenu
    }
}

const actions = {
}

const mutations = {
    mensagem (state, msg) {
        window.scrollTo(0,0);
        state.mensagem = msg
        state.alerta = ''
    },
    alerta (state, msg) {
        window.scrollTo(0,0);
        state.mensagem = ''
        state.alerta = msg
    },
    limpar (state, msg) {
        state.mensagem = ''
        state.alerta = ''
    },
    mostraEscondeMenu (state) {
        state.exibirMenu = !state.exibirMenu
    }
}

export default {
    namespaced: true,
    state,
    getters,
    actions,
    mutations
  }
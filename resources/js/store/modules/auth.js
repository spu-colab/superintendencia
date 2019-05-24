import jwt from 'jsonwebtoken'

const state = {
    token: null,
    usuario: null,
    token_expira_em: null
}

const getters = {
    token: (state) => {        
        return state.token
    },
    usuario: (state) => {
        return state.usuario
    },
    token_expira_em: (state) => {
        return state.token_expira_em
    }
}

const actions = {

}

const mutations = {
    setToken(state, token) {
        // console.log('Token atualizado: ' + token)
        let decoded = jwt.decode(token);
        // console.log(decoded)
        if(decoded) {
            state.token = token
            state.usuario = decoded.user
            state.token_expira_em = decoded.exp * 1000
        } else {
            state.token = null
            state.usuario = null
            state.token_expira_em = null
        }
    },
    sair(state) {
        state.token = null
        state.usuario = null
        state.token_expira_em = null
    }
}

export default {
    namespaced: true,
    state,
    getters,
    actions,
    mutations
}
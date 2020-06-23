<template>
    <v-app-bar 
      clipped-left
      color="green darken-2"
      dark
      app
      fixed
    >
      <v-app-bar-nav-icon @click.stop="mostraEscondeMenu" />
      <v-toolbar-title style="width: 350px" class="ml-0 pl-0">
        <v-toolbar-title>SPU-SC</v-toolbar-title>
      </v-toolbar-title>

      <v-spacer></v-spacer>

      <div v-if="usuario">
          <v-btn v-if="exibirTempoSessao" small rounded 
            @click="refreshToken" 
            :color="cor_token_valido_ate_fundo" 
            :outlined="!tempoSessaoTerminando" 
            :text-color="cor_token_valido_ate">
            <small>Sessão expira em {{ token_valido_ate }}</small>
          </v-btn>
          <v-btn icon :title="usuario.nome">
            <v-icon>account_box</v-icon>
          </v-btn>
          <v-btn icon title="Sair" @click="sair">
            <v-icon>exit_to_app</v-icon>
          </v-btn>
      </div>
      <div v-else>
        <v-btn color="primary" title="Entrar" @click="entrar">
          Entrar
          <v-icon>launch</v-icon>
        </v-btn>
      </div>
    </v-app-bar>
</template>

<script>
import rotas from './../../rotas-servico.js'
export default {
  components: { },
  data: () => {
    return {
      drawer: null,
      token_valido_ate: new Date(),
      cor_token_valido_ate: 'white',
      cor_token_valido_ate_fundo: 'white',
      tempoSessaoTerminando: false,
      exibirTempoSessao: false
    };
  },
  methods: {
    sair () {
      this.$store.commit('auth/sair')
      this.$router.push('/')
    },
    entrar () {
      this.$router.push('/login')
    },
    mostraEscondeMenu() {
      this.$store.commit('sistema/exibirMenu')
    },
    refreshToken() {
      this.$http
                .get(rotas.rotas().autenticacao.refresh)
                .then(
                    response => {
                    },
                    error => {
                        console.log(error)
                        this.$store.commit('sistema/alerta', 'Erro ao reiniciar tempo de sessão')
                    }
                )
    },
    formatDate (date) {
        if (!date) return null

        const [year, month, day] = date.split('-')
        return `${day}/${month}/${year}`
    },
    atualizaTempoValidadeToken() {
      let dif = this.$store.getters['auth/token_expira_em'] - new Date().getTime();
      if(dif < 0) {
        this.$store.commit('auth/sair', null)
        if(this.$router.currentRoute.meta.requiresAuth) {
          this.$router.push('/login')
        }
        return
      }

      this.cor_token_valido_ate = 'white'
      this.cor_token_valido_ate_fundo = 'white'
      this.tempoSessaoTerminando = false

      let difDate = new Date(dif);
      let min = difDate.getMinutes()

      if(min > 60) {
        this.exibirTempoSessao = false
      } else {
        this.exibirTempoSessao = true
        if(min > 0) {
          this.token_valido_ate = min + ' minuto' + (min > 1 ? 's' : '')
        } else {
          this.tempoSessaoTerminando = true
          this.cor_token_valido_ate = 'white'
          this.cor_token_valido_ate_fundo = 'red'
          let seg = difDate.getSeconds()
          this.token_valido_ate = seg + ' segundo' + (seg > 1 ? 's' : '')
        }
      }

      this.exibirTempoSessao = true

    }
  },
  computed: {
    usuario () {
        return this.$store.getters['auth/usuario'];
    },
  },
  created() {
    setInterval(this.atualizaTempoValidadeToken, 1000)
  }
}
</script>
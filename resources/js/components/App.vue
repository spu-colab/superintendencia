<template>
  <app-template>
    <router-view></router-view>
  </app-template>
</template>

<script>
import Template from './layout/AppTemplate'
// import MensagemSistema from './layout/MensagemSistema'
// import Cabecalho from './layout/Cabecalho'
export default {
  components: {
    // MensagemSistema, Cabecalho
    // 'app-template': Template
  },
  data: () => ({
    miniMenu: false,
    items: [
      { 
        text: 'Início',
        icon: 'home', 
        route: '/',
        model: true
      },
      { 
        text: 'Demandas',
        icon: 'assignment', 
        route: '/demanda',
        model: true,
        children: [
          {
            text: 'Procedimentos',
            icon: 'account_balance', 
            route: '/procedimento'
          },
          {
            text: 'Demandantes',
            icon: 'record_voice_over', 
            route: '/demandante'
          },
          {
            text: 'Órgãos',
            icon: 'business', 
            route: '/orgao'
          },
        ]
      },
    ]
  }),
  props: {
    source: String
  },
  computed: {
    exibirMenu () {
      return this.$store.getters['sistema/exibirMenu']
    }
  }
}
</script>

<style>
.fade-enter-active, .fade-leave-active {
  transition: opacity .5s;
}
.fade-enter, .fade-leave-to /* .fade-leave-active below version 2.1.8 */ {
  opacity: 0;
}
</style>

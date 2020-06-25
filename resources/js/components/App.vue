<template>
  <app-template>
    <router-view></router-view>
  </app-template>
</template>

<script>
import Template from './layout/AppTemplate'
import rotas from './../rotas-servico'
export default {
  data() {
    return {
      superintendencia: null
    }
  },
  methods: {
    carregarDadosSuperintendencia() {
      // console.log("App.carregarDadosSuperintendencia()")
      this.$http.get(rotas.rotas().organograma.superintendencia)
        .then(
          response => {
            this.superintendencia = response.body
            this.$store.commit('auth/setSuperintendencia', this.superintendencia)
        },
          error => {
            console.log(error)
          })
    }

  },
  mounted() {
    // console.log("App.mounted()");
    this.carregarDadosSuperintendencia();
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

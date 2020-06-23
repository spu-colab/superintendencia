<template>
  <v-app>
    <v-navigation-drawer v-if="usuarioAutenticado" app :value="exibirMenu" clipped left>
      <spu-menu :itensMenu="itensMenu"></spu-menu>      
    </v-navigation-drawer>
    
  <cabecalho/>

    <v-content>
      <mensagem-sistema/>
      <v-breadcrumbs :items="$route.meta.breadcrumb"></v-breadcrumbs>
      <v-container fluid>
        <v-row align="start">
          <v-col cols="12" class="ml-auto" align="start">
            <transition name="fade">
                <slot></slot>
            </transition>
          </v-col>
        </v-row>
      </v-container>
    </v-content>
  </v-app>
</template>

<script>
import MensagemSistema from './MensagemSistema'
import Cabecalho from './Cabecalho'
import Menu from './Menu'

export default {
  components: {
    MensagemSistema, Cabecalho, 'spu-menu' : Menu
  },
  data: () => ({
    menuEsquerda: true,
    miniMenu: false,
    itensMenu: null,
  }),
  
  props: {
    source: String
  },

  methods: {
    carregarMenu() {
        // console.log("Menu.carregarMenu()")
        this.$http.get("/api/auth/menu")
            .then(response => {
                // console.log(response)
                this.itensMenu = response.body
            },
            error => {
                console.log(error)
            });
    }
  },
  
  computed: {
    exibirMenu () {
      return this.$store.getters['sistema/exibirMenu']
    },

    usuarioAutenticado () {
      // console.log("AppTemplate.computed.usuario()")
      this.usuario = this.$store.getters['auth/usuario'];
      return this.usuario
    },

  },

  watch: {
    '$route' () {
      this.breadcrumb = this.$route.meta.breadcrumb
    },

    'usuario' () {
      // console.log("AppTemplate.watch.usuario")
      if(this.usuario) {
        this.carregarMenu()
      } else {
        this.itensMenu = null
      }
    }
  },

  mounted() {
    this.carregarMenu();
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

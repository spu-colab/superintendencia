<template>
  <v-app>
    <v-navigation-drawer v-if="usuarioAutenticado" app :value="exibirMenu" clipped left>
      <spu-menu :itensMenu="menuSistema"></spu-menu>      
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
    usuario: null,
  }),

  methods: {
    carregarMenu() {
        // console.log("AppTemplate.carregarMenu()", this.usuarioAutenticado)
        if(this.usuario == null) {
          return 
        }
        this.$http.get("/api/auth/menu")
            .then(response => {
                // console.log(response)
                this.$store.commit('auth/menu', response.body)
            },
            error => {
                console.log(error)
            });
    }
  },
  
  computed: {

    menuSistema () {
      // console.log("AppTemplate.computed.menuSistema()")
      let itensMenu = this.$store.getters['auth/menu']
      if(itensMenu == null) {
        this.$store.commit('sistema/exibirMenu', false)
      }
      return itensMenu
    },

    exibirMenu () {
      return this.$store.getters['sistema/exibirMenu']
    },

    usuarioAutenticado () {
      // console.log("AppTemplate.computed.usuarioAutenticado()")
      this.usuario = this.$store.getters['auth/usuario'];
      // console.log(this.usuario)
      return this.usuario
    },

  },

  watch: {
    '$route' () {
      this.breadcrumb = this.$route.meta.breadcrumb
    },

    usuario() {
      // console.log("AppTemplate.watch.usuario", this.usuario)
      this.carregarMenu()
    },

  },

  mounted() {
    // console.log("AppTemplate.mounted()")
    // this.carregarMenu();
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

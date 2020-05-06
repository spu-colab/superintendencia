<template>
  <v-app>
    <v-navigation-drawer app v-model="menuEsquerda" clipped left>
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
    itensMenu: [
      { 
        rotulo: 'Início',
        icone: 'home', 
        rota: '/',
      },
      /*
      {
        divisor: true
      },*/
      {
        rotulo: 'Base de Conhecimento',
        icone: 'local_library',
        url: 'http://conhecimento.spu.nossa.floripa.br'
      },
      {
        rotulo: 'SPU-Admin (Interno)',
        icone: 'desktop_windows',
        url: 'http://10.209.232.190/'
      },
      /*
      {
        divisor: true
      },
      */
      { 
        rotulo: 'Atendimento',
        icone: 'how_to_reg', 
        rota: '/atendimento',
      },
      /*
      { 
        rotulo: 'Demarcação',
        icone: 'linear_scale', 
        rota: '/demarcacao',
      },
      */
      { 
        rotulo: 'Geovisualizador',
        icone: 'map', 
        rota: '/geo',
      },
      { 
        rotulo: 'Governança',
        icone: 'near_me', 
        rota: '/governanca',
      },
      { 
        rotulo: 'Correspondência',
        icone: 'email', 
        rota: '/correspondencia',
      },

      { 
        rotulo: 'Judiciais e Controle',
        icone: 'gavel', 
        rota: '/nujuc',
        model: true,
        children: [
          {
            rotulo: 'Procedimentos',
            icone: 'account_balance', 
            rota: '/procedimento'
          },
          {
            rotulo: 'Demandantes',
            icone: 'record_voice_over', 
            rota: '/demandante'
          },
          {
            rotulo: 'Órgãos',
            icone: 'business', 
            rota: '/orgao'
          },
          {
            rotulo: 'Relatórios',
            icone: 'reports',
            rota: '/nujuc'
          },
        ]
      },
      { 
        rotulo: 'Configurações',
        icone: 'build', 
        submenu: [
          {
            rotulo: 'Usuários',
            icone: 'perm_identity', 
            rota: '/permissao'
          },
          {
            rotulo: 'Permissões',
            icone: 'recent_actors', 
            rota: '/perfil'
          },
          {
            rotulo: 'Divisões/Organograma',
            icone: 'location_city', 
            rota: '/organograma'
          },
        ]
      },
    ],
  }),
  props: {
    source: String
  },
  computed: {
    exibirMenu () {
      return this.$store.getters['sistema/exibirMenu']
    }
  },
  watch: {
    '$route' () {
      this.breadcrumb = this.$route.meta.breadcrumb
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

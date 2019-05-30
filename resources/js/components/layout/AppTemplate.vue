<template>
  <v-app id="inspire">
    <v-navigation-drawer
      :clipped="$vuetify.breakpoint.lgAndUp"
      :value="exibirMenu"
      :mini-variant.sync="miniMenu"
      fixed
      app width="210"
    >
      <v-list dense>

        <v-list-tile>
          <v-list-tile-action>
            <v-icon v-if="!miniMenu" @click.stop="miniMenu = !miniMenu">keyboard_arrow_left</v-icon>
            <v-icon v-else @click.stop="miniMenu = !miniMenu">keyboard_arrow_right</v-icon>
          </v-list-tile-action>
        </v-list-tile>

        <template v-for="item in items">

          <v-list-group v-if="item.children" v-model="item.model" :key="item.text"
            :prepend-icon="item.model ? item.icon : item['icon-alt']"
            append-icon="keyboard_arrow_down">

            <v-list-tile slot="activator">
              <v-list-tile-content>
                <v-list-tile-title>
                  <router-link :to="item.route">
                    {{ item.text }}
                  </router-link>
                  <!--
                  <a :href="item.route">
                    {{ item.text }}
                  </a>
                  -->
                </v-list-tile-title>
              </v-list-tile-content>
            </v-list-tile>

            <v-list-tile v-for="(child, i) in item.children" :key="i">
              <v-list-tile-action v-if="child.icon">
                <router-link :to="child.route">
                  <v-icon>{{ child.icon }}</v-icon>
                </router-link>
                <!--
                <a :href="child.route">
                  <v-icon>{{ child.icon }}</v-icon>
                </a>
                -->
              </v-list-tile-action>
              <v-list-tile-content>
                <v-list-tile-title>
                  <router-link :to="child.route">
                    {{ child.text }}
                  </router-link>
                  <!--
                  <a :href="child.route">
                    {{ child.text }}
                  </a>
                  -->
                </v-list-tile-title>
              </v-list-tile-content>
            </v-list-tile>

          </v-list-group>


          <v-list-tile v-else :key="item.text">
            <v-list-tile-action>
              <router-link :to="item.route">
                <v-icon>{{ item.icon }}</v-icon>
              </router-link>
            </v-list-tile-action>
            <v-list-tile-content>
              <v-list-tile-title>
                <router-link :to="item.route">
                  {{ item.text }}
                </router-link>
                <!--
                <a :href="item.route">
                {{ item.text }}
                </a>
                -->
              </v-list-tile-title>
            </v-list-tile-content>
          </v-list-tile>

        </template>
      </v-list>
    </v-navigation-drawer>
    
  <cabecalho/>

    <v-content>
      <mensagem-sistema/>
      <v-container fluid fill-height>
        <transition name="fade">
            <slot></slot>
          <!-- <router-view></router-view> -->
        </transition>
      </v-container>
    </v-content>
  </v-app>
</template>

<script>
import MensagemSistema from './MensagemSistema'
import Cabecalho from './Cabecalho'
export default {
  components: {
    MensagemSistema, Cabecalho
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

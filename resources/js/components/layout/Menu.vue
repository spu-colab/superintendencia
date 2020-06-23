<template>
    <v-list dense>
        <v-list-item v-for="(itemMenu, i) in computedItensMenu" v-bind:key="i">

            <v-list-item-icon v-if="itemMenu.icone">
                <v-icon>{{ itemMenu.icone }}</v-icon>
            </v-list-item-icon>

            <v-list-group v-if="itemMenu.submenu">
                <template v-slot:activator>
                    <v-list-item-title>{{ itemMenu.rotulo }}</v-list-item-title>
                </template>
                <spu-menu :itensMenu="itemMenu.submenu"></spu-menu>
            </v-list-group>

            <v-list-item-content v-else>
                <v-divider v-if="itemMenu.divisor">
                </v-divider>
                <v-list-item-title v-if="itemMenu.rota">
                    <router-link :to="itemMenu.rota + ''">{{ itemMenu.rotulo }}</router-link>
                </v-list-item-title>
                <v-list-item-title v-if="itemMenu.url">
                    <a :href="itemMenu.url" target="_blank">{{ itemMenu.rotulo }}</a>
                </v-list-item-title>
            </v-list-item-content>
          
        </v-list-item>
        <v-divider/>
    </v-list>
</template>

<script>
export default {
    name: 'spu-menu',

    props: {
        itensMenu: {
            type: Array,
        }
    },

    computed: {
        computedItensMenu() {
            return this.itensMenu
        }
    },

}
</script>
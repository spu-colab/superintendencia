<template>
    <v-container fill-height fluid grid-list>
        <!-- primeira linha -->
        <v-layout align-start justify-start row wrap>
            <v-flex d-flex col xs12>
                <v-card tile class="mx-autor">
                    <v-card-title v-if="titulo">
                        <div class="titulo">{{ titulo }}</div>
                    </v-card-title>
                    <v-layout>
                        <v-flex shrink>
                            <v-avatar
                                class="profile"
                                :size="$vuetify.breakpoint.smAndUp ? 80 : 50"
                                :color="color"
                                tile
                            >
                                <v-icon x-large>{{ icon }}</v-icon>
                            </v-avatar>
                        </v-flex>
                        <v-flex>
                            <v-container fill-height fluid grid-list>
                                <v-layout align-start justify-center row wrap>
                                    <p class="text-md-center">
                                        <slot></slot>
                                    </p>
                                </v-layout>
                            </v-container>
                        </v-flex>
                    </v-layout>
                </v-card>
            </v-flex>
        </v-layout>
    </v-container>
</template>

<script>

export default {
    props: {
        titulo: {
            type: String,
            default: null
        },
        icon: {
            type: String,
            default: null
        },
        color: {
            type: String,
            default: 'yellow'
        },
    },    
}
</script>

<style scoped>
.titulo {
  position: absolute;  
  left: 60pt;
  top: 10pt;
}
.profile {
  position: absolute;
  left: -10pt;
  top: -10pt;
  z-index: 1;
}
</style>
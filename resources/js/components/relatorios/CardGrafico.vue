<template>
    <v-card :loading="carregando">
        <v-card-title v-if="titulo">
            <v-icon v-if="iconTitulo" :color="iconColorTitulo">{{ iconTitulo }}</v-icon>
            {{ titulo }}
        </v-card-title>
        <v-card-text>
            <p class="text-md-center">
                <slot v-if="!carregando"></slot>
            </p>
        </v-card-text>
    </v-card>
</template>

<script>

export default {
    props: {
        titulo: {
            type: String,
            default: null
        },
        carregando: {
            type: Boolean,
            default: false
        },
        iconTitulo: {
            type: String,
            default: null
        },
        iconColorTitulo: {
            type: String,
            default: "yellow"
        },
    },    
}
</script>
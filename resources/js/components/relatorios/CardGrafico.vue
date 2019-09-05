<template>
    <v-card>
        <v-card-title v-if="titulo">
            <h3>{{ titulo }}</h3>
        </v-card-title>
        <v-card-text>
            <p class="text-md-center">
                <v-progress-circular indeterminate v-if="carregando" color="grey"></v-progress-circular>
                <slot v-else></slot>
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
    },    
}
</script>
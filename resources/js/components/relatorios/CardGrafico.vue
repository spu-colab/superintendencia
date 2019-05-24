<template>
    <v-card>
        <v-card-title v-if="titulo">
            <h3>{{ titulo }}</h3>
        </v-card-title>
        <v-card-text>
            <p class="text-md-center">
                <slot></slot>
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
    },    
}
</script>
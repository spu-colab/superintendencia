<template>
    <div>
        <!--
        <v-alert :value="mensagem" type="success" transition="scale-transition" dismissible>
            {{ mensagem }}
        </v-alert>
        <v-alert :value="alerta" type="error" transition="scale-transition" dismissible>
            {{ alerta }}
        </v-alert>
        -->
        <v-snackbar :value="mensagem" color="success" bottom>{{ mensagem }}</v-snackbar>
        <v-snackbar :value="alerta" color="error" bottom>{{ alerta }}</v-snackbar>
    </div>
</template>

<script>
export default {
    methods: {
        limparMensagemAposIntervalo () {
            return new Promise(() => {
                setTimeout(() => {
                    // console.log(this.$store.getters['sistema/alerta'])
                    this.$store.commit('sistema/limpar')
                }, 5000)
            })
        },
    },
    computed: {
        mensagem () {
            this.limparMensagemAposIntervalo();
            return this.$store.getters['sistema/mensagem'];
        },
        alerta () {
            this.limparMensagemAposIntervalo();
            return this.$store.getters['sistema/alerta'];
        },
    },
}
</script>

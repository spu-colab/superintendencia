<template>
    <v-container fluid fill-height>
        <v-row align="stretch" justify="center" >
            <v-col xs="12" md="7" align="center">
                <v-form v-model="valid" method="POST">
                    <v-card >
                        <v-card-title>
                            Recuperação de Senha
                        </v-card-title>
                        <v-card-text>
                            <v-text-field v-model="email" 
                                :rules="[validacao.obrigatori, validacao.email]" label="E-mail" required @keyup.enter="submit"></v-text-field>
                        </v-card-text>
                        <v-card-actions>
                            <v-row justify="end" class="mr-2">
                                <v-btn text color="info" @click="submit" :disabled="!valid || carregando">
                                    <v-progress-circular indeterminate v-if="carregando" color="grey" size="20" width="3"></v-progress-circular>
                                    Enviar link para redefinição da minha senha
                                </v-btn>
                            </v-row>
                        </v-card-actions>
                    </v-card>
                </v-form>
            </v-col>
        </v-row>
    </v-container>
</template>

<script>
import rotas from './../rotas-servico.js'
import Validador from './../validacao.js'
export default {
    data: () => ({
        carregando: false,
        valid: false,
        email: '',
        validacao: Validador
    }),
    methods: {
        async submit () {
            let formData = new FormData()
            formData.append('email', this.email)

            // formData.append('csrf_token', $('meta[name="csrf-token"]').attr('content'));

            this.carregando = true
            return this.$http
                .post(rotas.rotas().autenticacao.recuperarSenha, formData)
                .then(
                    response => {
                        console.log(response)
                        this.$store.commit('sistema/mensagem', response.body.message)
                        this.carregando = false
                    },
                    error => {
                        console.log(error)
                        if(error.status == 422) {
                            this.$store.commit('sistema/alerta', 'E-mail não encontrado')
                        } else {
                            this.$store.commit('sistema/alerta', error.message)
                        }
                        this.carregando = false
                    }
                )
        }
    }
}
</script>
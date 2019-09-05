<template>
    <v-layout row justify-center>
        <v-flex xs12 lg5>
            <v-form v-model="valid" method="POST">
                <v-card>
                    <v-card-title>
                    <span class="headline">Identifique-se</span>
                    </v-card-title>
                    <v-card-text>
                        <v-text-field v-model="email" 
                            :rules="[emailRules.required]" label="Login" required @keyup.enter="submit"></v-text-field>
                        <v-text-field
                            v-model="password"
                            :append-icon="showPassword ? 'visibility_off' : 'visibility'"
                            :rules="[passwordRules.required, passwordRules.min]"
                            :type="showPassword ? 'text' : 'password'"
                            name="input-10-1"
                            label="Senha"
                            hint="No mínimo 8 caracteres"
                            counter
                            @click:append="showPassword = !showPassword"
                            @keyup.enter="submit"
                        ></v-text-field>
                    </v-card-text>
                    <v-card-actions>
                        <v-layout row justify-end>
                            <v-btn color="info" @click="submit" :disabled="!valid || carregando">
                                <v-progress-circular indeterminate v-if="carregando" color="grey" size="20" width="3"></v-progress-circular>
                                Enviar
                            </v-btn>
                        </v-layout>
                    </v-card-actions>
                </v-card>
            </v-form>
        </v-flex>
    </v-layout>
</template>

<script>
import rotas from './../rotas-servico.js'
export default {
    data: () => ({
        carregando: false,
        valid: false,
        password: '',
        showPassword: false,
        passwordRules: {
            required: value => !!value || 'Preenchimento obrigatório.',
            min: v => v !== null && v.length >= 8 || 'No mínimo 8 caracteres',
        },
        email: '',
        emailRules: {
            required: v => !!v || 'Login é obrigatório',
            valid: v => /.+@.+\..+/.test(v) || 'E-mail precisa ser válido'
        }
    }),
    methods: {
        async submit () {
            let formData = new FormData()
            formData.append('cpf', this.email)
            formData.append('password', this.password)

            // formData.append('csrf_token', $('meta[name="csrf-token"]').attr('content'));

            this.carregando = true
            return this.$http
                .post(rotas.rotas().autenticacao.login, formData)
                .then(
                    response => {
                        this.$store.commit('auth/setToken', response.data.token)
                        this.$router.push({ path: '/' })
                        this.carregando = false
                        // window.location = rotas.rotas().autenticacao.login
                    },
                    error => {
                        console.log(error)
                        if(error.status == 401) {
                            this.$store.commit('sistema/alerta', 'E-mail e ou senha inválidos')
                        } else {
                            this.$store.commit('sistema/alerta', 'Erro ao tentar efetuar login')
                        }
                        this.carregando = false
                    }
                )
        }
    }
}
</script>
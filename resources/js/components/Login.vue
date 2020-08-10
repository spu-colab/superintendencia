<template>
    <v-container fluid fill-height>
        <v-row align="stretch" justify="center" >
            <v-col xs="12" md="6" align="center">
                <v-form v-model="valid" method="POST">
                    <v-card >
                        <v-card-title>
                            Identifique-se
                        </v-card-title>
                        <v-card-text>
                            <v-text-field v-model="email" 
                                :rules="[emailRules.required]" label="Login" placeholder="Informe seu CPF, somente os números" required @keyup.enter="submit"></v-text-field>
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
                            <v-row justify="end" class="mr-2">
                                <v-spacer/>
                                <v-btn text @click="clicouEsqueceuSenha">Esqueceu sua senha?</v-btn>
                                <v-spacer/>
                                <v-btn color="info" @click="submit" :disabled="!valid || carregando">
                                    <v-progress-circular indeterminate v-if="carregando" color="grey" size="20" width="3"></v-progress-circular>
                                    Entrar
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
                        this.$store.commit('sistema/exibirMenu', true)
                        this.$router.push(this.$route.query.redirect || '/')
                        this.carregando = false
                    },
                    error => {
                        console.log(error)
                        if(error.status == 401) {
                            this.$store.commit('sistema/alerta', 'E-mail e/ou senha inválidos')
                        } else {
                            this.$store.commit('sistema/alerta', 'Erro ao tentar efetuar login')
                        }
                        this.carregando = false
                    }
                )
        },

        clicouEsqueceuSenha() {
            this.$router.push('/recuperar-senha')
        }
    }
}
</script>
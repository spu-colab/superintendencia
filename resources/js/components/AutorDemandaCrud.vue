<template>
    <crud 
        nomeEntidade="Demandante" nomeEntidadePlural="Demandantes"
        :headers="cabecalhos" :items="registros" :carregando="carregando"
        @clicou-item="selecionarParaEdicao" 
        @clicou-salvar="salvar"
        @clicou-cancelar="cancelar"
        @clicou-novo="novo">
        <template slot="detalhe">
            <div v-if="entidadeAtual">
                <v-layout row wrap>
                    <!-- Nome -->
                    <v-flex xs12>
                        <v-text-field label="Nome" v-model="entidadeAtual.nome" 
                            :rules="[validacao.obrigatorio]" required 
                            counter="255"  maxlength="255"/>
                    </v-flex>

                    <!-- Cargo -->
                    <v-flex xs12 lg3>
                        <v-autocomplete label="Cargo"
                        :items="cargos" v-model="entidadeAtual.cargo.id" 
                        :rules="[validacao.obrigatorio]"
                        item-text="cargo" item-value="id"  />
                    </v-flex>

                    <!-- Órgão -->
                    <v-flex xs12 lg9>
                        <v-autocomplete label="Órgão"
                        :items="orgaos" v-model="entidadeAtual.orgao.id" 
                        :rules="[validacao.obrigatorio]"
                        item-text="orgao" item-value="id"  />
                    </v-flex>

                    <!-- E-mail -->
                    <v-flex xs12 md6>
                        <v-text-field label="E-mail" v-model="entidadeAtual.email" 
                            :rules="[validacao.obrigatorio, validacao.email]" required 
                            counter="100"  maxlength="100"/>
                    </v-flex>

                    <!-- Telefone -->
                    <v-flex xs12 md6>
                        <v-text-field label="Telefone" v-model="entidadeAtual.telefone" 
                            counter="14"  maxlength="14" mask="(##)#########"/>
                    </v-flex>
                    
                </v-layout>
            </div>
        </template>
    </crud>
</template>

<script>
import rotas from './../rotas-servico.js'
import CRUD from './CRUD'
export default {
    components: {
        'crud' : CRUD
    },
    data: () => {
        return {
            carregando: true,
            cabecalhos: [
                { 
                    text: 'Nome',
                    value: 'nome',
                    subheader: 'cargoTexto',
                },
                { 
                    text: 'Órgão',
                    value: 'orgaoTexto',
                    subheader: 'siglaOrgaoTexto',
                },
                // *************************
                {
                    value: 'cargoTexto',
                    type: 'hidden',
                    sortable: false,
                    width: '0px'
                },
                {
                    value: 'siglaOrgaoTexto',
                    type: 'hidden',
                    sortable: false,
                    width: '0px'
                },
            ],
            registros: [
            ],
            entidadeAtual: null,
            validacao: {
                obrigatorio: value => !!value || 'Preenchimento obrigatório.',
                min8: v => !!v && v.length >= 8 || 'No mínimo 8 caracteres' ,
                min2: v => !!v && v.length >= 2 || 'No mínimo 2 caracteres',
                email: v => /.+@.+\..+/.test(v) || 'E-mail precisa ser válido'
            },

            cargos: [],
            carregandoCargos: false,

            orgaos: [],
            carregandoOrgaos: false,

        }
    },
    methods: {
        selecionarParaEdicao(item) {
            this.carregarTabelasApoio()
            this.entidadeAtual = item
            console.log('Item selecionado: ' + item.id)
        },
        salvar() {
            let url = rotas.rotas().autorDemanda.criar;
            let formData = new FormData()
            if(this.entidadeAtual.id) {
                formData.append('autordemanda[id]', this.entidadeAtual.id)
                formData.append('_method', 'PUT') 
                url = rotas.rotas().autorDemanda.editar + '' + this.entidadeAtual.id;
            }
            formData.append('autordemanda[nome]', this.entidadeAtual.nome)
            if(this.entidadeAtual.cargo.id) {
                formData.append('autordemanda[idCargo]', this.entidadeAtual.cargo.id)
            }
            if(this.entidadeAtual.orgao.id) {
                formData.append('autordemanda[idOrgao]', this.entidadeAtual.orgao.id)
            }
            formData.append('autordemanda[email]', this.entidadeAtual.email)
            if(this.entidadeAtual.telefone) {
                formData.append('autordemanda[telefone]', this.entidadeAtual.telefone)
            }
            
            this.$http.post(url, formData)
                .then(
                    response => {
                        console.log(response)
                        this.$store.commit('sistema/mensagem', 'Demandante cadastrado com sucesso!')
                        this.$router.push('/demandante')
                    },
                    error => {
                        console.log(error.body)
                        this.$store.commit('sistema/alerta', error.body.message)
                    }
                )
        },

        cancelar() {
            this.carregarItens()
        },

        novo(item) {
            this.carregarTabelasApoio()
            this.entidadeAtual = {
                id: null,
                cargo: {
                },
                orgao: {
                }
            }
        },

        carregarItens() {
            this.carregando = true;
            this.registros = [];
            this.$http.get(rotas.rotas().autorDemanda.listar)
                .then(
                    response => {
                        // console.log(response);
                        response.body.forEach(element => {
                            element.cargoTexto = element.cargo.cargo
                            element.orgaoTexto = element.orgao.orgao
                            element.siglaOrgaoTexto = element.orgao.sigla
                            this.registros.push(element)
                        })
                        this.carregando = false;
                    },
                    error => {
                        this.carregando = false;
                        console.log(error)
                    }
                )
            
        },

        carregarCargos () {
            this.carregandoCargos = true
            this.cargos = []
            this.$http
                .get(rotas.rotas().cargo.listar)
                .then(
                    response => {
                        response.body.forEach(element => {
                            this.cargos.push(element)
                        })
                        this.carregandoCargos = false
                    },
                    error => {
                        console.log(error)
                        this.carregandoCargos = false
                    }
                )
        },

        carregarOrgaos () {
            this.carregandoOrgaos = true
            this.orgaos = []
            this.$http
                .get(rotas.rotas().orgao.listar)
                .then(
                    response => {
                        response.body.forEach(element => {
                            this.orgaos.push(element)
                        })
                        this.carregandoOrgaos = false
                    },
                    error => {
                        console.log(error)
                        this.carregandoOrgaos = false
                    }
                )
        },

        carregarTabelasApoio() {
            this.carregarCargos()
            this.carregarOrgaos()
        }
        
    },
    mounted() {
        this.carregarItens()
    }
}
</script>

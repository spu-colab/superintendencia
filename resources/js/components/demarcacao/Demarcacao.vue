<template>
    <crud 
        nomeEntidade="Demarcação" nomeEntidadePlural="Demarcações"
        :headers="cabecalhos" :items="registros" :carregando="carregando"
        @clicou-item="selecionarParaEdicao" 
        @clicou-salvar="salvar"
        @clicou-cancelar="cancelar"
        @clicou-novo="novo">
        <template slot="detalhe">
            <v-card>
                <v-card-text>
                    <v-tabs v-model="tabAtiva" @change="mudouDeTab">
                        <v-tab>Cadastro</v-tab>
                        <v-tab :disabled="entidadeAtual == null || entidadeAtual.id_demarcacao == null">Georreferenciamento</v-tab>

                        <v-tabs-slider color="primary"></v-tabs-slider>

                        <!-- TAB Cadastro -->
                        <v-tab-item>
                            <div v-if="entidadeAtual">

                                <v-row>
                                    <v-col xs="12" md="4">
                                        <v-autocomplete label="Tipo" clearable
                                            :items="tipos" v-model="entidadeAtual.tipo.id_tipodemarcacao" 
                                            item-text="tipodemarcacao" item-value="id_tipodemarcacao"  />
                                    </v-col>
                                    <v-col xs="12" md="4">
                                        <v-autocomplete label="Situação" clearable
                                            :items="situacoes" v-model="entidadeAtual.situacao.id_situacaodemarcacao" 
                                            item-text="situacaodemarcacao" item-value="id_situacaodemarcacao"  />
                                    </v-col>
                                    <v-col xs="12" md="4">
                                        <v-text-field label="Processo" v-model="entidadeAtual.processo" />
                                    </v-col>
                                </v-row>

                                <v-row>
                                    <v-col xs="12" md="4">
                                        <v-autocomplete label="Trecho" clearable
                                            :items="trechos" v-model="entidadeAtual.trecho.id_trechodemarcacao" 
                                            item-text="trechodemarcacao" item-value="id_trechodemarcacao"  />
                                    </v-col>
                                    <v-col xs="12" md="4">
                                        <v-text-field label="Subtrecho" v-model="entidadeAtual.subtrecho" />
                                    </v-col>
                                    <v-col xs="12" md="4">
                                        <v-text-field label="LPM/LTM" v-model="entidadeAtual.lpm_ltm" />
                                    </v-col>
                                </v-row>

                                <v-row>
                                    <v-col xs="12" md="6">
                                        <v-text-field label="Fonte" v-model="entidadeAtual.fonte" />
                                    </v-col>
                                    <v-col xs="12" md="6">
                                        <v-text-field label="Edital" v-model="entidadeAtual.edital" />
                                    </v-col>
                                </v-row>

                            </div>
                        </v-tab-item>

                        <!-- TAB GEORREFERENCIAMENTO -->
                        <v-tab-item>
                            <v-container>
                                <geo-referenciamento v-if="entidadeAtual"
                                    :idCamada="idCamada" 
                                    :idReferenciado="entidadeAtual.id_demarcacao" 
                                    :atualizarMapa="atualizarMapa"></geo-referenciamento>
                            </v-container>
                        </v-tab-item>
                    </v-tabs>
                </v-card-text>
            </v-card>
        </template>
    </crud>
</template>

<script>
import rotas from './../../rotas-servico.js'
import CRUD from './../CRUD'

const ID_GEO_CAMADA_DEMARCACAO = 6;
const DEMARCACAO_TAB_GEORREFERENCIAMENTO = 1;

export default {

    components: {
        'crud' : CRUD
    },

    data() {
        return {
            cabecalhos: [
                { 
                    text: 'Tipo',
                    value: 'tipodemarcacao'
                },
                { 
                    text: 'Situação',
                    value: 'situacaodemarcacao'
                },
                { 
                    text: 'Trecho',
                    value: 'trechodemarcacao'
                },
                { 
                    text: 'Subtrecho',
                    value: 'subtrecho'
                },
            ],
            registros: [],
            carregando: true,
            entidadeAtual: null,

            carregandoTipos: false,
            tipos: [],

            carregandoSituacoes: false,
            situacoes: [],

            carregandoTrechos: false,
            trechos: [],

            idCamada: ID_GEO_CAMADA_DEMARCACAO,
            atualizarMapa: false,
            tabAtiva: 0,

        }
    },
    
    methods: {
        selecionarParaEdicao(item) {
            // console.log('selecionarParaEdicao')
            // console.log(item)
             // console.log('Item selecionado: ' + item.id)
            this.tabAtiva = 0
            if(item.id_demarcacao > 0) {
                this.$http.get(rotas.rotas().demarcacao.editar + item.id_demarcacao)
                    .then(
                        response => {
                            // console.log('consultando procedimento :' + item.id_demarcacao)
                            // console.log(response)
                            let element = response.body
                            element.tipodemarcacao = element.tipo.tipodemarcacao
                            element.situacaodemarcacao = element.situacao.situacaodemarcacao
                            element.trechodemarcacao = element.trecho.trechodemarcacao
                            this.entidadeAtual = element
                        },
                        error => {
                            console.log(error)
                        }
                    )
            }
        },

        salvar() {
            let formData = new FormData()
            formData.append('id_tipodemarcacao', this.entidadeAtual.tipo.id_tipodemarcacao)
            formData.append('id_situacaodemarcacao', this.entidadeAtual.situacao.id_situacaodemarcacao)
            formData.append('id_trechodemarcacao', this.entidadeAtual.trecho.id_trechodemarcacao)
            formData.append('processo', this.entidadeAtual.processo)
            if(this.entidadeAtual.subtrecho != null) {
                formData.append('subtrecho', this.entidadeAtual.subtrecho)
            }
            if(this.entidadeAtual.lpm_ltm != null) {
                formData.append('lpm_ltm', this.entidadeAtual.lpm_ltm)
            }
            if(this.entidadeAtual.fonte != null) {
                formData.append('fonte', this.entidadeAtual.fonte)
            }
            if(this.entidadeAtual.edital != null) {
                formData.append('edital', this.entidadeAtual.edital)
            }
            if(this.entidadeAtual.datahomologacao != null) {
                formData.append('datahomologacao', this.entidadeAtual.datahomologacao)
            }
            
            let url = rotas.rotas().demarcacao.criar
            if(this.entidadeAtual.id_demarcacao != null) {
                formData.append('_method', 'PUT')
                url = rotas.rotas().demarcacao.editar + '' + this.entidadeAtual.id_demarcacao
            }

            this.$http.post(url, formData)
                .then(
                    response => {
                        // console.log(response)
                        this.$store.commit('sistema/mensagem', 'Demarcação cadastrada com sucesso!')
                        this.$router.push('/demarcacao')
                    },
                    error => {
                        console.log(error.body)
                        this.$store.commit('sistema/alerta', error.body.message)
                    }
                )
        },

        cancelar() {
            
        },

        novo(item) {
            this.entidadeAtual = {
                id_demarcacao: null,
                tipo: {},
                situacao: {},
                trecho: {}
            }
        },

        carregarItens() {
            this.carregando = true;
            this.registros = [];
            this.$http.get(rotas.rotas().demarcacao.listar)
                .then(
                    response => {
                        // console.log(response);
                        response.body.forEach(element => {
                            element.tipodemarcacao = element.tipo.tipodemarcacao
                            element.situacaodemarcacao = element.situacao.situacaodemarcacao
                            element.trechodemarcacao = element.trecho.trechodemarcacao
                            // console.log(element)
                            this.registros.push(element)
                            })
                        this.carregando = false;
                    },
                    error => {
                        console.log(error)
                        this.carregando = false;
                    }
                )
        },

        carregarTipos () {
            this.carregandoTipos = true
            this.tipos = []
            this.$http
                .get(rotas.rotas().demarcacao.tipo.listar)
                .then(
                    response => {
                        response.body.forEach(element => {
                            this.tipos.push(element)
                        })
                        this.carregandoTipos = false
                    },
                    error => {
                        console.log(error)
                        this.carregandoTipos = false
                    }
                )
        },

        carregarSituacoes () {
            this.carregandoSituacoes = true
            this.situacoes = []
            this.$http
                .get(rotas.rotas().demarcacao.situacao.listar)
                .then(
                    response => {
                        response.body.forEach(element => {
                            this.situacoes.push(element)
                        })
                        this.carregandoSituacoes = false
                    },
                    error => {
                        console.log(error)
                        this.carregandoSituacoes = false
                    }
                )
        },

        carregarTrechos () {
            this.carregandoTrechos = true
            this.trechos = []
            this.$http
                .get(rotas.rotas().demarcacao.trecho.listar)
                .then(
                    response => {
                        response.body.forEach(element => {
                            this.trechos.push(element)
                        })
                        this.carregandoTrechos = false
                    },
                    error => {
                        console.log(error)
                        this.carregandoTrechos = false
                    }
                )
        },

        mudouDeTab() {
            this.atualizarMapa = false;
            if(this.isTabGeorreferenciamento()) {
                this.atualizarMapa = true;
            }
        },

        isTabGeorreferenciamento () {
            return this.tabAtiva == DEMARCACAO_TAB_GEORREFERENCIAMENTO
        },

    },

    mounted() {
        this.carregarTrechos()
        this.carregarTipos()
        this.carregarSituacoes()
        if(this.$route.params.id) {
            this.selecionarParaEdicao({ id_demarcacao: this.$route.params.id})
        } else {
            this.carregarItens()
        }
    }
}
</script>
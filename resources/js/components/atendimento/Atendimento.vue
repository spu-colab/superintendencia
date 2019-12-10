<template>
    <v-container fluid fill-height>
        <v-layout column>
            <v-flex xs12>
                <v-layout align-start justify-space-between row>
                        <crud 
                            nomeEntidade="Atendimento" nomeEntidadePlural="Atendimento" verboAdicionarEntidade="Iniciar"
                            :headers="cabecalhos" :items="registros" :carregando="carregando"
                            @clicou-item="selecionarParaEdicao" 
                            @clicou-salvar="salvar"
                            @clicou-cancelar="cancelar"
                            @clicou-novo="novo">
                            <template slot="detalhe">
                                <div v-if="entidadeAtual">                                    
                                    <v-container>
                                        <v-layout row wrap>
                                            <v-flex xs12 md6>
                                                <v-text-field label="Atendente" v-model="entidadeAtual.usuario.name" disabled/>
                                            </v-flex>
                                            <v-flex xs12 md2>
                                                <v-text-field label="Data" v-model="entidadeAtual.data" disabled/>
                                            </v-flex>
                                            <v-flex xs12 md2>
                                                <v-text-field label="Início" v-model="entidadeAtual.inicio" disabled/>
                                            </v-flex>
                                            <v-flex xs12 md2>
                                                <v-text-field label="Fim" v-model="entidadeAtual.fim" disabled/>
                                            </v-flex>
                                        </v-layout>
                                        <v-layout wrap>
                                            <v-flex xs12>
                                                
                                                    <h4>Assuntos</h4>
                                                    <v-container>
                                                        <v-layout wrap>
                                                            <v-flex xs12 md4 lg3 align-start justify-start v-for="assunto in assuntos" v-bind:key="assunto.id">
                                                                <v-checkbox :label="assunto.assunto" align-start v-model="assunto.checked"></v-checkbox>
                                                            </v-flex>
                                                        </v-layout>
                                                    </v-container>
                                            </v-flex>
                                        </v-layout>
                                    </v-container>
                                </div>
                            </template>
                        </crud>
                </v-layout>
            </v-flex>
        </v-layout>     
    </v-container>
</template>

<script>
import Crud from './../CRUD'
import rotas from './../../rotas-servico.js'
import { isArray } from 'util';
export default {
    components: {
        'crud': Crud
    },
    data: () => {
        return {
            cabecalhos: [
                { 
                    text: 'Data',
                    value: 'data'
                },
                { 
                    text: 'Início',
                    value: 'inicio'
                },
                { 
                    text: 'Fim',
                    value: 'fim'
                },
                { 
                    text: 'Atendente',
                    value: 'atendente'
                },
            ],
            registros: [],
            assuntos: [],
            carregando: true,
            entidadeAtual: null
        }
    },
    methods: {
        carregarItens() {
            this.carregando = true;
            this.registros = [];
            let url = rotas.rotas().atendimento.listar + '/listar/2019-12-10';
            this.$http.get(url)
                .then(
                    response => {
                        // console.log(response);
                        response.body.forEach(element => {
                        // console.log(element)
                        let dataHoraInicio = new Date(element.dataHoraInicio)
                        element.data = dataHoraInicio.toLocaleDateString()
                        element.inicio = dataHoraInicio.toLocaleTimeString()

                        element.fim = '--'
                        if(element.dataHoraFim) {
                            let dataHoraFim = new Date(element.dataHoraFim)
                            element.fim = dataHoraFim.toLocaleTimeString()
                        }

                        element.atendente = '--'
                        if(element.usuario && element.usuario.name) {
                            element.atendente = element.usuario.name
                        }
                        
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
        selecionarParaEdicao(item) {
            this.carregarAssuntos()
            this.entidadeAtual = item
            this.preencherAssuntos()
        },
        
        salvar() {
            let formData = new FormData()
            console.log(this.assuntos)
            this.assuntos.forEach(assunto => {
                console.log(assunto)
                if(assunto.checked) {
                    formData.append('idsAssunto[]', assunto.id)
                }
            })
            formData.append('_method', 'PUT')

            let url = rotas.rotas().atendimento.editar + this.entidadeAtual.id

            this.$http.post(url, formData)
                .then(
                    response => {
                        console.log(response)
                        this.$store.commit('sistema/mensagem', 'Atendimento concluído com sucesso!')
                        this.$router.push('/atendimento')
                    },
                    error => {
                        console.log(error.body)
                        this.$store.commit('sistema/alerta', error.body.message)
                    }
                )
        },


        preencherAssuntos() {
            console.log('preencherAssuntos()...')
            if(isArray(this.entidadeAtual.assuntos)) {
                for(var j = 0; j < this.entidadeAtual.assuntos.length; j++) {
                    var assuntoAtendimento = this.entidadeAtual.assuntos[j]
                    console.log('assuntoAtendimento')
                    console.log(assuntoAtendimento)
                    console.log(this.assuntos)
                    for(var i = 0; i < this.assuntos.length; i++) {
                        var assunto = this.assuntos[i]
                        console.log('assunto')
                        console.log(assunto)
                        console.log('assuntoAtendimento')
                        console.log(assuntoAtendimento)
                        assunto.checked = assuntosAtendimento.id == assunto.id
                        console.log(assunto.checked)
                    }
                }
            }
        },

        cancelar() {

        },
        
        novo() {

        },
        carregarAssuntos() {
            this.assuntos = []
            let url = rotas.rotas().atendimento.assunto.listar;
            this.$http.get(url)
                .then(
                    response => {
                        // console.log(response);
                        response.body.forEach(element => {
                            element.checked = false                        
                            this.assuntos.push(element)
                        })
                        this.carregando = false;
                    },
                    error => {
                        console.log(error)
                        this.carregando = false;
                    }
                )
        }
    },
    mounted() {
        this.carregarItens();
    }    
}
</script>
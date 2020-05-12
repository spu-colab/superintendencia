<template>
    <crud v-if="urlBase" ref="crud"
        nomeEntidade="Órgão" nomeEntidadePlural="Órgãos"
        :headers="cabecalhos" 
        :resource-url="urlBase"
        itemKey="id"
        @clicou-item="selecionarParaEdicao" 
        @clicou-salvar="salvar"
        @clicou-cancelar="cancelar"
        @clicou-novo="novo">
        <template slot="detalhe">
            <div v-if="entidadeAtual">
                <!-- Órgão -->
                
                <v-autocomplete label="Natureza" clearable
                    :items="naturezas" v-model="entidadeAtual.natureza.id" 
                    item-text="natureza" item-value="id"  />
                
                <v-autocomplete label="Órgão Pai" clearable
                    :items="orgaosRaiz" v-model="entidadeAtual.orgao_pai.id" 
                    item-text="orgao" item-value="id"  />
                
                <v-text-field label="Órgão" v-model="entidadeAtual.orgao" 
                    :rules="[validacao.obrigatorio, validacao.min8]" required 
                    counter="255" maxlength="255"/>
                <v-text-field label="Sigla" v-model="entidadeAtual.sigla" 
                    :rules="[validacao.obrigatorio, validacao.min2]" required 
                    counter="50"  maxlength="50"/>
                <v-text-field label="E-mail" v-model="entidadeAtual.email" 
                    :rules="[validacao.obrigatorio, validacao.email]" required 
                    counter="100" maxlength="100"  />
                <v-text-field label="Telefone" v-model="entidadeAtual.telefone" 
                    counter="14" maxlength="14" />
            </div>
        </template>
    </crud>
</template>

<script>
import rotas from './../../rotas-servico.js'
import CRUD from './../ApiCrud'
import Validador from './../../validacao';

export default {
    components: {
        'crud' : CRUD
    },
    data: () => {
        return {
            cabecalhos: [
                { 
                    text: 'Natureza',
                    value: 'naturezaorgao'
                },
                { 
                    text: 'Órgão Pai',
                    value: 'orgaopai'
                },
                { 
                    text: 'Órgão',
                    value: 'orgao'
                },
                { 
                    text: 'Sigla',
                    value: 'sigla'
                }
            ],
            entidadeAtual: null,
            validacao: Validador,

            orgaosRaiz: [],
            carregandoOrgaos: false,

            naturezas: [],

            urlBase: rotas.rotas().orgao.listar
        }
    },
    methods: {
        selecionarParaEdicao(item) {
            this.carregarOrgaos()
            this.carregarNaturezas()
            this.entidadeAtual = item
            if(this.entidadeAtual.orgao_pai == null) {
                this.entidadeAtual.orgao_pai = {}
            }
            if(this.entidadeAtual.natureza == null) {
                this.entidadeAtual.natureza = {}
            }
            // console.log('Item selecionado: ' + item.id)
        },
        salvar() {
            let formData = new FormData()
            formData.append('orgao[id]', this.entidadeAtual.id)
            if(this.entidadeAtual.orgao_pai.id) {
                formData.append('orgao[idOrgaoPai]', this.entidadeAtual.orgao_pai.id)
            }
            if(this.entidadeAtual.natureza.id) {
                formData.append('orgao[idNaturezaOrgao]', this.entidadeAtual.natureza.id)
            }
            formData.append('orgao[orgao]', this.entidadeAtual.orgao)
            formData.append('orgao[sigla]', this.entidadeAtual.sigla)
            formData.append('orgao[email]', this.entidadeAtual.email)
            formData.append('orgao[telefone]', this.entidadeAtual.telefone)
            if(this.entidadeAtual.id != null) {
                formData.append('_method', 'PUT') 
            }

            let url = this.entidadeAtual.id === null ? 
                rotas.rotas().orgao.criar : 
                rotas.rotas().orgao.editar + '' + this.entidadeAtual.id;

            this.$http.post(url, formData)
                .then(
                    response => {
                        this.$store.commit('sistema/mensagem', 'Órgão cadastrado com sucesso!')
                        this.$refs.crud.loadItems()
                    },
                    error => {
                        console.log(error.body)
                        this.$store.commit('sistema/alerta', error.body.message)
                    }
                )
        },
        cancelar() {
            this.$refs.crud.loadItems()
        },
        novo(item) {
            this.carregarOrgaos()
            this.carregarNaturezas()
            this.entidadeAtual = {
                id: null,
                natureza: {},
                orgao_pai: {}
            }
        },

        carregarOrgaos () {
            this.carregandoOrgaos = true
            this.orgaosRaiz = []
            this.$http
                .get(rotas.rotas().orgao.listar + "?per_page=-1")
                .then(
                    response => {
                        response.body.forEach(element => {
                            this.orgaosRaiz.push(element)
                        })
                        this.carregandoOrgaos = false
                    },
                    error => {
                        console.log(error)
                        this.carregandoOrgaos = false
                    }
                )
        },

        carregarNaturezas () {
            this.carregandoNaturezas = true
            this.naturezas = []
            this.$http
                .get(rotas.rotas().orgao.listarNaturezas)
                .then(
                    response => {
                        response.body.forEach(element => {
                            this.naturezas.push(element)
                        })
                        this.carregandoNaturezas = false
                    },
                    error => {
                        console.log(error)
                        this.carregandoNaturezas = false
                    }
                )
        },
    },
    mounted() {
    }
}
</script>

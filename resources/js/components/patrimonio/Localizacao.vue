<template>
    <crud v-if="urlBase" ref="crud"
        nomeEntidade="Local" nomeEntidadePlural="Locais"
        :headers="cabecalhos" 
        :resource-url="urlBase"
        itemKey="id"
        :podeSalvar="podeSalvar"
        :exibirPrimeiraTela="exibindoGrid"
        :verboAdicionarEntidade="novoBem"
        :verboAlterarEntidade="editaBem"
        @clicou-item="selecionarParaEdicao" 
        @clicou-salvar="salvar"
        @clicou-cancelar="cancelar"
        @clicou-novo="novo">
        <template slot="detalhe">
            <div v-if="entidadeAtual">
                <!-- Patrimonio -->   
                <v-card style="width: 70%; margin-bottom: 1em; margin: auto;">
                    <v-autocomplete v-if ="!entidadeAtual.sigla" label="Divisão"  
                        :items="bensDivisao" v-model="entidadeAtual.idDivisao" 
                        item-text="descricao" item-value="id"  />
                    <v-text-field v-if ="entidadeAtual.sigla"
                        label="Divisão"  
                        v-model="entidadeAtual.sigla" 
                        readonly />
                    <v-text-field 
                        label="Descrição"
                        style="width: 90%;"
                        v-model="entidadeAtual.descricao"
                        :rules="[validacao.obrigatorio]"
                        required
                    />
                </v-card>
            </div>
        </template>
    </crud>
</template>

<script>
import rotas from './../../rotas-servico.js'
import CRUD from './../ApiCrud'
import Validador from './../../validacao'

export default {
    components: {
        'crud' : CRUD
    },
    data: () => {
        return {
            cabecalhos: [
                { 
                    text: 'id__',
                    type: 'hidden',
                    value: 'id'
                },
                { 
                    text: 'Divisão',
                    value: 'sigla'
                },
                { 
                    text: 'Local',
                    value: 'descricao'
                }
            ],
            novoBem:'Cadastrar',
            editaBem:'Editar',
            podeSalvar:true,
            exibindoGrid: true,
            entidadeAtual: null,
            bensDivisao:null,
            validacao: Validador,
            key_text: false,
            urlBase: rotas.rotas().patrimonio.divisao
        }
    },

    methods: {
        selecionarParaEdicao(item) {
            this.entidadeAtual = item;
        },
        cancelar() {
            this.$refs.crud.loadItems()
        },
        novo(item) {
            this.entidadeAtual = {
                id: null,
                idDivisao:null,
                descricao:null,
            }
        },
        salvar() {
            let formData = new FormData()
            formData.append('idDivisaoOrganograma', this.entidadeAtual.idDivisao)
            formData.append('descricao', this.entidadeAtual.descricao)

            if(this.entidadeAtual.id != null) {
                formData.append('_method', 'PUT') 
            }
            let url = this.entidadeAtual.id === null ? 
                rotas.rotas().patrimonio.criarLocal : 
                rotas.rotas().patrimonio.editarLocal +''+ this.entidadeAtual.id;

            this.$http.post(url, formData)
                .then(
                    response => {
                        console.log(response)
                        this.$store.commit('sistema/mensagem', 'Local cadastrado com sucesso!')
                        this.$refs.crud.loadItems()
                    },
                    error => {
                        console.log(error.body)
                        this.$store.commit('sistema/alerta', error.body.message)
                    }
                );
        },
        carregarTabelas () {
            this.$http
                .get(rotas.rotas().patrimonio.tabelas)
                .then(
                    response => {
                        //console.log(response.body.divisao)
                        this.bensDivisao = response.body.divisao;
                    },
                    error => {
                        console.log(error)
                    }
                )
        },
    },
    mounted() {
        this.carregarTabelas()
    }
}
</script>

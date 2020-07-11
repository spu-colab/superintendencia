<template>
    <crud v-if="urlBase" ref="crud"
        nomeEntidade="Geo Camada" nomeEntidadePlural="Geo Camadas"
        :headers="cabecalhos" 
        :resource-url="urlBase"
        itemKey="id"
        @clicou-item="selecionarParaEdicao" 
        @clicou-salvar="salvar"
        @clicou-cancelar="cancelar"
        @clicou-novo="novo"
        :for-each-item-callback="this.paraCadaItemDoResultado">
        <template slot="detalhe">
            <div v-if="entidadeAtual">
                <v-container fluid>
                    <v-row>
                        <v-col xs12 md6>
                            <v-text-field label="Título" v-model="entidadeAtual.titulo" 
                                :rules="[validacao.obrigatorio, validacao.tamanhoMinimo(entidadeAtual.titulo, 8)]" required 
                                counter="100" maxlength="100"/>
                        </v-col>
                        <v-col xs12 md6>
                            <v-text-field label="Rótulo" v-model="entidadeAtual.rotulo" 
                                :rules="[validacao.obrigatorio, validacao.tamanhoMinimo(entidadeAtual.rotulo, 3)]" required 
                                counter="150" maxlength="150"/>
                        </v-col>
                    </v-row>
                    <v-row>
                        <v-col>
                            <v-checkbox label="Ativa?" v-model="entidadeAtual.ativa"></v-checkbox>
                        </v-col>
                        <v-col>
                            <v-checkbox label="Dados Estáticos?" v-model="entidadeAtual.estatica"></v-checkbox>
                        </v-col>
                    </v-row>

                    <template v-if="entidadeAtual.estatica">
                        <v-row>
                            <v-col xs12 md6>
                                <v-text-field label="Propiedade Título" v-model="entidadeAtual.propriedadeTitulo" counter="100" maxlength="100"/>
                            </v-col>
                            <v-col xs12 md6>
                                <v-text-field label="Propriedade SubTítulo" v-model="entidadeAtual.propriedadeSubTitulo" counter="100" maxlength="100"/>
                            </v-col>
                        </v-row>
                        <v-row>
                            <v-col xs12>
                                <vue-json-editor v-model="entidadeAtual.geojson" :show-btns="false" :exapndedOnStart="true" style="width: 100%; height: 100%;">
                                </vue-json-editor>
                                <!--
                                <editor :conteudo="JSON.stringify(entidadeAtual.geojson)"/>
                                -->
                            </v-col>
                        </v-row>
                    </template>
                    <template v-else>
                        <v-row>
                            <v-col xs12 md6>
                                <v-text-field label="Tabela Referência" v-model="entidadeAtual.tabelaReferencia" counter="100" maxlength="100"/>
                            </v-col>
                            <v-col xs12 md6>
                                <v-text-field label="Coluna Id da Referência" v-model="entidadeAtual.colunaIdReferencia" counter="100" maxlength="100"/>
                            </v-col>
                        </v-row>
                        <v-row>
                            <v-col xs12 md6>
                                <v-text-field label="Coluna Título da Referência" v-model="entidadeAtual.colunaTituloReferencia" counter="100" maxlength="100"/>
                            </v-col>
                            <v-col xs12 md6>
                                <v-text-field label="Coluna Subtítulo da Referência" v-model="entidadeAtual.colunaSubTituloReferencia" counter="100" maxlength="100"/>
                            </v-col>
                        </v-row>
                        <v-row>
                            <v-col xs12 md6>
                                <v-text-field label="Cor" v-model="entidadeAtual.cor" counter="100" maxlength="100"/>
                            </v-col>
                            <v-col xs12 md6>
                                <v-text-field label="Rota Front-end" v-model="entidadeAtual.rotaFrontEnd" counter="100" maxlength="100"/>
                            </v-col>
                        </v-row>
                    </template>
                    

                </v-container>
                
            </div>
        </template>
    </crud>
</template>

<script>
import rotas from './../../../../../resources/js/rotas-servico'
import CRUD from './../../../../../resources/js/components/ApiCrud'
import Validador from './../../../../../resources/js/validacao'
import vueJsonEditor from 'vue-json-editor'
// import Editor from './../../../../../resources/js/components/Editor'

export default {
    components: {
        "crud": CRUD,
        "vue-json-editor": vueJsonEditor
    },

    data() {
        return {
            urlBase: rotas.rotas().geo.camada.listar,
            validacao: Validador,

            cabecalhos: [
                { 
                    text: 'Título',
                    value: 'titulo'
                },
                { 
                    text: 'Ativa',
                    value: 'txtAtiva'
                },
                { 
                    text: 'Estática',
                    value: 'txtEstatica'
                }
            ],

            entidadeAtual: null,

        }
    },

    methods: {
        selecionarParaEdicao(item) {
            if(item.id) {
                let url = rotas.rotas().geo.camada.obter + item.id
                this.$http.get(url).then(
                        response => {
                            // console.log(response)
                            this.entidadeAtual = response.body
                        },
                        error => {
                            console.log(error.body)
                            this.$store.commit('sistema/alerta', error.body.message)
                        });
            } else {
                this.entidadeAtual = item
            }
            // console.log("GeoCamada.selecionarParaEdicao", this.entidadeAtual)
        },

        salvar() {
            let url =rotas.rotas().geo.camada.criar;
            let formData = new FormData()
            if(this.entidadeAtual.id != null) {
                url = rotas.rotas().geo.camada.editar + '' + this.entidadeAtual.id;
                formData.append('_method', 'PUT') 
                formData.append('id', this.entidadeAtual.id)
            }
            formData.append('titulo', this.entidadeAtual.titulo)
            formData.append('rotulo', this.entidadeAtual.rotulo)

            formData.append('ativa', this.entidadeAtual.ativa ? 1 : 0)
            formData.append('estatica', this.entidadeAtual.estatica ? 1 : 0)
            if(this.entidadeAtual.estatica) {
                if(this.entidadeAtual.geojson != null) {
                    formData.append('geojson', JSON.stringify(this.entidadeAtual.geojson))
                }
            } else {
                if(this.entidadeAtual.tabelaReferencia != null) {
                    formData.append('tabelaReferencia', this.entidadeAtual.tabelaReferencia)
                }
                if(this.entidadeAtual.colunaIdReferencia != null) {
                    formData.append('colunaIdReferencia', this.entidadeAtual.colunaIdReferencia)
                }
                if(this.entidadeAtual.colunaTituloReferencia != null) {
                    formData.append('colunaTituloReferencia', this.entidadeAtual.colunaTituloReferencia)
                }
                if(this.entidadeAtual.colunaSubTituloReferencia != null) {
                    formData.append('colunaSubTituloReferencia', this.entidadeAtual.colunaSubTituloReferencia)
                }
                if(this.entidadeAtual.rotaFrontEnd != null) {
                    formData.append('rotaFrontEnd', this.entidadeAtual.rotaFrontEnd)
                }
            }

            if(this.entidadeAtual.cor != null) {
                formData.append('cor', this.entidadeAtual.cor)
            }
            

            this.$http.post(url, formData)
                .then(
                    response => {
                        this.$store.commit('sistema/mensagem', 'Geo Camada salva com sucesso!')
                        this.$refs.crud.loadItems()
                    },
                    error => {
                        console.log(error.body)
                        this.$store.commit('sistema/alerta', error.body.message)
                    }
                )

        },

        cancelar() {
        },

        novo() {
            this.entidadeAtual = {
            }
        },

        paraCadaItemDoResultado(item) {
            /*
            console.log("GeoCamada.paraCadaItemDoResultado", item.geojson)
            item.geojson = item.geojson
            console.log(item.geojson)
            */
           item.txtAtiva = item.ativa ? 'Ativada' : 'Desativada'
           item.txtEstatica = item.estatica ? 'Estática' : 'Dinâmica'
            return item
        }

    },

}
</script>
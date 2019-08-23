<template>
    <crud 
        nomeEntidade="Procedimento Externo" nomeEntidadePlural="Procedimentos Externos"
        :headers="cabecalhos" :items="registros" :carregando="carregando"
        @clicou-item="selecionarParaEdicao" 
        @clicou-salvar="salvar"
        @clicou-cancelar="cancelar"
        @clicou-novo="novo">
        <template slot="detalhe">
            <v-card>
                <v-card-text>
                    <v-tabs v-model="tabAtiva" color="grey lighten-5" @change="mudouDeTab">
                        <v-tab>Cadastro</v-tab>
                        <v-tab>Demandas</v-tab>
                        <v-tab>Georreferenciamento</v-tab>

                        <v-tabs-slider color="primary"></v-tabs-slider>

                        <!-- TAB CADASTRO -->
                        <v-tab-item>
                            <v-container>
                                <div v-if="entidadeAtual">
                                    <v-layout row wrap>
                                        <v-flex xs12 lg4>
                                            <v-autocomplete label="Tipo"
                                            :items="tiposProcedimento" v-model="entidadeAtual.idTipoProcedimentoExterno" 
                                            :rules="[validacao.obrigatorio]" required
                                            item-text="tipoprocedimento" item-value="id"  />
                                        </v-flex>
                                        <v-flex xs12 lg4>
                                            <v-text-field label="Procedimento" v-model="entidadeAtual.procedimento" 
                                                :rules="[validacao.obrigatorio, validacao.min8]" required 
                                                counter="150"  maxlength="150"/>
                                        </v-flex>
                                        <v-flex xs12 lg4>
                                            <v-text-field label="Chave de Acesso" v-model="entidadeAtual.chave" 
                                                counter="50"  maxlength="50"/>
                                        </v-flex>
                                    </v-layout>
                                    <v-layout row wrap>
                                        <v-flex xs12 lg8>
                                            <v-text-field label="Resumo" v-model="entidadeAtual.resumo" 
                                                counter="150"  maxlength="150"/>
                                        </v-flex>
                                        <v-flex xs12 lg4>
                                            <v-autocomplete label="Polo"
                                                :items="polosProcedimento" v-model="entidadeAtual.idPoloProcedimentoExterno" 
                                                :rules="[validacao.obrigatorio]" required
                                                item-text="polo" item-value="id"  />
                                        </v-flex>
                                    </v-layout>
                                    <v-layout row wrap>
                                        <v-flex xs12 lg12>
                                            <v-textarea  
                                                label="Descrição"
                                                v-model="entidadeAtual.descricao">
                                            </v-textarea>
                                        </v-flex>
                                    </v-layout>
                                </div>
                            </v-container>
                        </v-tab-item>
                        <!-- Fim da TAB CADASTRO -->

                        <!-- TAB DEMANDAS -->
                        <v-tab-item>
                            <v-container>
                                <v-data-table
                                    :headers="cabecalhosDemandas"
                                    :items="demandas"
                                    item-key="id" 
                                    v-if="demandas"
                                    >
                                    <template slot="items" slot-scope="props">
                                        <tr @click='$router.push("/demanda/" + props.item.id )' style="cursor:pointer;">
                                            <td>{{ (new Date(props.item.created_at)).toLocaleDateString() }}</td>
                                            <td>
                                                {{ props.item.documentoExterno }}
                                                <div class="caption grey--text">
                                                    {{ props.item.autor.nome }}
                                                </div>
                                                <div class="caption grey--text">
                                                    {{ props.item.autor.cargo.cargo }} - {{ props.item.autor.orgao.sigla}}
                                                </div>
                                            </td>
                                            <td>{{ props.item.nupSEI }}</td>
                                            <td>{{ (new Date(props.item.dataPrazo)).toLocaleDateString() }}</td>
                                            <td>{{ props.item.situacao.situacao }}</td>
                                        </tr>
                                    </template>
                                </v-data-table>
                            </v-container>
                        </v-tab-item>
                        <!-- Fim de TAB DEMANDAS -->

                        <!-- TAB GEORREFERENCIAMENTO -->
                        <v-tab-item>
                            <v-container>
                                <geo-referenciamento v-if="entidadeAtual"
                                    :idCamada="idCamada" 
                                    :idReferenciado="entidadeAtual.id" 
                                    :atualizarMapa="atualizarMapa"></geo-referenciamento>
                            </v-container>
                        </v-tab-item>
                        <!-- Fim da TAB GEORREFERENCIAMENTO -->


                    </v-tabs>
                </v-card-text>
            </v-card>
        </template>
    </crud>
</template>

<script>
import rotas from './../rotas-servico.js'
import CRUD from './CRUD'
import GeoReferenciamento from './GeoReferenciamento'
const PROCEDIMENTO_TAB_DEMANDAS = 1;
const PROCEDIMENTO_TAB_GEORREFERENCIAMENTO = 2;
const ID_GEO_CAMADA_PROCEDIMENTO_EXTERNO = 1;
export default {
    components: {
        'crud' : CRUD
    },
    data: () => {
        return {
            idCamada: ID_GEO_CAMADA_PROCEDIMENTO_EXTERNO,
            atualizarMapa: false,
            tabAtiva: 0,
            carregando: true,
            cabecalhos: [
                { 
                    text: 'Tipo',
                    value: 'tipoProcedimentoExterno'
                },
                { 
                    text: 'Procedimento',
                    value: 'procedimento'
                },
                { 
                    text: 'Resumo',
                    value: 'resumo'
                }
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

            tiposProcedimento: [],
            carregandoTiposProcedimento: false,

            polosProcedimento: [],
            carregandoPolosProcedimento: false,

            // demandas
            demandas: null,
            cabecalhosDemandas: [
                { 
                    text: 'Data',
                    value: 'created_at'
                },
                { 
                    text: 'Documento',
                    value: 'documentoExterno'
                },
                { 
                    text: 'SEI',
                    value: 'nupSEI'
                },
                { 
                    text: 'Prazo',
                    value: 'dataPrazo'
                },
                { 
                    text: 'Situação',
                    value: 'situacao'
                },
            ],
        }
    },
    methods: {
        selecionarParaEdicao(item) {
            this.carregarTabelasApoio()
            this.entidadeAtual = item
            console.log('Item selecionado: ' + item.id)
        },
        salvar() {
            let formData = new FormData()
            formData.append('procedimentoExterno[id]', this.entidadeAtual.id)
            formData.append('procedimentoExterno[idTipoProcedimentoExterno]', this.entidadeAtual.idTipoProcedimentoExterno)
            formData.append('procedimentoExterno[idPoloProcedimentoExterno]', this.entidadeAtual.idPoloProcedimentoExterno)
            formData.append('procedimentoExterno[procedimento]', this.entidadeAtual.procedimento)
            formData.append('procedimentoExterno[chave]', this.entidadeAtual.chave)
            formData.append('procedimentoExterno[resumo]', this.entidadeAtual.resumo)
            formData.append('procedimentoExterno[descricao]', this.entidadeAtual.descricao)
            if(this.entidadeAtual.id != null) {
                formData.append('_method', 'PUT') 
            }

            let url = this.entidadeAtual.id === null ? 
                rotas.rotas().procedimentoExterno.criar : 
                rotas.rotas().procedimentoExterno.editar + '' + this.entidadeAtual.id;

            this.$http.post(url, formData)
                .then(
                    response => {
                        console.log(response)
                        this.$store.commit('sistema/mensagem', 'Procedimento Externo cadastrado com sucesso!')
                        this.$router.push('/procedimento')
                    },
                    error => {
                        console.log(error.body)
                        this.$store.commit('sistema/alerta', error.body.message)
                    }
                )
                // this.carregarItens()
        },
        cancelar() {
            this.carregarItens()
        },
        novo(item) {
            this.carregarTabelasApoio()
            this.entidadeAtual = {
                id: null
            }
        },
        carregarItens() {
            this.carregando = true;
            this.registros = [];
            this.$http.get(rotas.rotas().procedimentoExterno.listar)
                .then(
                    response => {
                        // console.log(response);
                        response.body.forEach(element => {
                            // console.log(element)
                            element.tipoProcedimentoExterno = element.tipo_procedimento_externo.tipoprocedimento
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
        carregarTiposProcedimento () {
            this.carregandoTiposProcedimento = true
            this.tiposProcedimento = []
            this.$http
                .get(rotas.rotas().tipoProcedimentoExterno.listar)
                .then(
                    response => {
                        response.body.forEach(element => {
                            this.tiposProcedimento.push(element)
                        })
                        this.carregandoTiposProcedimento = false
                    },
                    error => {
                        console.log(error)
                        this.carregandoTiposProcedimento = false
                    }
                )
        },
        carregarPolosProcedimento () {
            this.carregandoPolosProcedimento = true
            this.polosProcedimento = []
            this.$http
                .get(rotas.rotas().poloProcedimentoExterno.listar)
                .then(
                    response => {
                        response.body.forEach(element => {
                            this.polosProcedimento.push(element)
                        })
                        this.carregandoPolosProcedimento = false
                    },
                    error => {
                        console.log(error)
                        this.carregandoPolosProcedimento = false
                    }
                )
        },
        carregarDemandas() {
            this.demandas = [];
            let url = rotas.rotas().demanda.listarPorProcedimentoExterno + this.entidadeAtual.id
            this.$http.get(url)
                .then(
                    response => {
                        console.log(response);
                        response.body.forEach(element => {
                            // console.log(element)
                            this.demandas.push(element)
                        })
                    },
                    error => {
                        console.log(error)
                    }
                )
            
        },
        isTabDemandas () {
            return this.tabAtiva == PROCEDIMENTO_TAB_DEMANDAS
        },

        isTabGeorreferenciamento () {
            return this.tabAtiva == PROCEDIMENTO_TAB_GEORREFERENCIAMENTO
        },

        mudouDeTab() {
            this.atualizarMapa = false;
            if(this.isTabDemandas()) {
                this.carregarDemandas()
            }
            if(this.isTabGeorreferenciamento()) {
                this.atualizarMapa = true;
            }
        },

        carregarTabelasApoio() {
            this.carregarTiposProcedimento()
            this.carregarPolosProcedimento()
        }
    },
    mounted() {
        this.carregarItens()
    }
}
</script>

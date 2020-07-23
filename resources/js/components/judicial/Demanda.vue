<template>
    <crud v-if="urlBase" ref="crud"
        nomeEntidade="Demanda" nomeEntidadePlural="Demandas"
        :headers="cabecalhos" 
        :resource-url="computedUrlBase"
        itemKey="id"

        :podeSalvar="podeSalvar" :imprimir="true"
        :voltar-para-primeira-tela-ao-salvar="false" 
        :for-each-item-callback="forEachItemCallBack"
        @clicou-item="selecionarParaEdicao" 
        @clicou-salvar="salvar"
        @clicou-cancelar="cancelar"
        @clicou-novo="novo" 
        @clicou-imprimir="imprimir">
        
        <template slot="beforeAdd">
            <v-tooltip bottom>
                <template v-slot:activator="{ on }">
                    <v-btn v-on="on" rounded 
                        :color="switchSomenteAbertas ? 'green' : 'grey'" 
                        @click="toggleDemandasAbertas">
                        <v-icon>play_arrow</v-icon>
                    </v-btn>
                </template>
                Somente demandas abertas
            </v-tooltip>
            <v-tooltip bottom>
                <template v-slot:activator="{ on }">
                    <v-btn v-on="on" rounded 
                        :color="switchSomenteAtrasadas ? 'red' : 'grey'" 
                        @click="toggleDemandasAtrasadas">
                        <v-icon>access_alarm</v-icon>
                    </v-btn>
                </template>
                Somente demandas atrasadas
            </v-tooltip>
            <v-tooltip bottom>
                <template v-slot:activator="{ on }">
                    <v-btn v-on="on" rounded 
                        :color="switchSomenteSentencas ? 'red' : 'grey'" 
                        @click="toggleDemandasSentencas">
                        <v-icon>gavel</v-icon>
                    </v-btn>
                </template>
                Somente demandas referentes a sentenças judiciais
            </v-tooltip>
        </template>

        <template slot="detalhe">
            <div v-if="entidadeAtual">
                <v-container>
                    <v-layout row wrap>
                        <!-- Demandante -->
                        <v-flex xs6>
                            <v-autocomplete label="Demandante" v-model="entidadeAtual.autor" 
                                :items="computedAutores" :loading="carregandoAutores" 
                                :search-input.sync="termoBuscaAutores" color="white"
                                hide-no-data hide-selected
                                item-text="nome" item-value="id"
                                placeholder="Nome do autor da demanda"
                                prepend-icon="record_voice_over"
                                return-object tabindex="1"
                                :rules="[validacao.obrigatorio]">
                                <template slot="item" slot-scope="data" required>
                                    <template v-if="typeof data.item !== 'object'">
                                        <v-list-item-content v-text="data.item"></v-list-item-content>
                                    </template>
                                    <template v-else>
                                        <v-list-item-content>
                                            <v-list-item-title v-html="data.item.nome"></v-list-item-title>
                                            <v-list-item-subtitle v-html="(data.item.cargo ? (data.item.cargo.cargo + ' - ') : '') + (data.item.orgao ? data.item.orgao.sigla : '')"></v-list-item-subtitle>
                                        </v-list-item-content>
                                    </template>
                                </template>
                            </v-autocomplete>
                        </v-flex>
                        <!-- Procedimento Externo -->
                        <v-flex xs6>
                            <v-autocomplete label="Procedimento Externo" v-model="entidadeAtual.procedimento_externo"
                                :items="computedProcedimentos" :loading="carregandoProcedimentos"
                                :search-input.sync="termoBuscaProcedimentos" color="white"
                                hide-no-data hide-selected
                                item-text="procedimento" item-value="id"
                                placeholder="Número/identificador do procedimento externo"
                                prepend-icon="account_balance"
                                return-object tabindex="2" 
                                :rules="[validacao.obrigatorio]">
                                <template slot="item" slot-scope="data" required>
                                    <template v-if="typeof data.item !== 'object'">
                                        <v-list-item-content v-text="data.item"></v-list-item-content>
                                    </template>
                                    <template v-else>
                                        <v-list-item-content>
                                            <v-list-item-title v-html="data.item.procedimento"></v-list-item-title>
                                            <v-list-item-subtitle v-if="data.item.tipo_procedimento_externo" v-html="data.item.tipo_procedimento_externo.tipoprocedimento"></v-list-item-subtitle>
                                        </v-list-item-content>
                                    </template>
                                </template>
                            </v-autocomplete>
                        </v-flex>
                        
                    </v-layout>

                    <v-layout row wrap>
                        <!-- Tipo Documento -->
                        <v-flex xs2>
                            <v-autocomplete label="Tipo Documento" tabindex="3" 
                                :items="tiposDocumento" v-model="entidadeAtual.idTipoDocumento" 
                                item-text="tipodocumento" item-value="id" 
                                :rules="[validacao.obrigatorio]"/>
                        </v-flex>

                        <!-- Documento  -->
                        <v-flex xs2>
                            <v-text-field label="Documento" tabindex="4" 
                                v-model="entidadeAtual.documentoExterno" placeholder="0123/2018"
                                :rules="[validacao.obrigatorio]" required 
                                ></v-text-field>
                            
                        </v-flex>

                        <!-- Data Documento -->
                        <v-flex xs2>
                            <v-menu ref="menuDataDocumento"
                                :close-on-content-click="false"
                                v-model="menuDataDocumento"
                                :nudge-right="40"
                                transition="scale-transition"
                                offset-y
                                max-width="290px"
                                min-width="290px">

                                <template v-slot:activator="{ on }">
                                    <v-text-field  tabindex="5" 
                                        mask="##/##/####" return-masked-value
                                        v-on="on"
                                        v-model="dataDocumentoFormatada"
                                        label="Data Documento"
                                        hint="DD/MM/AAAA"
                                        persistent-hint
                                        prepend-icon="event" 
                                        :rules="[validacao.obrigatorio, validacao.data]" required 
                                        @blur="dataDocumento = parseDate(dataDocumentoFormatada)"
                                        />
                                </template>

                                <v-date-picker v-model="dataDocumento" no-title @input="menuDataDocumento = false" locale="pt-br" />
                            </v-menu>
                        </v-flex>

                        <!-- Órgão -->
                        <v-flex xs2>
                            <v-layout align-center>
                            <v-text-field label="Órgão"
                                v-model="computedOrgaoSelecionado" disabled></v-text-field>
                            </v-layout>
                        </v-flex>

                        <!-- NUP Sei -->
                        <v-flex xs3>
                            <v-text-field label="NUP SEI" tabindex="5" 
                                v-model="entidadeAtual.nupSEI" 
                                :rules="[validacao.obrigatorio, validacao.tamanhoMinimo(entidadeAtual.nupSEI, 15)]" required 
                                counter="20" maxlength="20"/>
                        </v-flex>

                        <v-flex xs1>
                            <v-switch tabindex="8"  v-model="entidadeAtual.seiMP" label="MP"></v-switch>
                        </v-flex>

                    </v-layout>

                    <v-layout row wrap>
                        
                        <!-- Prazo -->
                        <v-flex xs2>
                            <v-menu ref="menuDataPrazo"
                                :close-on-content-click="false"
                                v-model="menuDataPrazo"
                                :nudge-right="40"
                                transition="scale-transition"
                                offset-y
                                max-width="290px"
                                min-width="290px">

                                <template v-slot:activator="{ on }">
                                    <v-text-field  tabindex="7" 
                                        mask="##/##/####" return-masked-value
                                        :rules="[validacao.data]" 
                                        v-on="on" 
                                        v-model="dataPrazoFormatada"
                                        label="Prazo"
                                        hint="DD/MM/AAAA"
                                        persistent-hint
                                        prepend-icon="event"
                                        @blur="dataPrazo = parseDate(dataPrazoFormatada)"
                                        />
                                </template>

                                <v-date-picker v-model="dataPrazo" no-title @input="menuDataPrazo = false" locale="pt-br" />
                            </v-menu>
                        </v-flex>
                        <!-- Cumprimento de sentença? -->
                        <v-flex xs4>
                            <v-switch tabindex="8"  v-model="entidadeAtual.sentencajudicial" label="Trata-se de cumprimento de sentença?" color="red"></v-switch>
                        </v-flex>

                        <v-spacer/>

                        <!-- Situação -->
                        <v-flex xs3>
                            <v-select tabindex="6" label="Situacao" disabled
                                v-model="entidadeAtual.idSituacaoDemanda" :items="situacoes" 
                                item-text="situacao" item-value="id" 
                            />                            
                        </v-flex>
                        <v-spacer/>

                        <!-- Botões de situação -->
                        <v-flex xs2>
                            <v-layout row wrap>                            
                                <v-flex xs6>
                                    <v-tooltip bottom>
                                        <template v-slot:activator="{ on }">
                                            <v-btn :disabled="!podeCancelar" @click="cancelarDemanda" v-on="on">
                                                <v-icon color="error">delete</v-icon>
                                            </v-btn>
                                        </template>
                                        Cancelar Demanda
                                    </v-tooltip>
                                </v-flex>
                                <v-flex xs6 v-if="podeAguardarAssinatura">
                                    <v-tooltip bottom>
                                        <template v-slot:activator="{ on }">
                                            <v-btn @click="aguardarAssinatura" v-on="on">
                                                <v-icon color="black">assignment_late</v-icon>
                                            </v-btn>
                                        </template>
                                        Marcar como Aguardando Assinatura
                                    </v-tooltip>
                                </v-flex>
                                <v-flex xs6  v-if="podeAguardarAR">
                                    <v-tooltip bottom>
                                        <template v-slot:activator="{ on }">
                                            <v-btn @click="aguardarAR" v-on="on">
                                                <v-icon color="purple">beenhere</v-icon>
                                            </v-btn>
                                        </template>
                                        Marcar como Aguardando AR
                                    </v-tooltip>
                                </v-flex>
                                <v-flex xs6 v-if="podeResolver">
                                    <v-tooltip bottom>
                                        <template v-slot:activator="{ on }">
                                            <v-btn @click="resolverDemanda" v-on="on">
                                                <v-icon color="success">done</v-icon>
                                            </v-btn>
                                        </template>
                                        Marcar como Resolvida
                                    </v-tooltip>
                                </v-flex>
                            </v-layout>
                            
                        </v-flex>                        
                        
                    </v-layout>

                    <v-layout row wrap>
                        <!-- Demanda -->
                        <v-textarea tabindex="10" 
                            name="input-7-4"
                            label="O demandante nos solicita..."
                            placeholder="informar sobre a situação das inscrições de ocupação..."
                            v-model="entidadeAtual.demanda"
                            :rules="[validacao.obrigatorio, validacao.tamanhoMinimo(entidadeAtual.demanda, 8)]" required>
                        </v-textarea>
                    </v-layout>

                    <v-layout row wrap>
                        <!-- Resumo / Situação -->
                        <v-textarea tabindex="11" 
                            name="input-7-4"
                            label="Situação (Resumo Gerencial):"
                            placeholder="Anotação sobre o resumo da situação da demanda para fins gerenciais"
                            v-model="entidadeAtual.resumoSituacao">
                        </v-textarea>
                    </v-layout>

                    <v-layout row wrap>
                        <v-dialog v-model="exibirDialogoDistribuicao" persistent max-width="600px">
                            <v-card>
                                <v-card-title>
                                    <span class="headline">Atribuir Demanda</span>
                                </v-card-title>
                                <v-card-text>
                                    <v-layout wrap>
                                        <!-- Atribuir Para -->
                                        <v-flex xs12>
                                            <v-autocomplete
                                                v-model="distribuicao.atribuirPara" 
                                                :items="entidadesAtribuiveis"   
                                                item-value="id" item-text="text"
                                                label="Colaborador">
                                            </v-autocomplete>
                                        </v-flex>
                                        <v-flex xs12>
                                            <v-textarea label="Comentário Distribuição"
                                                v-model="distribuicao.comentarioDistribuicao">
                                            </v-textarea>
                                        </v-flex>
                                    </v-layout>
                                </v-card-text>
                                <v-card-actions>
                                    <v-spacer></v-spacer>
                                    <v-btn color="warning" @click="exibirDialogoDistribuicao = false">Cancelar</v-btn>
                                    <v-btn color="primary" @click="salvarDistribuicao">Salvar</v-btn>
                                </v-card-actions>
                            </v-card>
                        </v-dialog> 
                        <v-flex xs12>
                            <v-card>
                                <v-card-title color="yellow lighten-3">
                                    <v-toolbar-title>Distribuições da Demanda</v-toolbar-title>
                                        <v-divider class="mx-2" inset vertical></v-divider>
                                        <v-spacer/>
                                        <v-btn @click="clicouNovaDistribuicao"
                                            color="primary" right :disabled="!podeDistribuir">
                                            Atribuir Demanda
                                        </v-btn>
                                </v-card-title>
                                <v-card-text>
                                    <v-data-table
                                        :headers="cabecalhoDistribuicao"
                                        :items="entidadeAtual.distribuicoes"
                                        item-key="id" 
                                        v-if="podeDistribuir"
                                        >
                                        <template v-slot:item="props">
                                            <tr v-on:click="expandirLinhaDistribuicao(props)" style="cursor:pointer;">
                                                <td>{{ (props.item.dataDistribuicao != null) ?
                                                    new Date(props.item.dataDistribuicao).toLocaleString() : '' }}</td>
                                                <td>{{ props.item.colaborador_de.name }}</td>
                                                <td>{{ props.item.assignable ? 
                                                    (props.item.assignable.name ? props.item.assignable.name : props.item.assignable.sigla)
                                                    : '' }}</td>
                                                <td>{{ props.item.situacao }}</td>
                                                <td>{{ (props.item.dataAtendimento != null) ?
                                                    new Date(props.item.dataAtendimento).toLocaleString() : '' }}</td>
                                            </tr>
                                        </template>
                                        <template v-slot:expanded-item="{ item }">
                                            <td colspan="5">
                                                <v-card flat>
                                                    <v-card-text>
                                                        <v-layout row wrap>
                                                            <!-- Comentário Distribuição 
                                                            -->
                                                            <v-textarea label="Comentário Distribuição"
                                                                v-model="item.comentarioDistribuicao">
                                                            </v-textarea>
                                                            <!-- Comentário Atendimento -->
                                                            <v-textarea label="Comentário Atendimento"
                                                                v-model="item.comentarioAtendimento">
                                                            </v-textarea>

                                                        </v-layout>  
                                                    </v-card-text>
                                                    <v-card-actions>
                                                        <v-btn color="primary lighten-1" @click="salvarDistribuicao(false)" :disabled="!podeSalvarDistribuicao">
                                                            Alterar Comentário</v-btn>
                                                        <v-btn color="success lighten-1" @click="salvarDistribuicao(true)" :disabled="!podeSalvarDistribuicao">
                                                            Marcar Como Atendida</v-btn>
                                                    </v-card-actions>
                                                </v-card>
                                            </td>
                                        </template>
                                    </v-data-table>
                                </v-card-text>
                            </v-card>
                        </v-flex>
                        
                    </v-layout>     

                </v-container>                                       
            </div>
        </template>
    </crud>
</template>

<script>
import rotas from './../../rotas-servico.js'
import CRUD from './../ApiCrud'
import Validador from './../../validacao';
import Utils from './../../Utils'
// import { setTimeout } from 'timers';
export default {
    components: {
        'crud' : CRUD
    },
    data: (vm) => {
        return {
            switchSomenteAbertas: true,
            switchSomenteAtrasadas: false,
            switchSomenteSentencas: false,

            urlBase: rotas.rotas().demanda.listar + '?abertas=1',
            
            cabecalhos: [
                {
                    text: 'Demanda',
                    value: 'nupSEI',
                    sortable: true,
                    align: 'left',
                    subheader: 'documentoExterno',
                    icon: 'iconeSituacao',
                    color: 'corIconeSituacao',
                    iconTooltip: 'situacao'
                },
                {
                    text: 'Procedimento Externo', 
                    valueProperty: 'procedimentoExterno',
                    value: 'procedimentoExterno',
                    sortable: true,
                    subheader: 'tipoProcedimentoExterno',
                    subheader2: 'procedimentoExternoResumo',
                    icon: 'iconeSentenca',
                    color: 'corIconeSentenca',
                    iconTooltip: 'iconTooltip'
                },
                {
                    text: 'Demandante', 
                    value: 'demandante',
                    sortable: true,
                    subheader: 'orgao'
                },
                {
                    text: 'Distribuída para', 
                    value: 'distribuidaParaChips',
                    type: 'chip',
                    sortable: false
                },
                {
                    text: 'Resumo/Situação', 
                    value: 'resumoSituacao',
                    sortable: false,
                },
                {
                    text: 'Prazo', 
                    value: 'dataPrazo',
                    type: 'date',
                    icon: 'iconeAtrazo',
                    color: 'red',
                    iconTooltip: 'iconTooltip',
                    sortable: true
                },
                // colunas escondidas para tornar possível a busca por seus valores
                {
                    text: 'Situacao', 
                    value: 'situacao',
                    // para esconder a coluna, use as duas propriedades abaixo
                    align: ' d-none', type : 'hidden',
                },
                {
                    text: 'Documento', 
                    value: 'documentoExterno',
                    sortable: false,
                    width: '0px',
                    // para esconder a coluna, use as duas propriedades abaixo
                    align: ' d-none', type : 'hidden',
                },
                {
                    text: 'Órgão', 
                    value: 'orgao',
                    sortable: false,
                    width: '0px',
                    // para esconder a coluna, use as duas propriedades abaixo
                    align: ' d-none', type : 'hidden',
                },
                {
                    text: 'Distribuída para (pesquisa)', 
                    value: 'distribuidaParaValores',
                    sortable: false,
                    width: '0px',
                    // para esconder a coluna, use as duas propriedades abaixo
                    align: ' d-none', type : 'hidden',
                },
                {
                    text: 'Tipo Procedimento Externo', 
                    value: 'tipoProcedimentoExterno',
                    sortable: false,
                    width: '0px',
                    // para esconder a coluna, use as duas propriedades abaixo
                    align: ' d-none', type : 'hidden',
                },
                {
                    text: 'Procedimento Externo Resumo', 
                    value: 'procedimentoExternoResumo',
                    sortable: false,
                    width: '0px',
                    class: 'hidden',
                    // para esconder a coluna, use as duas propriedades abaixo
                    align: ' d-none', type : 'hidden',
                },
            ],
            
            entidadeAtual: {
                dataPrazo: new Date().toISOString().substr(0, 10),
                dataDocumento: new Date().toISOString().substr(0, 10),
                autor: {
                    orgao: {
                    }
                }
            },

            validacao: Validador,

            demandantes: [],
            carregandoAutores: false,
            termoBuscaAutores: null,

            tiposDocumento: [],
            situacoes: [],
            
            menuDataPrazo: false,
            dataPrazo: new Date().toISOString().substr(0, 10),
            dataPrazoFormatada: vm.formatDate(new Date().toISOString().substr(0, 10)),

            menuDataDocumento: false,
            dataDocumento: new Date().toISOString().substr(0, 10),
            dataDocumentoFormatada: vm.formatDate(new Date().toISOString().substr(0, 10)),

            divisoesOrganogramas: [],

            procedimentos: [],
            carregandoProcedimentos: false,
            termoBuscaProcedimentos: null,

            cabecalhoDistribuicao: [
                {
                    text: 'Data',
                    value: 'dataDistribuicao',
                },
                {
                    text: 'De',
                    value: 'colaborador_de'
                },
                {
                    text: 'Para',
                    value: 'assignable'
                },
                {
                    text: 'Situação',
                    value: 'situacao'
                },
                {
                    text: 'Data',
                    value: 'dataAtendimento',
                },
            ],
            expandirDistribuicao: false,
            exibirDialogoDistribuicao: false,
            entidadesAtribuiveis: [],
            distribuicao: {
                id: null,
                atribuirPara: null,
                comentarioDistribuicao: null,
                comentarioAtendimento: null
            }

        }
    },
    methods: {
        consoleLog(obj) {
            console.log(obj)
            return obj
        },
        

        selecionarParaEdicao(item) {           
            // console.log('Item selecionado: ' + item.id)
            if(!item.id) {
                this.dataPrazo = new Date().toISOString().substr(0, 10),
                this.dataDocumento = new Date().toISOString().substr(0, 10),
                this.entidadeAtual = {
                    autor: {
                        orgao: {
                        }
                    }
                }
            } else {
                this.$http
                    .get(rotas.rotas().demanda.consultar + item.id)
                    .then(
                        response => {
                            // console.log('consultando demanda :' + item.id)
                            // console.log(response)
                            this.carregarElementosTela()
                            response.body.forEach(element => {
                                // console.log(element)
                                this.entidadeAtual = element
                                this.dataDocumento = element.dataDocumento
                                this.dataPrazo = element.dataPrazo
                                this.prepararDistribuicoes(element)
                                // console.log('this.entidadeAtual', this.entidadeAtual)
                            })
                        },
                        error => {
                            console.log(error)
                        }
                    )
            }

        },
        
        salvar () {
            let formData = new FormData()
            formData.append('demanda[id]', this.entidadeAtual.id)
            formData.append('demanda[idTipoDocumento]', this.entidadeAtual.idTipoDocumento)
            formData.append('demanda[documentoExterno]', this.entidadeAtual.documentoExterno)
            
            formData.append('demanda[idAutorDemanda]', this.entidadeAtual.autor ? 
                this.entidadeAtual.autor.id : null)
            formData.append('demanda[idProcedimentoExterno]', this.entidadeAtual.procedimento_externo ?
                this.entidadeAtual.procedimento_externo.id : null)
            
            formData.append('demanda[idSituacaoDemanda]', this.entidadeAtual.idSituacaoDemanda)
            formData.append('demanda[demanda]', this.entidadeAtual.demanda)
            
            formData.append('demanda[resumoSituacao]', this.entidadeAtual.resumoSituacao ? this.entidadeAtual.resumoSituacao : '')

            if(this.entidadeAtual.dataDocumento) {
                formData.append('demanda[dataDocumento]', this.entidadeAtual.dataDocumento)     
            }
            formData.append('demanda[nupSEI]', this.entidadeAtual.nupSEI)
            formData.append('demanda[seiMP]', this.entidadeAtual.seiMP ? 1 : 0)
            
            formData.append('demanda[atribuidaPara]', this.entidadeAtual.atribuidaPara)
            if(this.entidadeAtual.dataPrazo) {
                formData.append('demanda[dataPrazo]', this.entidadeAtual.dataPrazo)     
            }
            formData.append('demanda[sentencajudicial]', this.entidadeAtual.sentencajudicial ? 1 : 0)     
            if(this.entidadeAtual.id != null) {
                formData.append('_method', 'PUT')      
            }

            let url = this.entidadeAtual.id == null ?
                rotas.rotas().demanda.criar : 
                rotas.rotas().demanda.editar + '' + this.entidadeAtual.id;

            this.$http.post(url, formData)
                .then(
                    response => {
                        // console.log(response)
                        this.$store.commit('sistema/mensagem', 'Demanda cadastrada com sucesso!')
                        this.selecionarParaEdicao(response.body)
                    },
                    error => {
                        // console.log(error.body)
                        this.$store.commit('sistema/alerta', error.body.message)
                    }
                )
        },

        cancelar() {
            // this.carregarItens();
        },

        salvarDistribuicao (marcarComoAtendida = false) {
            let formData = new FormData()
            if(this.distribuicao.id != null) {
                // formData.append('_method', 'PUT') <- não estou usando Laravel Resource no serviço para essa entidade
                formData.append('distribuicao[id]', this.distribuicao.id)
            }
            formData.append('distribuicao[idDemanda]', this.entidadeAtual.id)
            formData.append('distribuicao[idUsuarioDe]', this.usuario.id)
            if(this.distribuicao.atribuirPara) {
                console.log(this.distribuicao.atribuirPara)
                let splitAtribuirPara = this.distribuicao.atribuirPara.split(":")
                formData.append('distribuicao[assignable_id]', splitAtribuirPara[0])
                let prefixoEntidateAtribuivel = "App\\"
                if(splitAtribuirPara[1].endsWith('DivisaoOrganograma')) {
                    prefixoEntidateAtribuivel = "\\"
                }
                formData.append('distribuicao[assignable_type]', prefixoEntidateAtribuivel + splitAtribuirPara[1])
            }
            formData.append('distribuicao[comentarioDistribuicao]', this.distribuicao.comentarioDistribuicao ? this.distribuicao.comentarioDistribuicao : '')
            formData.append('distribuicao[comentarioAtendimento]', this.distribuicao.comentarioAtendimento ? this.distribuicao.comentarioAtendimento : '')

            if(marcarComoAtendida) {
                formData.append('marcarComoAtendida', true)
            }

            let url = this.distribuicao.id == null ?
                rotas.rotas().demanda.distribuicao : 
                rotas.rotas().demanda.distribuicao + '/' + this.distribuicao.id;

            this.$http.post(url, formData)
                .then(
                    response => {
                        // console.log(response)
                        this.$store.commit('sistema/mensagem', this.distribuicao.id == null ? 'Distribuição da demanda cadastrada com sucesso!' : 'Distribuição da demanda atualizada com sucesso!')
                        this.selecionarParaEdicao(this.entidadeAtual)
                    },
                    error => {
                        console.log(error.body)
                        this.$store.commit('sistema/alerta', error.body.error)
                    }
                )
           this.exibirDialogoDistribuicao = false
        },
        cancelarDemanda() {
            let formData = new FormData()
            formData.append('demanda[id]', this.entidadeAtual.id)
            let url = rotas.rotas().demanda.cancelar;
            this.$http.post(url, formData)
            .then(
                response => {
                    console.log(response)
                    this.$store.commit('sistema/mensagem', 'Demanda cancelada com sucesso!')
                    // this.$router.push('/demanda')
                    this.selecionarParaEdicao(this.entidadeAtual)
                },
                error => {
                    console.log(error.body)
                    this.$store.commit('sistema/alerta', error.body.message)
                }
            )
        },
        
        novo(item) {
            this.carregarElementosTela()
            this.dataDocumento = null
            this.dataPrazo = null
            this.entidadeAtual = {
                id: null
            }
        },
        obterDadosPaginacao(rBody) {
            var {
                current_page, 
                first_page_url, 
                from, 
                last_page, 
                last_page_url,
                next_page_url,
                per_page,
                prev_page_url,
                to,
                total
            } = rBody;
            this.paginacao = {
                current_page, 
                first_page_url, 
                from, 
                last_page, 
                last_page_url,
                next_page_url,
                per_page,
                prev_page_url,
                to,
                total
            }
        },

        forEachItemCallBack(element) {
            element.orgao = element.autor.orgao.sigla
            this.prepararDistribuicoes(element)
            
            element.situacao = element.situacao.situacao
            switch (element.situacao) {
                case 'Nova':
                    element.iconeSituacao = 'new_releases'
                    element.corIconeSituacao = 'blue'
                    break;
                case 'Em análise':
                    element.iconeSituacao = 'hourglass_empty'
                    element.corIconeSituacao = 'orange'
                    break;
                case 'Pronta':
                    element.iconeSituacao = 'hourglass_full'
                    element.corIconeSituacao = 'green'
                    break;
                case 'Aguardando assinatura':
                    element.iconeSituacao = 'assignment_late'
                    element.corIconeSituacao = 'black'
                    break;
                case 'Aguardando AR':
                    element.iconeSituacao = 'beenhere'
                    element.corIconeSituacao = 'purple'
                    break;                        
                case 'Resolvida':
                    element.iconeSituacao = 'done'
                    element.corIconeSituacao = 'grey'
                    break;
                case 'Cancelada':
                    element.iconeSituacao = 'delete'
                    element.corIconeSituacao = 'grey'
                    break;
                default:
                    break;
            }

            if(element.procedimento_externo) {
                element.procedimentoExterno = element.procedimento_externo.procedimento
                if(element.procedimento_externo.tipo_procedimento_externo) {
                    element.tipoProcedimentoExterno = element.procedimento_externo.tipo_procedimento_externo.tipoprocedimento
                    if(element.procedimento_externo.resumo && element.procedimento_externo.resumo != 'null') {
                        element.procedimentoExternoResumo = element.procedimento_externo.resumo
                    }
                }
            }

            if(element.sentencajudicial) {
                element.iconeSentenca = 'gavel'
                element.corIconeSentenca = 'red'
                element.iconTooltip = 'Cumprimento de sentença'

            }
            if(element.dataPrazo) {
                if(element.situacao != 'Cancelada' && element.situacao != 'Resolvida') {
                    let prazo = new Date(element.dataPrazo)
                    if(prazo < new Date()) {
                        element.iconeAtrazo = 'access_alarm'
                        element.iconTooltip = 'Resposta atrasada'
                    }
                }
            }
            return element
        },
        
        carregarAutoresDemanda () {
            this.demandantes = []
            this.$http.get(rotas.rotas().autorDemanda.listar)
                .then(res => {
                    // console.log(res)
                    res.body.forEach((autor) => {
                        // console.log(autor)
                        this.demandantes.push(autor)
                    })
                    this.carregandoAutores = false
                },
                    err => {
                        console.log(err)
                        this.carregandoAutores = false
                    }
                )
        },

        carregarProcedimentosExternos() {
            this.procedimentos = []
            this.$http.get(rotas.rotas().procedimentoExterno.listar)
                .then(response => {
                    response.body.forEach(element => {
                        this.procedimentos.push(element)
                    })
                    this.carregandoProcedimentos = false
                },
                    error => {
                        console.log(error)
                        this.carregandoProcedimentos = false
                    }
                )
        },

        carregarTiposDocumento () {
            this.carregando = true
            this.tiposDocumento = []
            this.$http
                .get(rotas.rotas().tipoDocumento.listar)
                .then(
                    response => {
                        response.body.forEach(element => {
                        this.tiposDocumento.push(element)
                        })
                    },
                    error => {
                        console.log(error)
                    }
                )
            this.carregando = false
        },

        carregarSituacoes () {
            this.carregando = true
            this.situacoes = []
            this.$http
                .get(rotas.rotas().situacaoDemanda.listar)
                .then(
                    response => {
                        response.body.forEach(element => {
                        this.situacoes.push(element)
                        })
                    },
                    error => {
                        console.log(error)
                    }
                )
            this.carregando = false
        },

        carregarEntidadesAtribuiveis () {
            this.entidadesAtribuiveis = []
            this.$http.get(rotas.rotas().demanda.entidadeAtribuivel)
                .then(
                    response => {
                        response.body.forEach(element => {
                        this.entidadesAtribuiveis.push(element)
                        })
                    },
                    error => {
                        console.log(error)
                    })
        },

        formatDate (date) {
            if (!date) return null
            // console.log(date)

            const [year, month, day] = date.split('-')
            return `${day}/${month}/${year}`
        },

        parseDate (date) {
            return Utils.parseDate(date)
        },

        expandirLinhaDistribuicao(props) {
            // console.log("expandirLinhaDistribuicao()")
            // console.log(props)
            props.expand(!props.isExpanded)
            this.distribuicao = props.item            
        },

        clicouNovaDistribuicao() {
            this.exibirDialogoDistribuicao = true
            this.distribuicao = {
                id: null,
                atribuirPara: null,
                comentarioDistribuicao: null,
                comentarioAtendimento: null
            }
        },

        prepararDistribuicoes(element) {
            element.distribuidaParaValores = []                        
            element.distribuidaParaChips = []
            element.distribuicoes.forEach(distribuicao => {
                distribuicao.situacao = 'Atendida'
                if(distribuicao.dataAtendimento == null) {
                    distribuicao.situacao = 'Aguardando atendimento'
                    if(distribuicao.assignable) {
                        element.distribuidaParaValores.push(distribuicao.assignable.name ? distribuicao.assignable.name : distribuicao.assignable.sigla)
                        element.distribuidaParaChips.push({
                            id: distribuicao.id,
                            value: distribuicao.assignable.name ? distribuicao.assignable.name : distribuicao.assignable.sigla
                        })
                    }
                }
            })
        },

        resolverDemanda() {
            let formData = new FormData()
            formData.append('demanda[id]', this.entidadeAtual.id)
            let url = rotas.rotas().demanda.resolver;
            this.$http.post(url, formData)
            .then(
                response => {
                    console.log(response)
                    this.$store.commit('sistema/mensagem', 'Demanda resolvida com sucesso!')
                    this.selecionarParaEdicao(this.entidadeAtual)
                },
                error => {
                    console.log(error.body)
                    this.$store.commit('sistema/alerta', error.body.message)
                }
            )
        },

        aguardarAssinatura() {
            let formData = new FormData()
            formData.append('demanda[id]', this.entidadeAtual.id)
            let url = rotas.rotas().demanda.aguardarAssinatura;
            this.$http.post(url, formData)
            .then(
                response => {
                    console.log(response)
                    this.$store.commit('sistema/mensagem', 'Demanda aguardando assinatura do Superintendente')
                    this.selecionarParaEdicao(this.entidadeAtual)
                },
                error => {
                    console.log(error.body)
                    this.$store.commit('sistema/alerta', error.body.message)
                }
            )
        },

        aguardarAR() {
            let formData = new FormData()
            formData.append('demanda[id]', this.entidadeAtual.id)
            let url = rotas.rotas().demanda.aguardarAR;
            this.$http.post(url, formData)
            .then(
                response => {
                    console.log(response)
                    this.$store.commit('sistema/mensagem', 'Demanda aguardando aviso/confirmação de recebimento')
                    this.selecionarParaEdicao(this.entidadeAtual)
                },
                error => {
                    console.log(error.body)
                    this.$store.commit('sistema/alerta', error.body.message)
                }
            )
        },

        carregarElementosTela() {
            this.carregarAutoresDemanda()
            this.carregarProcedimentosExternos()
            this.carregarTiposDocumento()
            this.carregarSituacoes()
            this.carregarEntidadesAtribuiveis()
        },

        imprimir(selecionados) {
            // console.log(__filename + "imprimir()", selecionados)
            let ids = []
            selecionados.forEach(element => {
                ids.push(element.id)
            });
            if(ids.length == 0) {
                this.$store.commit('sistema/mensagem', 'Nenhum registro selecionado para impressão')
                return
            }

            // let formData = new FormData()
            // formData.append('demandaIds', ids)

            let url = rotas.rotas().demanda.pdf + ids;

            this.$http.get(url, { responseType: 'arraybuffer' })
            .then(
                response => {
                    console.log(response.data)
                    let blob = new Blob([response.data], {
                        type: response.headers.get('content-type'),
                    })
                    const data = window.URL.createObjectURL(blob)
                    window.open(data,'_blank');
                },
                error => {
                    console.log(error.body)
                    this.$store.commit('sistema/alerta', error.body.message)
                }
            )
        },

        atualizarUrlBase() {
            let url = rotas.rotas().demanda.listar
            url += '?abertas=' + (this.switchSomenteAbertas ? '1' : '0')
            url += '&atrasadas=' + (this.switchSomenteAtrasadas ? '1' : '0')
            url += '&sentencas=' + (this.switchSomenteSentencas ? '1' : '0')

            this.urlBase = url
        },
        toggleDemandasAbertas() {
            this.switchSomenteAbertas = !this.switchSomenteAbertas
            this.atualizarUrlBase()
        },
        toggleDemandasAtrasadas() {
            this.switchSomenteAtrasadas = !this.switchSomenteAtrasadas
            if(this.switchSomenteAtrasadas) {
                this.switchSomenteAbertas = true
            }
            this.atualizarUrlBase()
            
        },
        toggleDemandasSentencas() {
            this.switchSomenteSentencas = !this.switchSomenteSentencas
            this.atualizarUrlBase()
        }
    },
    computed: {
        computedOrgaoSelecionado() {
        return this.entidadeAtual.autor ? "/" + this.entidadeAtual.autor.orgao.sigla : null
        },
        computedAutores() {
            return this.demandantes
        },

        computedProcedimentos () {
            return this.procedimentos
        },
        usuario () {
            return this.$store.getters['auth/usuario'];
        },

        podeSalvar() {
            if(this.entidadeAtual.id) {
                return this.entidadeAtual.situacao.situacao != 'Resolvida' 
                    && this.entidadeAtual.situacao.situacao != 'Cancelada'
            }
            return true
        },

        podeCancelar() {
            return this.entidadeAtual.id && this.podeSalvar
        },

        podeAguardarAssinatura() {
            return this.podeSalvar && 
                this.entidadeAtual.situacao &&
                this.entidadeAtual.situacao.situacao == 'Pronta'
        },

        podeAguardarAR() {
            return this.podeSalvar && 
                this.entidadeAtual.situacao &&
                this.entidadeAtual.situacao.situacao == 'Aguardando assinatura'
        },

        podeResolver() {
            return this.podeSalvar && 
                this.entidadeAtual.situacao &&
                this.entidadeAtual.situacao.situacao === 'Aguardando AR'
        },       
        
        podeDistribuir() {
            if(!this.podeSalvar) {
                return false;
            }
            return this.entidadeAtual.id != null;
        },
        podeSalvarDistribuicao() {
            if(!this.podeSalvar) {
                return false;
            }
            return this.distribuicao.situacao != 'Atendida'
        },
        computedUrlBase() {
            this.atualizarUrlBase()
            return this.urlBase
        }
    },
    watch: {
        termoBuscaAutores (val) {
            // Items have already been loaded
            if (this.computedAutores.length > 0) return
            // Items have already been requested
            if (this.carregandoAutores) return

            this.carregarAutoresDemanda()
        },
        termoBuscaProcedimentos (val) {
            // Items have already been loaded
            if (this.computedProcedimentos.length > 0) return

            // Items have already been requested
            if (this.carregandoProcedimentos) return

            this.carregarProcedimentosExternos()
        },
        dataDocumento(val) {
            this.dataDocumentoFormatada = this.formatDate(this.dataDocumento)
            this.entidadeAtual.dataDocumento = this.dataDocumento
        },
        dataPrazo(val) {
            this.dataPrazoFormatada = this.formatDate(this.dataPrazo)
            this.entidadeAtual.dataPrazo = this.dataPrazo
        }
    },
    mounted() {
        this.atualizarUrlBase()
        if(this.$route.params.id) {
            this.selecionarParaEdicao({ id: this.$route.params.id})

        }

    }
}
</script>


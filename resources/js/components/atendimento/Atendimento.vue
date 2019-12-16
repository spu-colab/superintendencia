<template>
    <v-container fluid fill-height>
        <v-layout column>
            <v-flex xs12>
                <v-layout align-start justify-space-between row>
                        <crud 
                            nomeEntidade="Atendimento" nomeEntidadePlural="Atendimentos" verboAdicionarEntidade="Iniciar"
                            :headers="cabecalhos" :items="registros" :carregando="carregando"
                            @clicou-item="selecionarParaEdicao" 
                            @clicou-salvar="salvar"
                            @clicou-cancelar="cancelar"
                            @clicou-novo="novo"
                            :exibirPrimeiraTela="exibindoGrid"
                            @modou-tela="mudouTela"
                            @validou-formulario="validouFormulario">

                            <template slot="beforeAdd">
                                <!-- Data Documento -->
                                <v-flex xs12>
                                    <v-menu ref="menuDataAtendimentos"
                                        :close-on-content-click="false"
                                        v-model="menuDataAtendimentos"
                                        :nudge-right="40"
                                        lazy
                                        transition="scale-transition"
                                        offset-y
                                        full-width
                                        max-width="290px"
                                        min-width="290px">

                                        <v-text-field  tabindex="5" 
                                            mask="##/##/####" return-masked-value
                                            slot="activator"
                                            v-model="dataAtendimentosFormatada"
                                            label="Data"
                                            hint="DD/MM/AAAA"
                                            persistent-hint
                                            prepend-icon="event" 
                                            @blur="dataAtendimentos = parseDate(dataAtendimentosFormatada)"
                                            />
                                        <v-date-picker v-model="dataAtendimentos" no-title @input="menuDataAtendimentos = false" locale="pt-br" />
                                    </v-menu>
                                </v-flex>
                            </template>

                            <template slot="topFormArea">
                                <h3>{{ computedSituacaoDoAtendimento }}</h3>
                            </template>

                            <template slot="addButtonArea">
                                <div class="text-xs-center">
                                    <v-tooltip bottom>
                                        <template slot="activator">
                                            <v-btn color="primary darken-1" fab large light @click="novo(idTipoPresencial)">
                                                <v-icon>people_outline</v-icon>
                                            </v-btn>
                                        </template>
                                        Iniciar atendimento presencial
                                    </v-tooltip>
                                    <v-tooltip bottom>
                                        <template slot="activator">
                                            <v-btn color="primary" fab large @click="novo(idTipoTelefonico)">
                                                <v-icon>local_phone</v-icon>
                                            </v-btn>
                                        </template>
                                        Iniciar atendimento telefônico
                                    </v-tooltip>
                                    <v-tooltip bottom>
                                        <template slot="activator">
                                            <v-btn color="primary lighten-1" fab large dark @click="novo(idTipoEmail)">
                                                <v-icon>mail_outline</v-icon>
                                            </v-btn>
                                        </template>
                                        Iniciar atendimento de e-mail
                                    </v-tooltip>
                                </div>
                            </template>
                            
                            <template slot="detalhe">
                                <div v-if="entidadeAtual">                                    
                                    <v-container>
                                        <!-- Dados do Atendimento -->
                                        <v-layout row wrap>
                                            <v-flex xs12 md6>
                                                <v-text-field label="Atendente" v-model="computedNomeDoAtendente" disabled/>
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
                                        
                                        <!-- Dados do Atendido -->
                                        <v-layout row wrap>
                                            <v-flex xs12 md6>
                                                <v-text-field label="Atendido" v-model="entidadeAtual.atendido" 
                                                    :rules="[validacoes().obrigatorio, validacoes().min3]" required :disabled="atendimentoConcluido()" />
                                            </v-flex>
                                            <v-flex xs12 md3>
                                                <v-text-field label="CPF" v-model="entidadeAtual.cpf" :disabled="atendimentoConcluido()" />
                                            </v-flex>
                                            <v-flex xs12 md3>
                                                <v-text-field label="E-mail" v-model="entidadeAtual.email" 
                                                    :rules="[validacoes().email]" :disabled="atendimentoConcluido()" />
                                            </v-flex>
                                        </v-layout>

                                        <!-- Assuntos -->
                                        <v-layout wrap>
                                            <v-flex xs12>
                                                
                                                    <h4>Assuntos</h4>
                                                    <v-container>
                                                        <v-layout wrap>
                                                            <v-flex xs12 md4 lg3 align-start justify-start v-for="assunto in entidadeAtual.assuntos" v-bind:key="assunto.id">
                                                                <v-checkbox :label="assunto.assunto" align-start v-model="assunto.checked" :disabled="atendimentoConcluido()" ></v-checkbox>
                                                            </v-flex>
                                                        </v-layout>
                                                    </v-container>
                                            </v-flex>
                                        </v-layout>

                                        <!-- Comentários -->
                                        <v-layout row wrap>
                                            <v-flex xs12>
                                                <v-textarea box 
                                                    label="Comentário:"
                                                    placeholder="Registre aqui informações que julgar relevantes ao atendimento prestado."
                                                    v-model="novoComentario" 
                                                    :rules="[validarComentario]" :error-messages="comentarioValidoMsgs">
                                                </v-textarea>
                                            </v-flex>
                                        </v-layout>
                                        <v-layout row wrap justify-end>
                                            <v-btn color="primary lighten-2" @click="inserirComentario" :disabled="!comentarioValido">
                                                <v-icon>add</v-icon> Inserir Comentário
                                            </v-btn>
                                        </v-layout>
                                        <comentarios :comentarios="entidadeAtual.comentarios"></comentarios>
                                    </v-container>
                                </div>
                            </template>
                            
                            <template slot="beforeSaveButton">
                                <v-btn color="success" @click="concluir" :disabled="!valid || atendimentoConcluido()">
                                    <v-icon>check</v-icon> Concluir Atendimento</v-btn>
                            </template>
                        </crud>
                </v-layout>
            </v-flex>
        </v-layout>     
    </v-container>
</template>

<script>
import Crud from './../CRUD'
import Comentarios from './../Comentarios'
import rotas from './../../rotas-servico.js'
import Utils from './../../Utils'
import { isArray } from 'util';
export default {
    components: {
        'crud': Crud
    },
    data: (vm) => {
        return {
            cabecalhos: [
                {
                    text: 'Tipo',
                    value: 'tipoAtendimento',
                    type: 'filter',
                    valueProperty: 'tipoAtendimento'
                },
                { 
                    text: 'Atendente',
                    value: 'atendente',
                    type: 'filter',
                    valueProperty: 'atendente',
                },
                { 
                    text: 'Atendido',
                    value: 'atendido',
                    type: 'filter',
                    valueProperty: 'atendido',
                },
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
            ],
            registros: [],
            assuntos: [],
            carregando: false,
            entidadeAtual: null,
            idTipoPresencial: 1,
            idTipoTelefonico: 2,
            idTipoEmail: 3,
            menuDataAtendimentos: false,
            dataAtendimentos: vm.parseDate(new Date().toLocaleDateString()),
            dataAtendimentosFormatada: vm.formatDate(new Date().toISOString().substr(0, 10)),
            exibindoGrid: true,
            valid: true,
            comentarioValido: true,
            comentarioValidoMsgs: null,
            novoComentario: null,
            tempoAtendimento: null
        }
    },
    methods: {
        carregarItens() {
            this.serializarRequisicao()
            this.carregando = true;
            this.registros = [];
            let url = rotas.rotas().atendimento.listar + '/listar/' + this.dataAtendimentos
            this.$http.get(url)
                .then(
                    response => {
                        console.log(response.body);
                        response.body.forEach(element => {
                        // console.log(element)
                        this.formatarAtendimento(element)                     
                        // this.preencherAssuntos(element)
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
            this.entidadeAtual = item
            let url = rotas.rotas().atendimento.listar + '/' + item.id
            this.$http.get(url)
                .then(
                    response => {
                        console.log(response.body)
                        this.entidadeAtual = response.body
                        this.formatarAtendimento(this.entidadeAtual)                     
                        this.preencherAssuntos(this.entidadeAtual)
                        this.exibindoGrid = false
                    },
                    error => {
                        console.log(error.body)
                        this.$store.commit('sistema/alerta', error.body.message)
                    }
                )
        },
        
        novo(idTipoAtendimento) {
            let formData = new FormData()
            formData.append('idtipo', idTipoAtendimento)
            formData.append('atendido', 'Não informado')
            let url = rotas.rotas().atendimento.criar
            this.$http.post(url, formData)
                .then(
                    response => {
                        let atendimento = {}
                        atendimento.id = response.body.id
                        this.selecionarParaEdicao(atendimento)
                        this.$store.commit('sistema/mensagem', 'Atendimento iniciado!')
                    },
                    error => {
                        console.log(error.body)
                        this.$store.commit('sistema/alerta', error.body.message)
                    }
                )
        },

        salvar(concluir = false) {
            let formData = new FormData()
            formData.append('idtipo', this.entidadeAtual.tipo.id)
            formData.append('atendido', this.entidadeAtual.atendido)
            if(this.entidadeAtual.cpf != null) {
                formData.append('cpf', this.entidadeAtual.cpf)
            }
            if(this.entidadeAtual.email != null) {
                formData.append('email', this.entidadeAtual.email)
            }
            this.assuntos.forEach(assunto => {
                if(assunto.checked) {
                    formData.append('idsAssunto[]', assunto.id)
                }
            })
            formData.append('_method', 'PUT')

            let url = rotas.rotas().atendimento.editar
            if(concluir) {
                url += 'concluir/'
            }
            url += this.entidadeAtual.id
            this.$http.post(url, formData)
                .then(
                    response => {
                        console.log(response)
                        if(concluir) {
                            this.$store.commit('sistema/mensagem', 'Atendimento Concluído')
                        } else {
                            this.$store.commit('sistema/mensagem', 'Alterações salvas com sucesso!')
                        }
                        this.selecionarParaEdicao(this.entidadeAtual)
                    },
                    error => {
                        console.log(error.body)
                        this.$store.commit('sistema/alerta', error.body.message)
                    }
                )
        },

        concluir() {
            this.salvar(true);
        },

        cancelar() {
            this.carregarItens();
        },
        
        formatarAtendimento(element) {
            element.dataHoraInicio = Utils.obterDateCorretoServidor(element.dataHoraInicio)
            let dataHoraInicio = new Date(element.dataHoraInicio)
            element.data = dataHoraInicio.toLocaleDateString()
            element.inicio = dataHoraInicio.toLocaleTimeString()

            element.fim = '--'
            if(element.dataHoraFim) {
                element.dataHoraFim = Utils.obterDateCorretoServidor(element.dataHoraFim)
                let dataHoraFim = new Date(element.dataHoraFim)
                element.fim = dataHoraFim.toLocaleTimeString()
            }

            element.tipoAtendimento = '--'
            if(element.tipo && element.tipo.tipo) {
                element.tipoAtendimento = element.tipo.tipo
            }

            element.atendente = '--'
            if(element.usuario && element.usuario.name) {
                element.atendente = element.usuario.name
            }

            if(element.atendido != null) {
                // console.log(element.atendido)
                element.atendido = element.atendido.replace('Não informado', '')
            }
        },

        preencherAssuntos(atendimento) {
            // console.log('preencherAssuntos()...') 
            this.assuntos.forEach(assunto => {
                // console.log('assunto: ' + assunto.id + ' (' + assunto.assunto + ')')
                let assuntoJaAssociado = false
                atendimento.assuntos.forEach(assuntoAssociado => {
                    // console.log('assuntoAssociado: ' + assuntoAssociado.id + ' (' + assuntoAssociado.assunto + ')')
                    if(!assuntoJaAssociado && assunto.id == assuntoAssociado.id) {
                        assuntoAssociado.checked = true
                        assuntoJaAssociado = true
                    }
                })
                if(!assuntoJaAssociado) {
                    assunto.checked = false
                    atendimento.assuntos.push(assunto)
                }
            })
            atendimento.assuntos.sort(function (a, b) {
                return a.assunto.localeCompare(b.assunto)
            })         
        },

        inserirComentario() {
            let formData = new FormData()
            formData.append('idAtendimento', this.entidadeAtual.id)
            formData.append('comentario', this.novoComentario)

            let url = rotas.rotas().atendimento.comentario.criar
            this.$http.post(url, formData)
                .then(
                    response => {
                        console.log(response)
                        this.$store.commit('sistema/mensagem', 'Comentário registrado com sucesso!')
                        this.selecionarParaEdicao(this.entidadeAtual)
                        this.novoComentario = ''
                    },
                    error => {
                        console.log(error.body)
                        this.$store.commit('sistema/alerta', error.body.message)
                    }
                )
        },

        sleep(ms) {
            return new Promise(resolve => setTimeout(resolve, ms));
        },

        async serializarRequisicao() {
            while(this.carregando) {
                // console.log('esperando finalizar ultima requisição...')
                await this.sleep(200)
            }
        },

        carregarAssuntos() {
            this.assuntos = []
            let url = rotas.rotas().atendimento.assunto.listar;
            this.carregando = true
            // console.log('carregando assuntos...')
            this.$http.get(url)
                .then(
                    response => {
                        // console.log(response);
                        response.body.forEach(element => {
                            element.checked = false                        
                            this.assuntos.push(element)
                        })
                        this.carregando = false;
                        // console.log('terminei de carregar assuntos...')
                    },
                    error => {
                        console.log(error)
                        this.carregando = false;
                    }
                )
        },

        mudouTela(novoValor) {
            // console.log('Atendimento recebeu evento mudou-tela com val = ' + novoValor)
            this.exibindoGrid = novoValor
        },

        validouFormulario(val) {
            this.valid = val
        },

        validarComentario() {
            this.comentarioValidoMsgs = null
            this.comentarioValido = (this.novoComentario != null && this.novoComentario.length >= 5)
            if(!this.comentarioValido) {
                this.comentarioValidoMsgs = 'Comentário inválido'
            }
            return this.comentarioValido            
        },

        parseDate(dataFormatada) {
            return Utils.parseDate(dataFormatada)
        },

        formatDate(data) {
            return Utils.formatDate(data)
        },

        validacoes() {
            return Utils.validacao
        }, 

        atendimentoConcluido() {
            return this.entidadeAtual != null && this.entidadeAtual.dataHoraFim != null
        },

        atualizarTempoAtendimento() {
            let agora = new Date()
            let inicio = new Date(this.entidadeAtual.dataHoraInicio)
            this.tempoAtendimento = Utils.tempoDecorridoEntre(inicio, agora)
        }
    },
    watch: {
        dataAtendimentos(val) {
            this.dataAtendimentosFormatada = this.formatDate(this.dataAtendimentos)
            this.carregarItens()
        },
    },
    computed: {
        computedNomeDoAtendente() {
            if(this.entidadeAtual == null || this.entidadeAtual.usuario == null) {
                return ''
            }
            return this.entidadeAtual.usuario.name
        },

        computedSituacaoDoAtendimento() {
            if(this.entidadeAtual == null) {
                return ''
            }

            if(this.entidadeAtual.dataHoraFim != null) {
                return 'Atendimento encerrado'
            }

            return 'Em atendimento ' + this.tempoAtendimento
        },

    },
    mounted() {
        this.carregarAssuntos();
        this.carregarItens();
        setInterval(this.atualizarTempoAtendimento, 1000)
    }    
}
</script>
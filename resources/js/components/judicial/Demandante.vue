<template>
    <crud v-if="urlBase" ref="crud"
        nomeEntidade="Demandante" nomeEntidadePlural="Demandantes"
        :headers="cabecalhos" 
        :resource-url="urlBase"
        itemKey="id"
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
                        :items="cargos" v-model="entidadeAtual.idcargo" 
                        :rules="[validacao.obrigatorio]"
                        item-text="cargo" item-value="id"  />
                    </v-flex>

                    <!-- Órgão -->
                    <v-flex xs12 lg9>
                        <v-autocomplete label="Órgão"
                        :items="orgaos" v-model="entidadeAtual.idorgao" 
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
import rotas from './../../rotas-servico'
import ApiCrud from './../ApiCrud'
import Validador from './../../validacao';

export default {
    components: {
        'crud' : ApiCrud
    },
    data: () => {
        return {
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
            entidadeAtual: null,
            validacao: Validador,

            cargos: [],
            carregandoCargos: false,

            orgaos: [],
            carregandoOrgaos: false,

            urlBase: rotas.rotas().autorDemanda.listar,
        }
    },
    methods: {

        selecionarParaEdicao(item) {
            this.carregarTabelasApoio()
            this.entidadeAtual = item
            // console.log('Item selecionado: ' + item.id)
        },
        salvar() {
            console.log('salvar()')
            let url = rotas.rotas().autorDemanda.criar;
            let formData = new FormData()
            console.log(this.entidadeAtual)
            if(this.entidadeAtual.id) {
                formData.append('autordemanda[id]', this.entidadeAtual.id)
                formData.append('_method', 'PUT') 
                url = rotas.rotas().autorDemanda.editar + '' + this.entidadeAtual.id;
            }
            formData.append('autordemanda[nome]', this.entidadeAtual.nome)
            if(this.entidadeAtual.idcargo) {
                formData.append('autordemanda[idCargo]', this.entidadeAtual.idcargo)
            }
            if(this.entidadeAtual.idorgao) {
                formData.append('autordemanda[idOrgao]', this.entidadeAtual.idorgao)
            }
            formData.append('autordemanda[email]', this.entidadeAtual.email)
            if(this.entidadeAtual.telefone) {
                formData.append('autordemanda[telefone]', this.entidadeAtual.telefone)
            }
            
            this.$http.post(url, formData)
                .then(
                    response => {
                        this.$store.commit('sistema/mensagem', 'Demandante cadastrado com sucesso!')
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
        },
        
    },
    mounted() {
    }
}
</script>

<template>
    <crud v-if="urlBase" ref="crud"
        nomeEntidade="Patrimônio" nomeEntidadePlural="Bens Patrimoniais"
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
        <template slot="addButtonArea">
            <div class="text-xs-center">
                <v-btn color="blue-grey lighten-1" dark class="mb-2"
                    @click="relatorio()" >
                    <v-icon>picture_as_pdf</v-icon>
                    RELATÓRIOS
                </v-btn>
                <v-btn color="primary" dark class="mb-2" v-if ="podeCadastrar"
                    @click="novo()" >
                    <v-icon>add</v-icon>
                    CADASTRAR
                </v-btn>
            </div>
        </template>    
        <template slot="detalhe">
            <div v-if="exibirRelatorio" style="margin-bottom: 1em;" >
                <v-card style="width: 70%; margin-bottom: 1em; margin: auto;">
                <v-tabs v-model="tabAtiva"  background-color="blue-grey lighten-1" dark :centered="false">
                    <v-tab>Relatórios</v-tab>
                    <v-tab>Termos</v-tab>
                    <v-tab-item>
                        <v-container>
                            <v-autocomplete label="Divisão"  clearable
                                :items="bensDivisao" v-model="relatorioAtual.idDivisao" 
                                item-text="descricao" item-value="id"  />
                            <v-autocomplete label="Categoria"  clearable
                                :items="bensCategoria" v-model="relatorioAtual.idCategoria" 
                                item-text="descricao" item-value="id"  />
                            <v-autocomplete label="Situação" clearable
                                :items="bensSitRel" v-model="relatorioAtual.idSituacao" 
                                item-text="descricao" item-value="id"  />
                            <v-autocomplete label="Levantamento"  clearable
                                :items="bensLevantamento" v-model="relatorioAtual.idLevantamento" 
                                item-text="descricao" item-value="id"  />
                            <v-autocomplete label="Conservação"  clearable
                                :items="bensConservacao" v-model="relatorioAtual.idConservacao" 
                                item-text="descricao" item-value="id"  />
                            <span>Agrupar por:</span><br>
                            <input type="radio" class="radio-button" value="1" v-model="relatorioAtual.agrupamento">Local
                            <input type="radio" class="radio-button" value="2" v-model="relatorioAtual.agrupamento">Técnico
                            <input type="radio" class="radio-button" value="3" v-model="relatorioAtual.agrupamento">Geral
                            <br><br>
                            <div style="text-align: center;"  v-if="carregando">
                            <v-progress-circular 
                                indeterminate
                                color="primary"
                                >Aguarde...</v-progress-circular>
                            </div>
                            <div style="text-align: right;" v-if="!carregando">                                
                            <v-btn  color="blue-grey lighten-1" dark class="mb-2 text-right"
                                @click="gerarRelatorio()" >
                                <v-icon>picture_as_pdf</v-icon>
                                emitir RELATÓRIO
                            </v-btn>
                            </div>
                        </v-container>
                    </v-tab-item>
                    <v-tab-item>
                    <v-container>
                        <v-autocomplete label="Responsável" required
                            :items="bensResponsavel" v-model="relatorioAtual.idResponsavel"                             
                            item-text="name" item-value="id"  />
                        <br>
                        <div v-if="relatorioAtual.idResponsavel" style="text-align: right;">
                            <v-btn color="blue-grey lighten-1" dark class="mb-2"
                                @click="gerarTermo()" >
                                <v-icon>picture_as_pdf</v-icon>
                                emitir TERMO
                            </v-btn>
                        </div>
                    </v-container>
                    </v-tab-item>
                </v-tabs>
                </v-card>
            </div>
            <div v-if="entidadeAtual">
                <!-- Patrimonio -->   
                <v-layout style="width: 100%; margin: 0 auto">
                    <v-flex xs1>      
                        <v-text-field 
                            label="Código"
                            :readonly="entidadeAtual.id?true:false"
                            style="width: 90%;"
                            v-model="entidadeAtual.codigo"
                            :rules="[validacao.obrigatorio]"
                            required
                        />
                    </v-flex>    
                    <v-flex xs4>        
                        <v-autocomplete label="Categoria" style="width: 90%;"
                            :items="bensCategoria" v-model="entidadeAtual.idCategoria" 
                            :rules="[validacao.obrigatorio]" required 
                            item-text="descricao" item-value="id"  />
                    </v-flex>
                    <v-flex xs2>        
                        <v-text-field 
                            style="width: 95%;"
                            label="Preço"
                            :rules="[validacao.obrigatorio, validacao.maiorQue(entidadeAtual.preco, '0,00', 'Valor deve ser maior que zero')]" 
                            required
                            v-model.lazy="entidadeAtual.preco"   
                            v-money="money"              
                        />
                    </v-flex>
                    <v-flex xs2>        
                        <v-text-field 
                            style="width: 90%;"
                            type="date"
                            label="Garantia"
                            v-model="entidadeAtual.garantia"                
                        />
                    </v-flex>
                </v-layout>
                <v-textarea label="Descrição" v-model="entidadeAtual.descricao" style="width: 95%;"
                    :key="key_text" auto-grow rows=2
                    :rules="[validacao.obrigatorio, validacao.tamanhoMinimo(entidadeAtual.descricao, 8)]" 
                    required 
                    counter="500" maxlength="500"/>
                <v-layout style="width: 100%; margin: 0 auto">
                    <v-flex xs4>        
                        <v-autocomplete label="Localização" style="width: 90%;"
                            :items="bensSala" v-model="entidadeAtual.idSala" 
                            :rules="[validacao.obrigatorio]" required 
                            item-text="descricao" item-value="id"  />
                    </v-flex>
                    <v-flex xs2>        
                        <v-autocomplete label="Situação" style="width: 90%;"
                            :items="bensSituacao" v-model="entidadeAtual.idSituacao" 
                            :rules="[validacao.obrigatorio]" required 
                            item-text="descricao" item-value="id"  />
                    </v-flex>
                    <v-flex xs4>        
                        <v-autocomplete label="Responsável" style="width: 90%;" clearable
                            :disabled="entidadeAtual.idSituacao == 2 || entidadeAtual.idSituacao == 4"
                            :items="bensResponsavel" v-model="entidadeAtual.idResponsavel"                             
                            item-text="name" item-value="id"  />
                    </v-flex>
                </v-layout>
                <v-layout style="width: 100%; margin: 0 auto">
                    <v-flex xs2>        
                        <v-autocomplete label="Conservação" style="width: 90%;"
                            :items="bensConservacao" v-model="entidadeAtual.idConservacao" 
                            :rules="[validacao.obrigatorio]" required 
                            item-text="descricao" item-value="id"  />
                    </v-flex>
                    <v-flex xs2> 
                    </v-flex>
                    <v-flex xs2>        
                        <v-autocomplete label="Levantamento" style="width: 90%;"
                            :items="bensLevantamento" v-model="entidadeAtual.idLevantamento" 
                            :rules="[validacao.obrigatorio]" required 
                            item-text="descricao" item-value="id"  />
                    </v-flex>
                </v-layout>
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
                    text: 'Código',
                    value: 'codigo'
                },
                { 
                    text: 'Categoria',
                    value: 'categoria'
                },
                { 
                    text: 'Localização',
                    value: 'localizacao'
                },
                { 
                    text: 'Situação',
                    value: 'situacao'
                },
                { 
                    text: 'Responsável',
                    value: 'responsavel'
                }
            ],
            tabAtiva: 0,
            novoBem:'Cadastrar',
            editaBem:'Editar',
            podeSalvar:true,
            exibindoGrid: true,
            exibirRelatorio: false,
            exibirLocais: false,
            entidadeAtual: null,
            relatorioAtual:{
                idCategoria:null,
                idSituacao:null,
                idDivisao:null,
                idLevantamento:null,
                idConservacao:null,
                idResponsavel:null,
                agrupamento:1,
            },
            localAtual:{
                idDivisaoOrganograma:1,
                descricao:null,
            },
            carregando:false,
            bensSala:null,
            bensCategoria:null,
            bensSituacao:null,
            bensSitRel:null,
            podeCadastrar:false,
            bensLevantamento:null,
            bensConservacao:null,
            bensResponsavel:null,
            bensDivisao:null,
            validacao: Validador,
            key_text: false,
            money: {
                    decimal: ',',
                    thousands: '.',
                    precision: 2,
                    masked: false
                },
            urlBase: rotas.rotas().patrimonio.listar
        }
    },

    methods: {
        formatDate(date) {
            if (!date) return null;
            const [year, month, day] = date.split("-");
            return `${day}/${month}/${year}`;
        },
        selecionarParaEdicao(item) {
            this.podeSalvar=this.podeCadastrar;
            this.editaBem='Editar';
            this.entidadeAtual = item;
        },
        cancelar() {
            this.podeSalvar=this.podeCadastrar;
            this.novoBem = 'Cadastrar';
            this.editaBem= 'Editar';
            this.exibirRelatorio = false;
            this.exibirLocais = false;
            this.exibindoGrid = true;
            this.$refs.crud.loadItems()
        },
        relatorio(){
            this.podeSalvar=false;
            this.novoBem = '';
            this.editaBem='';
            this.entidadeAtual = null;
            this.exibirRelatorio = true;
            this.exibindoGrid = false;
        },        
        locais(){
            this.podeSalvar=false;
            this.novoBem = '';
            this.editaBem='';
            this.entidadeAtual = null;
            this.exibirLocais = true;
            this.exibindoGrid = false;
        },        
        novo(item) {
            this.podeSalvar=this.podeCadastrar;
            this.novoBem = 'Cadastrar';
            this.editaBem= 'Cadastrar';
            this.entidadeAtual = {
                id: null,
                idSituacao:4,
                idConservacao:1,
                idLevantamento:1,
            }
            this.exibindoGrid = false;
        },
        gerarRelatorio(){
            this.carregando = true;
            let formData = new FormData()
            let agrupamento = this.relatorioAtual.agrupamento ? this.relatorioAtual.agrupamento : null;
            formData.append('agrupamento', agrupamento);
            let idCategoria = this.relatorioAtual.idCategoria ? this.relatorioAtual.idCategoria : null;
            formData.append('idCategoria',idCategoria);
            let idConservacao = this.relatorioAtual.idConservacao ? this.relatorioAtual.idConservacao : null;
            formData.append('idConservacao',idConservacao);
            let idDivisao = this.relatorioAtual.idDivisao ? this.relatorioAtual.idDivisao : null;
            formData.append('idDivisao',idDivisao);
            let idLevantamento = this.relatorioAtual.idLevantamento ? this.relatorioAtual.idLevantamento : null;
            formData.append('idLevantamento',idLevantamento);
            let idSituacao = this.relatorioAtual.idSituacao ? this.relatorioAtual.idSituacao : null;
            formData.append('idSituacao', idSituacao);
            let url = rotas.rotas().patrimonio.gerarRelatorio;
            this.$http.post(url, formData, { responseType: 'arraybuffer' }).then(
                response => {
                    this.carregando = false;
                    let blob = new Blob([response.data], {
                        type: response.headers.get('content-type'),
                    })
                    const data = window.URL.createObjectURL(blob)
                    window.open(data,'_blank');
                },
                error => {
                    this.carregando = false;
                    console.log(error)
                    this.$store.commit('sistema/alerta', error.body.message)
                }
            );
            
        },
        gerarTermo(){
            let url = rotas.rotas().patrimonio.gerarTermo + this.relatorioAtual.idResponsavel;
            this.$http.get(url,  { responseType: 'arraybuffer' }).then(
                response => {
                    let blob = new Blob([response.data], {
                        type: response.headers.get('content-type'),
                    })
                    const data = window.URL.createObjectURL(blob)
                    window.open(data,'_blank');
                },
                error => {
                    console.log(error.body.message)
                    //this.$store.commit('sistema/alerta', error.body.message)
                }
            );
        },
        salvar() {
            let formData = new FormData()
            formData.append('patrimonio[descricao]', this.entidadeAtual.descricao)
            formData.append('patrimonio[codigo]', this.entidadeAtual.codigo)
            formData.append('patrimonio[preco]', this.entidadeAtual.preco)
            let garantia = this.entidadeAtual.garantia? this.entidadeAtual.garantia : "0";
            formData.append('patrimonio[garantia]', garantia)
            formData.append('patrimonio[idCategoria]', this.entidadeAtual.idCategoria)
            formData.append('patrimonio[idSituacao]', this.entidadeAtual.idSituacao)
            let resp =  this.entidadeAtual.idResponsavel ? this.entidadeAtual.idResponsavel : '0';
            formData.append('patrimonio[idUserResp]', this.entidadeAtual.idResponsavel)
            formData.append('patrimonio[idLevantamento]', this.entidadeAtual.idLevantamento)
            formData.append('patrimonio[idConservacao]', this.entidadeAtual.idConservacao)
            formData.append('patrimonio[idSala]', this.entidadeAtual.idSala)

            if(this.entidadeAtual.id != null) {
                formData.append('_method', 'PUT') 
            }

            let url = this.entidadeAtual.id === null ? 
                rotas.rotas().patrimonio.criar : 
                rotas.rotas().patrimonio.editar + '' + this.entidadeAtual.id;

            this.$http.post(url, formData)
                .then(
                    response => {
                    //                        console.log(response)
                        this.$store.commit('sistema/mensagem', 'Patrimônio cadastrado com sucesso!')
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
                        //console.log(response)
                        this.bensSala = response.body.sala;
                        this.bensCategoria = response.body.categoria;
                        this.bensSituacao = response.body.situacao;
                        this.bensLevantamento = response.body.levantamento;
                        this.bensConservacao = response.body.conservacao;
                        this.bensResponsavel = response.body.responsavel;
                        this.bensDivisao = response.body.divisao;
                        this.bensSitRel = response.body.sitRel;
                        this.podeCadastrar = response.body.podeCadastrar;
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

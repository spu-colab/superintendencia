<template>
  <crud
    nomeEntidade="Correspondência"
    nomeEntidadePlural="Correspondências"
    :verboAdicionarEntidade="verboAdicionar"
    :verboConsultarEntidade="verboConsultar"
    :setores="setores"
    :setorSelect="setorSelect"
    :anoPostagem="anoPostagem"
    :anoSelect="anoSelect"
    :tipoDocumento="tipoDocumento"
    :tipoSelect="tipoSelect"
    :descartar="true"
    :headers="cabecalhos"
    :items="registros"
    :carregando="carregando"   
    :imprimir="false"
    :textHeader="false"
    :paginas="paginas"
    :exibirPrimeiraTela="exibirGrid"
    :paginaCorrente="paginaCorrente"
    :exibirPaginacaoCliente="false"
    :podeSalvar="podeSalvar"
    @mudaPagina="mudaPagina" 
    @mudaAnoSetor="mudaAnoSetor"
    @descartarItem="descartarCorrespondencia"
    @clicou-postar="postar"
    @clicou-item="selecionarParaEdicao"
    @clicou-destinatario="cadastrarPostagem"
    @clicou-salvar="salvar"
    @clicou-cancelar="cancelar"
    @clicou-novo="novo"
    @mudou-tela="mudouTela"  
  >  
    <template slot="detalhe" >
      <div v-if="cadastrarNovo">
        <v-flex md12>
          <v-layout>
            <v-flex xs4>
              <v-text-field dense style="width: 100%; margin-left: 10 "
                label="Assunto"
                v-model="entidadeAtual.assunto"
                :rules="[validacao.obrigatorio, validacao.max60]"
                required
              />
            </v-flex>
            <v-spacer></v-spacer>
            <v-flex xs3>            
              <v-text-field dense style="width: 100%; paddin: 10 "
                label="Referência/Processo"
                v-model="entidadeAtual.referencia"
                :rules="[validacao.obrigatorio, validacao.max30]"
                required
              />
            </v-flex>
            <v-flex xs4>
              <v-spacer></v-spacer>              
            </v-flex>
          </v-layout>
        </v-flex>
        <v-flex md12 :class="'d-flex justify-start mb-6'">
          <v-layout>
            <v-flex xs4>
              <v-select
                :items="tipoDocumentoInclusao"
                v-model="entidadeAtual.tipo"
                :rules="[validacao.obrigatorio]"
                required
                label="Tipo"  
                hide-details              
              ></v-select>
            </v-flex>      
            <v-spacer></v-spacer>                  
            <v-flex xs2 >
              <v-select 
                :items="setoresInclusao"
                v-model="entidadeAtual.setor"
                label="Setor"                
                hide-details
              ></v-select>                         
            </v-flex>
            <v-flex xs5>
              <v-spacer></v-spacer>              
            </v-flex>
          </v-layout>
        </v-flex>
        <v-flex md12 :class="'d-flex justify-start mb-6'">
          <v-layout>
            <v-flex xs4>
              <v-text-field dense style="width: 100%; margin-left: 10 "
                label="Número do Documento SEI"                
                v-model="entidadeAtual.sequencia"
                :rules="[validacao.tipoAssociado([entidadeAtual.tipo, entidadeAtual.sequencia])]"
                :disabled='!entidadeAtual.tipo || entidadeAtual.tipo < 16'
              />              
            </v-flex>
            <v-spacer></v-spacer>
            <v-flex xs2>
              <v-select 
                :items="anoInclusao"
                v-model="entidadeAtual.ano"
                hint="Informe apenas para documentos expedidos pelo SEI"
                label="Ano do Documento SEI"                
                hide-details
              ></v-select>                                     
            </v-flex>
            <v-flex xs5>
              <v-spacer></v-spacer>              
            </v-flex>
          </v-layout>
        </v-flex>
      </div>    
      <div v-if="!cadastrarDestinatario & !cadastrarNovo & !receberApoio">
        <v-flex md12 >
        <div v-if="entidadeAtual.codigo" >
          <v-layout style="width: 100%; margin: 0 " align-end>
            <v-flex xs3>
              <h5>{{entidadeAtual.tipo}}</h5>
            </v-flex>
            <v-flex xs1>
              <h5 align="right">{{entidadeAtual.sequencia}}/{{entidadeAtual.ano}} -</h5>
            </v-flex>
            <v-flex xs2 style="margin-left: 4px ">              
              <h5> {{entidadeAtual.assunto}}</h5> 
            </v-flex>
            <v-flex>
              <h5>{{entidadeAtual.referencia}}</h5>
            </v-flex>
            <v-flex align=right>
                <v-tooltip bottom v-if="entidadeAtual.descartar" >
                  <template v-slot:activator="{ on }">
                    <v-btn v-on="on" color="red light" style="color:white" @click="descartarCorrespondencia(entidadeAtual.codigo)">
                      <v-icon small  color="white">delete</v-icon>descartar
                    </v-btn>
                  </template>
                  Remover Correspondência
                </v-tooltip>
                <v-tooltip bottom v-if="!entidadeAtual.descartar" >
                  <template slot="activator" slot-scope="{ on }">
                    <v-btn v-on="on" color="green" style="color:white" v-on:click="gerarEtiqueta(entidadeAtual.codigo)">
                    <v-icon small  color="white" >print</v-icon> Imprimir
                    </v-btn>
                  </template>
                  <span>Gerar Etiquetas</span>
                </v-tooltip>
                <v-tooltip bottom>
                  <template v-slot:activator="{ on }">
                    <v-btn v-on="on" color="primary" style="color:white" v-on:click="cadastrarDestinatario = true; podeSalvar = true">
                      <v-icon small  color="white">add</v-icon>Destinatário
                    </v-btn>
                  </template>
                  Novo Destinatário
                </v-tooltip>
            </v-flex>
          </v-layout>
          <br>
          <v-card v-for="item in entidadeAtual.postagens" :key="item.codigo">
            <tr style="width: 100%;">
              <td style="padding: 30px; width: 400px;">
                <h5>Destinatário</h5>
                <span>{{ item.destinatario.nome}}</span>
                <span v-if="item.destinatario.orgao"><br>{{ item.destinatario.orgao }}</span>  
                <span v-if="item.destinatario.setor"><br>{{ item.destinatario.setor }}</span> 

                <span v-if="item.destinatario.endereco_dest.linha01"><br>{{item.destinatario.endereco_dest.linha01}}</span>
                <span v-if="item.destinatario.endereco_dest.linha02"><br>{{item.destinatario.endereco_dest.linha02}}</span>
                <span v-if="item.destinatario.endereco_dest.linha03"><br>{{item.destinatario.endereco_dest.linha03}}</span>

                <span><br>{{item.destinatario.endereco_dest.tipologradouro.descricao}} 
                  {{item.destinatario.endereco_dest.logradouro}}</span>

                <span v-if="item.destinatario.endereco_dest.numero">, {{item.destinatario.endereco_dest.numero}}</span>
                <span v-if="item.destinatario.endereco_dest.complemento"> - {{item.destinatario.endereco_dest.complemento}}</span>
                <span v-if="item.destinatario.endereco_dest.bairro"><br>{{item.destinatario.endereco_dest.bairro}}</span>
                <br>
                <span>CEP: {{ item.destinatario.endereco_dest.CEP}} - 
                  {{item.destinatario.endereco_dest.municipio.cidade}}/
                  {{ item.destinatario.endereco_dest.municipio.estado.descricao }} <br></span>   
              </td>
              <td align="center">
                <span ><b>Data da Postagem</b> <br></span>                
                <span>{{item.dtpost}}</span>
              </td>
              <td align="center" style="padding: 30px; width: 400px;">          
                <h5>Código ECT <b> {{item.codcorreio}}</b></h5>
                <span v-html='item.rastro'/>
              </td>
              <td align="center">
                <span><b>Data da Entrega/Devolução</b><br></span>                
                <span>{{item.dtdev}}</span>
              </td>
              <td align="center" style="padding: 30px;">
                <span><b>Situação</b><br></span>                
                <span>{{item.sit_postagem.descricao}}</span>
              </td>
              <td align="center" >
                <span ><b>Situação do AR</b><br></span>                
                <span >{{item.situacaoAR}}</span>
              </td>
              <td style="padding: 30px;" valign="middle" align="right">
                <v-tooltip bottom >
                  <template v-slot:activator="{ on }">
                    <v-btn  v-on="on" small outlined color="grey dark" style="color:white" v-if="item.tipo_dev < 3" v-on:click="descartarDestinatario(item.codigo)">
                      <v-icon left small color="red lighten-1" >cancel</v-icon>remover
                    </v-btn>
                  </template>
                  <span>Remover Destinatário</span>
                </v-tooltip>
                <v-tooltip bottom>
                  <template v-slot:activator="{ on }">
                    <v-btn v-on="on" small outlined color="grey dark" style="color:white" v-on:click="receberAR(item.codigo)" 
                      v-if="(item.tipo_dev == (6 || 9)) && (item.situacao_ar == 1)">
                    <v-icon >done</v-icon>receber ar
                    </v-btn>
                  </template>
                  Receber AR
                </v-tooltip>

              </td>
            </tr>
          </v-card>
        </div>  
      </v-flex>
      </div>    

    <div v-if="receberApoio" >
      <v-container grid-list-md >
        <v-card style="width: 100%; margin: 0 auto">
          <div>
            <table style="width: 100%; margin-bottom:20px; margin-left:12px;">
              <tr style="margin-left: 12px;width: 100%;">
                <td>
                  <h5>Itens inseridos na lista: {{anoLista}}/{{numeroLista}}</h5>
                </td>
                <td align="right" style="margin-left: 12px; color:white">
                    <v-tooltip bottom  >
                      <template v-slot:activator="{ on }">
                        <v-btn  v-on="on" color="green" style="color:white" v-on:click="concluirLista()">
                        <v-icon color="white" >done</v-icon> Concluir
                        </v-btn>
                      </template>
                      Registrar entrega aos Correios
                    </v-tooltip>
                    <v-tooltip bottom  >
                      <template v-slot:activator="{ on }">
                        <v-btn v-on="on" color="blue" style="color:white" v-on:click="gerarLista()">
                        <v-icon  color="white" >print</v-icon> Imprimir
                        </v-btn>
                      </template>
                      Gerar lista em PDF
                    </v-tooltip>
                  </td>
                <td style="width: 6.5%;"></td>   
              </tr>
            </table>             
            <v-layout no-gutters style="height:20px;margin-bottom:-10px;margin-left:10px" d-flex mb-6 align-end v-for="item in postagens" :key="item.codigo">
              <v-flex xs3>
                <h6 >{{item.documento.dsc_tipo.descricao}} {{item.documento.dsc_setor.descricao}} </h6> 
              </v-flex>
              <v-flex xs1>
                <h6 align="right">{{item.documento.sequencia}}/{{item.documento.ano}}</h6>
              </v-flex>
              <v-flex xs4>
                <h6 >- {{item.destinatario.nome}}</h6>
              </v-flex>
              <v-flex xs3>
                <h6   align="right">{{("00"+item.documento.ano).slice(-2)}}{{("000000"+item.codigo).slice(-6)}} {{item.codcorreio}}</h6>
              </v-flex>
              <v-flex xs1>
                <h6 >
                <v-tooltip bottom>
                  <template v-slot:activator="{ on }" align-start >
                      <v-icon left small v-on="on"  align-start v-on:click="descartarDestLista(item.codigo)" color="blue-grey lighten-3" >cancel</v-icon>
                  </template>
                  <span>Remover etiqueta {{("00"+item.documento.ano).slice(-2)}}{{("000000"+item.codigo).slice(-6)}}</span>
                </v-tooltip>
                </h6>
              </v-flex>              
            </v-layout> 
          </div>
        </v-card>
      </v-container>
      <v-container grid-list-md style="width: 100%; margin: 0 auto">
        <v-card style="width: 100%; margin: 0 auto">
          <div>
            <h5>Inserir documento na lista de postagem</h5>  
            <v-layout style="width: 100%; margin: 0 auto">
              <v-flex xs2>      
                <v-text-field dense
                  label="Código da Etiqueta"
                  v-model="codigoEtiqueta"
                  :rules="[validacao.obrigatorio, validacao.numero, validacao.igual8]"
                  required
                />
              </v-flex>    
              <v-flex xs3>        
                <v-text-field dense
                  label="Código ECT"
                  v-model="codigoECT"
                  :rules="[validacao.obrigatorio,validacao.padraoECT]"
                  required
                />
              </v-flex>
            </v-layout>
          </div>
        </v-card>
      </v-container>
    </div>
    <div v-if="cadastrarDestinatario" >
      <v-container grid-list-md >
        <v-layout style="width: 100%; margin: -4px ">
          <v-flex xs3>
            <h5>{{entidadeAtual.tipo}}</h5>
          </v-flex>
          <v-flex xs1>
            <h5 align="right">{{entidadeAtual.sequencia}}/{{entidadeAtual.ano}} -</h5>
          </v-flex>
          <v-flex xs2 style="margin: 0 ">              
            <h5>{{entidadeAtual.assunto}}</h5> 
          </v-flex>
          <v-flex>
            <h5>{{entidadeAtual.referencia}}</h5>
          </v-flex>
        </v-layout>
        <br><br>
        <h5>Inclusão de Destinatário</h5>
        <br>
        <v-text-field dense
          label="Nome"
          v-model="entidadeAtual.novo.nome"
          :rules="[validacao.obrigatorio]"
          required
        />
        <v-text-field dense
          label="Linha Adicional 01"
          v-model="entidadeAtual.novo.linha01"
        />
        <v-text-field dense
          label="Linha Adicional 02"
          v-model="entidadeAtual.novo.linha02"
        />
        <v-layout style="width: 100%; margin: 0 auto">
          <v-flex xs1>
            <v-select 
              :items="logradouros"
              v-model="entidadeAtual.novo.tipo_log"
              label="Tipo Logradouro"  
              hide-details              
            ></v-select>
          </v-flex>
          <v-flex xs6>      
            <v-text-field 
              label="Logradouro"
              v-model="entidadeAtual.novo.logradouro"
              :rules="[validacao.obrigatorio]"
              required
            />
          </v-flex>    
          <v-flex xs1>        
            <v-text-field 
              label="Número"
              v-model="entidadeAtual.novo.numero"                
            />
          </v-flex>
          <v-flex>
            <v-text-field 
              label="Complemento"
              v-model="entidadeAtual.novo.complemento"
            />
          </v-flex>
        </v-layout>
        <v-text-field 
          label="Bairro"
          v-model="entidadeAtual.novo.bairro"
        />        
        <v-layout style="width: 100%; margin: 0 auto">
          <v-flex xs1  >            
            <v-text-field 
              label="CEP"
              v-model="entidadeAtual.novo.CEP"
              :rules="[validacao.obrigatorio, validacao.numero, validacao.igual8]"
              required
            />        
          </v-flex>
          <v-flex>
            <v-autocomplete
              v-model="entidadeAtual.novo.municipio"
              :items="municipios"
              :search-input.sync="search"
              :loading="carregando"
              @keyup="autoComplete"
              color="blue"
              item-text="text"
              item-value="value"
              label="Município"
              :rules="[validacao.obrigatorio]"
              required      
            ></v-autocomplete>
          </v-flex>
        </v-layout>
      </v-container>
    </div>
    </template>
  </crud>
</template>
<script>
import rotas from "./../../rotas-servico.js";
import CRUD from "./../AdminCRUD";

export default {
  components: {
    crud: CRUD
  },
  data: () => {
    return {
      cabecalhos: [
        {
          value: "id",
          type: 'hidden',
          class: 'hidden',
          sortable:false
        },
        {
          text: "Origem",          
          value: "tipo",
          sortable:false          
        },
        {
          text: "Sequência/ Ano",
          align: 'end',
          class: 'text-end',
          value: "descricao",
          sortable:false
        },
        {
          text: "Assunto",
          value: "assunto",
          sortable:false

        },
        {
          text: "Referência",
          value: "referencia",
          class:"",
          
          icon: 'iconeSituacao',
          color: 'corIconeSituacao',
          iconTooltip: 'situacao',
          sortable:false
        }
      ],
      exibirGrid:false,
      verboAdicionar:'',
      verboConsultar:'Controle de',
      timer:null,
      search: '',
      municipios:[],
      entries: [],
      setores:[],
      setoresInclusao:[],
      cadastrarDestinatario:false,
      receberApoio:false,
      podeSalvar:false,
      cadastrarNovo:false,
      anoPostagem:[],
      anoInclusao:[],
      tipoDocumento:[],
      tipoDocumentoInclusao:[],
      anoApoio:[],
      paginas:[],
      paginaAtual:[],
      registros: [],
      userLegado:null,
      setorSelect:null,
      anoSelect:null,
      tipoSelect:null,
      anoAtual:1,
      paginaCorrente:1,
      setorAtual:null,
      tipoAtual:null,
      entidadeAtual:[{codigo:null}],
      logradouros:[],
      postagens:[],
      anoLista:null,
      numeroLista:null,
      quantidadeLista:null,
      codigoEtiqueta:'',
      codigoECT:'',
      lazy: true,
      carregando: false,
      validacao: {
        obrigatorio: value => !!value || "Preenchimento obrigatório.",
        max60: v => (!!v && v.length <= 60) || "No máximo 60 caracteres",
        max30: v => (!!v && v.length <= 30) || "No máximo 30 caracteres",
        max8:v => (!!v && v.length <= 8) || "No máximo 8 caracteres",
        tipoAssociado: v => ((!!v[1] && v[0]> 15 && v[1].length <= 8 && (/^\d+$/.test(v[1]))) || (v[0] < 16)) 
          || "Documento SEI deve ser informado, com até 8 dígitos",

        min11: v => (!!v && v.length >= 11) || "No mínimo 11 caracteres",
        igual8: v => (!!v && v.length == 8) || "Deve conter 8 dígitos",
        padraoECT: v => (!!v && v.length == 13 && (/^[A-Z]+$/.test(v.substring(0,2))) && (/^\d+$/.test(v.substring(2,11))) && (v.substring(11,13)=='BR')) 
          || "Deve conter 13 dígitos, sem espaços ou edição. Preencha no padrão: 'JH123456789BR'",

        email: v => /.+@.+\..+/.test(v) || "E-mail precisa ser válido",
        numero: value => (/^\d+$/.test(value)) || "Use apenas números, sem edição"        
      },
    };
  },

  methods: {
    novoDestinatario(){
      return ({
        nome:null,
        linha01:null,
        linha02:null,
        linha03:null,
        tipo_log:1,
        logradouro:null,
        numero:null,
        complemento:null,
        bairro:null,
        CEP:null,
        municipio:null,
      });
    },
    autoComplete(){
      this.municipios = [];
      if (this.search.length > 2){
        if (this.timer) {
          clearTimeout(this.timer);
          this.timer = null;
        }
        if (this.search.length > 2){
          this.carregando = true;
          this.timer = setTimeout(() => {      
            var parametros = "?search="+this.search;
            this.$http.get(rotas.rotas().correspondencia.pesquisaMunicipio+parametros).then(
              response => {
                response.body.forEach(element => {
                  this.municipios.push({'text':element.cidade.trim() + "/"+element.estado.descricao, 'value':element.codigo});
                });
              },
              error => {
                console.log(error.body);
                this.$store.commit("sistema/alerta", error.body.message);
            });
            this.entidadeAtual.novo.municipio = null;
            return this.municipios;
          }, 800);
          this.carregando = false;
        }
      }
    },
    mudaPagina(page){
      this.carregarItens(page);
    },
    mudaAnoSetor(dados){
      var page = dados
      this.setorAtual = dados[5];
      this.anoAtual = dados[6];
      this.tipoAtual = dados[7];
      this.carregarItens(page);
    },
    gerarEtiqueta(codcor){
      let url = rotas.rotas().correspondencia.gerarEtiqueta +  codcor;
      this.$http.get(url, { responseType: 'arraybuffer' }).then(
        response => {
//            console.log(response);
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
    gerarLista(){
//      console.log("entrei lista");
      let url = rotas.rotas().correspondencia.gerarLista;
      this.$http.get(url, { responseType: 'arraybuffer' }).then(
        response => {
//            console.log(response);
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
    receberAR(codigo){
      console.log(codigo);
      if (confirm("Deseja confirmar o recebimento deste AR?")){
        let formData = new FormData();
        let url = rotas.rotas().correspondencia.receberAR + "" + codigo;
        this.$http.put(url, formData).then(
          response => {
            this.$store.commit(
              "sistema/mensagem",
              "Recebimento registrado com sucesso",
            );
            this.exibirGrid=true;
            this.carregarItens(this.paginaAtual);
          },
          error => {
            console.log(error.body);
            this.$store.commit("sistema/alerta", error.body.message);
          }       
        );
      }
    },
    concluirLista(){      
      if (confirm("Deseja registrar a entrega ECT?")){
        let formData = new FormData();
        let url = rotas.rotas().correspondencia.concluirLista;
        this.$http.get(url, formData).then(
          response => {
            this.$store.commit(
              "sistema/mensagem",
              "Postagens registradas com sucesso",
            );
            this.exibirGrid=true;
            this.carregarItens(this.paginaAtual);
            this.postar();
          },
          error => {
            console.log(error.body);
            this.$store.commit("sistema/alerta", error.body.message);
          }       
        );
      }
    },

    postar(){
      this.postagens=[];
      this.anoLista = '';
      this.numeroLista = '';
      this.receberApoio = true; 
      this.podeSalvar = true;  
      this.verboAdicionar ='Postar';
      this.verboConsultar = 'Consultar';
      let formData = new FormData();
      let url = rotas.rotas().correspondencia.postagem +""+ this.userLegado ;
      this.$http.put(url, formData).then(
        response => {  
          this.anoLista = response.body.ano;
          this.numeroLista = response.body.codigo;
          response.body.dest_post.forEach(element => {
            this.postagens.push(element);
          });
        },
        error => {
          console.log(error);
        }        
      );
    },
    descartarCorrespondencia(item){
      if (confirm("Deseja remover esta correspondência?")){
        let formData = new FormData();
        let url = rotas.rotas().correspondencia.descartaCorresp + "" + item;
        this.$http.put(url, formData).then(
          response => {
            this.$store.commit(
              "sistema/mensagem",
              "Item descartado com sucesso",
            );
            this.exibirGrid=true;
            this.carregarItens(this.paginaAtual);
          },
          error => {
            console.log(error.body);
            this.$store.commit("sistema/alerta", error.body.message);
          }       
        );
      }
    },

    descartarDestLista(item){
//      console.log("entrei descartarDestLista() " + item);
      let formData = new FormData();
      let url = rotas.rotas().correspondencia.descartarDestLista + "" + item;
      this.$http.put(url, formData).then(
        response => {
          this.$store.commit(
            "sistema/mensagem",
            "Item descartado com sucesso",
          );
          this.postar();
        },
        error => {
          console.log(error.body);
          this.$store.commit("sistema/alerta", error.body.message);
        }       
      );
    },

    descartarDestinatario(item){      
      if (confirm("Deseja remover este destinatário?")){
        let formData = new FormData();
        let url = rotas.rotas().correspondencia.descartaDest + "" + item;
        this.$http.put(url, formData).then(
          response => {
            this.$store.commit(
              "sistema/mensagem",
              "Item descartado com sucesso",
            );
            this.exibirGrid=true;
            this.carregarItens(this.paginaAtual);
          },
          error => {
            console.log(error.body);
            this.$store.commit("sistema/alerta", error.body.message);
          }       
        );
      }
    },
    cadastrarPostagem(item){
      this.entidadeAtual = item
      this.entidadeAtual.novo = this.novoDestinatario();  
    },
    selecionarParaEdicao(item) {
      this.verboConsultar = 'Controle de',
      this.exibirGrid=false;      
      this.entidadeAtual = item
      this.entidadeAtual.novo = this.novoDestinatario();
      this.cadastrarDestinatario = false;
      this.cadastrarNovo=false;      
    },
    mudouTela(item){
    },
    salvar() {
      
      if (this.cadastrarDestinatario){
        this.salvarDestinatario();        
      }
      else{
        if (this.cadastrarNovo){
          this.salvarCorrespondencia();        
        }
        else{
          if (this.receberApoio){
            this.incluirLista();
          }
        }
      }
    },
    incluirLista(){
      let formData = new FormData();
      console.log( this.codigoEtiqueta)
      formData.append("codigo",  this.codigoEtiqueta);
      formData.append("codcorreio",  this.codigoECT);
      formData.append("lista",  this.numeroLista);
//      formData.append("_method", "GET");
      console.log(formData)
      let url = rotas.rotas().correspondencia.inserirLista;
      this.$http.post(url, formData).then(
        response => {
          this.$store.commit(            
            "sistema/mensagem",
            "Documento inserido com sucesso",
          );
//          console.log('salvar lista ' + this.codigoEtiqueta + " " + this.codigoECT);
          this.codigoEtiqueta = '';
          this.codigoECT = '';
//          this.$refs.form.resetValidation();
          this.postar();
        },
        error => {          
          console.log(error.body);
          this.$store.commit("sistema/alerta", error.body.message);
        }       
      );
    },
    salvarCorrespondencia(){
      let formData = new FormData();
      formData.append("tipo",  this.entidadeAtual.tipo);
      formData.append("setor",  this.entidadeAtual.setor);
      formData.append("ano", this.entidadeAtual.ano);
      formData.append("assunto",  this.entidadeAtual.assunto);
      formData.append("referencia", this.entidadeAtual.referencia);
      formData.append("userLegado", this.userLegado);
      let sequencia = 0;
      if (this.entidadeAtual.sequencia){
        sequencia = this.entidadeAtual.sequencia;
      }
      formData.append("sequencia", sequencia);
      formData.append("_method", "POST");
      let url = rotas.rotas().correspondencia.criarCorrespondencia;
      this.$http.post(url, formData).then(
        response => {
          console.log(response);
          this.$store.commit(            
            "sistema/mensagem",
            "Correspondência criada com sucesso",
          );
          this.entidadeAtual.novo = this.novoDestinatario();
          this.exibirGrid=false;
          this.carregarItens(this.paginaAtual);
        },
        error => {          
          console.log(error.body);
          this.$store.commit("sistema/alerta", error.body.message);
        }       
      );
    },
    salvarDestinatario() {      
      let formData = new FormData();
      formData.append("codcor", this.entidadeAtual.codigo);
      formData.append("nome", this.entidadeAtual.novo.nome);
      formData.append("linha01", this.entidadeAtual.novo.linha01);
      formData.append("linha02", this.entidadeAtual.novo.linha02);
      formData.append("linha03", this.entidadeAtual.novo.linha03);
      if(!this.entidadeAtual.novo.logradouro){
        this.entidadeAtual.novo.logradouro = '';
      }      
      formData.append("logradouro", this.entidadeAtual.novo.logradouro);      
      if(!this.entidadeAtual.novo.numero){
        this.entidadeAtual.novo.numero = '';
      }
      formData.append("numero", this.entidadeAtual.novo.numero); 
      if(!this.entidadeAtual.novo.complemento){
        this.entidadeAtual.novo.complemento = '';
      }
      formData.append("complemento", this.entidadeAtual.novo.complemento);
      if(!this.entidadeAtual.novo.bairro){
        this.entidadeAtual.novo.bairro = '';
      }      
      formData.append("bairro", this.entidadeAtual.novo.bairro);
      formData.append("municipio", this.entidadeAtual.novo.municipio);
      formData.append("CEP", this.entidadeAtual.novo.CEP);
      formData.append("tipo_log", this.entidadeAtual.novo.tipo_log);
      formData.append("userLegado", this.userLegado);            
      formData.append("_method", "GET");
      let url = rotas.rotas().correspondencia.criarDestinatario;
      this.$http.post(url, formData).then(
        response => {
//          console.log(response);
          this.$store.commit(
            "sistema/mensagem",
            "Destinatário criado com sucesso",
          );
          this.entidadeAtual = {
            codigo: null
          };            
          this.entidadeAtual.novo = this.novoDestinatario();
          this.exibirGrid=true;
          this.carregarItens(this.paginaAtual);
        },
        error => {
          console.log(error.body);
          this.$store.commit("sistema/alerta", error.body.message);
        }       
      );
    },
    cancelar() {
      this.exibirGrid=true;
      this.cadastrarNovo=false;
      this.receberApoio=false;
      this.cadastrarDestinatario=false;
      this.podeSalvar = false;
      this.codigoEtiqueta = '';
      this.codigoECT = '';
      this.verboAdicionar ='';
    },
    novo() {
      this.verboAdicionar ='Cadastrar';
      this.cadastrarNovo=true;
      this.podeSalvar = true;      
      this.cadastrarDestinatario=false;
      this.entidadeAtual = {
        codigo: null,
        setor:this.setorSelect,
        ano:this.anoSelectInclusao,
      };
      this.entidadeAtual.novo = this.novoDestinatario();
    },
    carregarSetores(){
      this.setores = [];
      this.setoresInclusao = [];
      this.setores.push({'text':"TODOS", 'value':'-1'});
      this.setorSelect = null;
      this.$http.get(rotas.rotas().correspondencia.setores).then(
        response => {
          response.body.forEach(element => {
            if (element.codigo){              
              this.setores.push({'text':element.descricao, 'value':element.codigo});
              this.setoresInclusao.push({'text':element.descricao, 'value':element.codigo});
            }
            else{
              if(element.userSetor){
                this.setorSelect = element.userSetor.setor.codigo;
                this.userLegado  = element.userSetor.codigo;
                this.setorAtual = this.setorSelect;
              }
            }
          });
        },
        error => {
          console.log(error);
        }        
      );
    },
    carregarTipos(){
      this.tipoDocumento = [];
      this.tipoDocumentoInclusao = [];
      this.tipoDocumento.push({'text':"TODOS", 'value':-1});
      this.tipoSelect = -1;
      this.tipoAtual  = this.tipoSelect;
      this.$http.get(rotas.rotas().correspondencia.tipos).then(
        response => {       
          response.data.forEach(element => {
            this.tipoDocumento.push({'text':element.descricao, 'value':element.codigo});
            this.tipoDocumentoInclusao.push({'text':element.descricao, 'value':element.codigo});
          });
        },
        error => {
          console.log(error);
        }        
      );
    },
    carregarLogradouros(){
      this.logradouros = [];
      this.$http.get(rotas.rotas().correspondencia.logradouros).then(
        response => {     
          response.data.forEach(element => {
            this.logradouros.push({'text':element.descricao, 'value':element.codigo});
          });
        },
        error => {
          console.log(error);
        }        
      );
    },
    carregarItens(page) {
      this.exibirGrid= true;
      var situacao_ar =['', 'Aguardando Retorno', 'Recebido na SPU', 'Não Definico'];
      this.cadastrarDestinatario = false;      
      this.paginaAtual = page;
      this.carregando = true;
      this.registros = [];
      this.paginas=[];
      this.paginaCorrente = page[0];
      if (!page[1]){
        page[1]=10
      }
      page[2] = page[2].normalize('NFD').replace(/[\u0300-\u036f]/g, "");
      var parametros =  "?page="+page[0]+   "&per_page="+page[1]+
                        "&search="+page[2]+ "&ordem="+this.cabecalhos[page[3]].value + 
                        "&ascending="+page[4]+"&ano="+this.anoApoio[this.anoAtual] + 
                        "&setor="+this.setorAtual + "&tipo="+this.tipoAtual;
      this.$http.get(rotas.rotas().correspondencia.listar+parametros).then(
        response => {
          this.paginas = response.body;
          response.body.data.forEach(element => {
            element.id = element.codigo
            element.ano = element.ano.toString();
            element.sequencia = element.sequencia.toString();
            if (element.sequencia.length < 4){
              element.sequencia = ("0000"+element.sequencia).slice(-4);
            }
            element.setor = element.dsc_setor.descricao;
            element.tipo = element.dsc_tipo.descricao + " " + element.setor;          
            element.descricao = element.sequencia + "/"+element.ano;
            element.descartar = true;
            element.postagens.forEach(post =>{
              if (post.dtdev){
                var d = new Date(post.dtdev); 
                post.dtdev = ("00" + (d.getDate()+1)).slice(-2) + '/' +  ("00" + (d.getMonth()+1)).slice(-2) + '/' + d.getFullYear();
                if (post.dtdev_ar){
                  var dr = new Date(post.dtdev_ar);
                  post.situacaoAR = situacao_ar[post.situacao_ar] + " em " + ("00" + (dr.getDate()+1)).slice(-2) + '/' +  ("00" + (dr.getMonth()+1)).slice(-2) + '/' + dr.getFullYear();
                }
                else{
                  post.situacaoAR = situacao_ar[post.situacao_ar];
                }
              }
              else{
                post.situacaoAR = '';
              }
              if (post.dtpost){
                var dt = new Date(post.dtpost);
                post.dtpost = dt.toLocaleString();
              }              
            });
            if (element.postagens[0]){
              element.descartar = false;
            }            
            element.novo = this.novoDestinatario();
            this.registros.push(element);
          });
        },
        error => {
          console.log(error);
        }
      );
      
      this.carregando = false;
    }
  },
  mounted() {
    var d = new Date();
    var ind = 1;
    var i;
    this.anoSelect = 1;
    this.anoPostagem = [];
    this.anoInclusao = [];
    this.anoAtual = 1;
    for (i = d.getFullYear(); i > 2012 ; i--) {
      this.anoPostagem.push({'text':i , 'value':ind});
      this.anoApoio[ind]=i;
      ind++;
    }
    i = d.getFullYear();
    this.anoSelectInclusao = i;
    for (ind =  1; ind < 3 ; ind++) {
      this.anoInclusao.push({'text':i , 'value':i});
      i--;
    }
    this.carregarSetores();
    this.carregarTipos();
    this.carregarLogradouros();
    this.carregarItens([1, '10', '', '0', true]);
  }
}
</script>
<style >
@import "https://cdn.materialdesignicons.com/2.5.94/css/materialdesignicons.min.css";
@import "https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700,900|Material+Icons";
.container {
  padding: 0px;
}
.itemLista {
  height: 25pt;
}
.descricao {
  text-align: right;
}
.referencia {
  text-align: right;
}
.container {
  margin: -10pt;
}
.v-input--selection-controls {
  margin: 0px;
}
.btnW {
 font-size: 11px; 
}
table.listEvent tr td.sroDtEvent, table.listEvent tr td.sroLcEvent, table.sro2 tr td  {
	font-size: 11px;
	color: #8A8A8A;
	border-top: 1px dotted #8A8A8A;
}
table.listEvent tr td.sroLbEvent, table.sro2 tr td {
	font-size: 11px;
	/*font-weight: bold;*/
	border-top: 1px dotted #8A8A8A;
}
</style>
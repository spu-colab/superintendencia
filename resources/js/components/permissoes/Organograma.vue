<template>
  <crud
    nomeEntidade="Divisões/Organograma"
    nomeEntidadePlural="Divisões/Núcleos"
    :headers="cabecalhos"
    :items="registros"
    :carregando="carregando"
    @clicou-item="selecionarParaEdicao"
    @clicou-salvar="salvar"
    @clicou-cancelar="cancelar"
    @clicou-novo="novo"
  >
    <template slot="detalhe">
      <v-card-text>
        <div v-if="entidadeAtual">
          <v-tabs v-model="tabAtiva" color="grey lighten-5" >
            <v-tab>Cadastro</v-tab>
            <v-tab>Usuários</v-tab>
            <v-tabs-slider color="primary"></v-tabs-slider>
            <v-tab-item>
              <v-container>
                <v-autocomplete 
                  label="Divisão Pai" 
                  :items="divisoesRaiz" 
                  v-model="entidadeAtual.divisao_organograma_pai.id" 
                  item-text="nome" 
                  item-value="id" 
                  :rules="entidadeAtual.id == null ? [validacao.obrigatorio] : [false]" 
                  :required="entidadeAtual.divisaoOrganogramaPai == null ? false : true"
                />          
                <v-text-field
                  label="Nome"
                  v-model="entidadeAtual.nome"
                  :rules="[validacao.obrigatorio]"
                  required
                />
                <v-text-field
                  label="Sigla"
                  v-model="entidadeAtual.sigla"
                  :rules="[validacao.obrigatorio]"
                  required
                />
              </v-container>
            </v-tab-item>
      <!-- Usuarios -->                        
            <v-tab-item>
              <h5><br><p style="text-align:center">{{entidadeAtual.nome}}</p></h5>
              <v-divider/>
              <CaixaSelecao
                :itensCaixa="itensCaixa"              
              />                
            </v-tab-item>
          </v-tabs>
        </div>
      </v-card-text>
    </template>
  </crud>
</template>
<script>
import rotas from "./../../rotas-servico.js";
import CRUD from "./../CRUD";
import CaixaSelecao from "./../CaixaSelecao";
export default {
  components: {
    crud: CRUD
  },
  data: () => {
    return {
      cabecalhos: [
        {
          text: "Divisão Pai",
          value: "nomePai"
        },
        {
          text: "Nome",
          value: "nome"
        },
        {
          text: "Sigla",
          value: "sigla"
        }
      ],
      tabAtiva: 0,
      registros: [],
      usuarios: [],
      divisoesRaiz: [],
      itensCaixa:[],
      entidadeAtual: null,
      carregando: false,
      validacao: {
        obrigatorio: value => !!value || "Preenchimento obrigatório.",
        min11: v => (!!v && v.length >= 11) || "No mínimo 11 caracteres",
        min2: v => (!!v && v.length >= 2) || "No mínimo 2 caracteres",
        email: v => /.+@.+\..+/.test(v) || "E-mail precisa ser válido"
      }
    };
  },
  methods: {
    selecionarParaEdicao(item) {
      this.entidadeAtual = item;
      this.formatarUsuarios(this.entidadeAtual);
      if(this.entidadeAtual.divisao_organograma_pai == null) {
        this.entidadeAtual.divisao_organograma_pai = {}
      }
    },
    salvar() {
      let formData = new FormData();
      formData.append("id", this.entidadeAtual.id);
      formData.append("nome", this.entidadeAtual.nome);
      formData.append("sigla", this.entidadeAtual.sigla);      
      formData.append("idPai", this.entidadeAtual.divisao_organograma_pai.id);      
      $.each( $(".itemSelecionado option"), function() {
        formData.append("usuarios[]", this.value);
      });
      if (this.entidadeAtual.id != null) {
        formData.append("_method", "PUT");
      }
      let url =
        this.entidadeAtual.id === null
          ? rotas.rotas().organograma.criar
          : rotas.rotas().organograma.editar + "" + this.entidadeAtual.id;
      this.$http.post(url, formData).then(
        response => {
          this.$store.commit(
            "sistema/mensagem",
            "Organograma atualizado com sucesso",
          );
          this.$router.push("/organograma");
          this.carregarItens();
        },
        error => {
          console.log(error.body);
          this.$store.commit("sistema/alerta", error.body.message);
        }
      );
    },
    cancelar() {},
    novo(item) {
      this.entidadeAtual = {
        id: null,
        divisao_organograma_pai: {}
      }        
    },
    carregarUsuarios() {
      this.carregando = true;
      this.usuarios = [];
      this.$http.get(rotas.rotas().organograma.usuario).then(
        response => {
          response.body.forEach(element => {
            element["checked"] = false;
            this.usuarios.push(element);
          });
          this.carregando = false;
        },
        error => {
          console.log(error);
          this.carregando = false;
        }
      );
    },
    formatarUsuarios: function(element) {
      let usuariosLocal = null;
      var index = null;
      var itensCaixaLocal = [];
      usuariosLocal = JSON.parse(JSON.stringify(this.usuarios)),
      usuariosLocal.forEach(elem => {           
        itensCaixaLocal.push(
          {
            'id': elem.id,
            'nome': elem.name,
            'checked': false
          });
      });      
      element.usuarios.forEach(elem => {           
        index = usuariosLocal.findIndex(p => p.id == elem.idUsuario);
        itensCaixaLocal[index]['checked'] = true;       
      });
      this.itensCaixa = itensCaixaLocal;
      element["usuariosL"] = usuariosLocal;
      return element;
    },
    carregarDivisoes () {
      this.carregando = true;
      this.divisoesRaiz = [];
      var divisaoPai =[];
      this.$http
          .get(rotas.rotas().organograma.listarPai)
          .then(
              response => {
                response.body.forEach(element => {
                  this.divisoesRaiz.push(element)
                })
                this.carregando = false;
              },
              error => {
                console.log(error)
                this.carregando = false;
              }
          )
    },
    carregarItens() {
      this.carregarUsuarios();
      this.carregarDivisoes();
      this.carregando = true;
      this.registros = [];
      this.$http.get(rotas.rotas().organograma.listar).then(
        response => {
          response.body.forEach(element => {
            if (element.divisao_organograma_pai){
                element.nomePai = element.divisao_organograma_pai['nome'];
            }
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
    this.carregarItens();
  }
};
</script>
<style scoped>
.container {
  margin: 10pt;
}
.v-input--selection-controls {
  margin: 10px;
}
</style>
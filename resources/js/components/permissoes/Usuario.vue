<template>
  <crud
    nomeEntidade="Usuário"
    nomeEntidadePlural="Usuários"
    :headers="cabecalhos"
    :items="registros"
    :imprimir="false"
    :paginas="paginas"  
    :carregando="carregando"
    :podeSalvar="podeSalvar()"
    @clicou-item="selecionarParaEdicao"
    @clicou-salvar="salvar"
    @clicou-cancelar="cancelar"
    @clicou-novo="novo" 
    @validou-formulario="formularioValido" 
    :voltar-para-primeira-tela-ao-salvar="false"
    :exibirPaginacaoCliente=false
    @mudaPagina="mudaPagina"
  >
    <template slot="detalhe">
      <div v-if="entidadeAtual">
        <v-row>
          <v-col xs="12" md="6">
            <v-text-field label="Nome" v-model="entidadeAtual.name" :disabled="!podeCadastrar" 
              :rules="[validacao.obrigatorio, validacao.min(entidadeAtual.name, 4)]" required />
          </v-col>
          <v-col xs="12" md="6">
            <v-text-field label="CPF" v-model="entidadeAtual.cpf"
              type="number" :rules="[validacao.obrigatorio, validacao.min(entidadeAtual.cpf, 11)]" required
              counter="11" maxlength=11
              :disabled="entidadeAtual.id ? true : false"            
            />
          </v-col>
        </v-row>
        <v-row>
          <v-col xs="12" md="6">
            <v-text-field label="E-mail" v-model="entidadeAtual.email" :disabled="!podeCadastrar" 
              :rules="[validacao.obrigatorio, validacao.email, validacao.min(entidadeAtual.email, 6)]" required />
          </v-col>
          <v-col xs="12" md="6">
            <v-text-field label="Telefone" v-model="entidadeAtual.telefone" :disabled="!podeCadastrar"
              :rules="[validacao.obrigatorio, validacao.min(entidadeAtual.telefone, 10)]" required 
              counter="15" maxlength=15 />
          </v-col>
        </v-row>
        <v-row>
          <v-col xs="12" md="6">
            <h4>Permissões</h4>
            <v-divider/>
            <div
              v-for="(permissao) in entidadeAtual.permissoesL"
              v-bind:key="permissao.id"
              class="itemLista"
            >
              <v-checkbox
                :label="permissao.permissao"
                align-start
                v-model="permissao.checked"
                :disabled="!podeCadastrar"
              ></v-checkbox>
            </div>
            <br>
          </v-col>
          <v-col xs="12" md="6">
            <h4>Divisões</h4>
            <v-divider/>
            <div
              v-for="(divisao) in entidadeAtual.divisoesL"
              v-bind:key="divisao.id"
              class="itemLista"
            >
              <v-checkbox
                :label="divisao.sigla + ' - ' + divisao.nome"
                align-start
                v-model="divisao.checked"
                :disabled="!podeCadastrar"
              ></v-checkbox>
            </div>
          </v-col>
        </v-row>
      </div>
      <div class="text-center">
        <template>
          <div class="text-center"></div>
        </template>
      </div>
    </template>
  </crud>
</template>

<script>
import rotas from "./../../rotas-servico.js";
import CRUD from "./../CRUD";

const PERMISSAO_CADASTRAR = "USUARIO_CADASTRAR"

export default {
  components: {
    crud: CRUD
  },
  data: () => {
    return {
      cabecalhos: [
        {
          text: "Usuário",
          value: "name"
        },
        {
          text: "E-mail",
          value: "email"
        },
        {
          text: "CPF",
          value: "cpf"
        },
        {
          text: "Telefone",
          value: "telefone"
        }
      ],
      registros: [],
      permissoes: [],
      divisoes: [],
      paginas:[],
      paginaAtual:[],
      entidadeAtual: null,
      carregando: false,
      validacao: {
        obrigatorio: value => !!value || "Preenchimento obrigatório.",
        min: (v, min) => (!!v && v.length >= min) || "No mínimo " + min + " caracteres",
        email: v => /.+@.+\..+/.test(v) || "E-mail precisa ser válido"
      },
      podeCadastrar: false,
      passouValidacao: false
    };
  },
  methods: {
    mudaPagina(page){
      this.carregarItens(page);
    },
    selecionarParaEdicao(item) {
      this.entidadeAtual = item;
      this.formatarPermissoes(this.entidadeAtual);
    },
    salvar() {
      let formData = new FormData();
      let permissoes = [];
      formData.append("id", this.entidadeAtual.id);
      formData.append("name", this.entidadeAtual.name);
      formData.append("cpf", this.entidadeAtual.cpf);
      formData.append("email", this.entidadeAtual.email);
      formData.append("telefone", this.entidadeAtual.telefone);

      this.entidadeAtual.permissoesL.forEach(element => {
        if (element.checked) {
          formData.append("permissoes[]", element.id);
        }
      });

      this.entidadeAtual.divisoesL.forEach(element => {
        if (element.checked) {
          formData.append("divisoes[]", element.id);
        }
      });

      if (this.entidadeAtual.id != null) {
        formData.append("_method", "PUT");
      }
      let url = this.entidadeAtual.id === null
          ? rotas.rotas().usuario.criar
          : rotas.rotas().usuario.editar + "" + this.entidadeAtual.id;

      this.$http.post(url, formData).then(
        response => {
          this.$store.commit(
            "sistema/mensagem",
            "Usuário atualizado com sucesso",
          );
          this.carregarItens(this.paginaAtual);
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
        cpf: null,
        permissoes: {},
        divisoes: {}
      };
      this.entidadeAtual["permissoesL"] = JSON.parse(
        JSON.stringify(this.permissoes)
      );
      this.entidadeAtual["divisoesL"] = JSON.parse(
        JSON.stringify(this.divisoes)
      );
      this.entidadeAtual["novo"] = true;
    },

    carregarPermissoes() {
      this.carregando = true;
      this.permissoes = [];
      this.$http.get(rotas.rotas().permissao.listar).then(
        response => {
          response.body.forEach(element => {
            element["checked"] = false;
            this.permissoes.push(element);
          });
          this.carregando = false;
        },
        error => {
          console.log(error);
          this.carregando = false;
        }
      );
    },

    carregarDivisoes() {
      this.carregando = true;
      this.divisoes = [];
      this.$http.get(rotas.rotas().organograma.listar).then(
        response => {
          response.body.forEach(element => {
            element["checked"] = false;
            this.divisoes.push(element);
          });
          this.carregando = false;
        },
        error => {
          console.log(error);
          this.carregando = false;
        }
      );
    },

    formatarPermissoes: function(element) {
      let divisoesLocal = null;
      let permissoesLocal = null;
      var index = null;

      (element["permissoesL"] = JSON.parse(JSON.stringify(this.permissoes))),
        (permissoesLocal = element["permissoesL"].concat()),
        element.permissoes.forEach(element => {
          index = permissoesLocal.findIndex(p => p.id == element.id);
          permissoesLocal[index]["checked"] = true;
        });
      element["divisoesL"] = JSON.parse(JSON.stringify(this.divisoes));
      divisoesLocal = element["divisoesL"].concat();
      element.divisoes_organograma.forEach(element => {
        index = divisoesLocal.findIndex(p => p.id == element.id);
        divisoesLocal[index]["checked"] = true;
      });
      return element;
    },
    carregarItens(page) {      
      this.carregarPermissoes();
      this.carregarDivisoes();
      this.paginaAtual = page;
      this.carregando = true;
      this.registros = [];
      this.paginas=[];
      var parametros =  "?page="+page[0]+   "&per_page="+page[1]+
                        "&search="+page[2]+ "&ordem="+this.cabecalhos[page[3]].value + 
                        "&ascending="+page[4];
      this.$http.get(rotas.rotas().permissao.listar+parametros).then(
        response => {
          this.paginas = response.body;
          response.body.data.forEach(element => {
            this.registros.push(element);
          });
        },
        error => {
          console.log(error);
        }
      );
      this.carregando = false;
    },

    carregarPermissoesUsuario() {
      let usuario = this.$store.getters['auth/usuario'];

      this.podeCadastrar = false
      let url = rotas.rotas().permissao.usuario
      url = url.replace('[permissao]', PERMISSAO_CADASTRAR)
      this.$http.get(url).then(
        response => {
          this.podeCadastrar = response.body
        },
        error => {
          console.log(error)
        }
      )
    },

    formularioValido(valido) {
      this.passouValidacao = valido
    },

    podeSalvar() {
      return this.podeCadastrar != null && this.podeCadastrar && this.passouValidacao
    }
  },

  mounted() {
    this.carregarPermissoesUsuario();
    this.carregarPermissoes();
    this.carregarDivisoes();
    this.carregarItens([1, '10', '', '0', true]);
  }
};
</script>
<style scoped>
.itemLista {
  padding: 3pt;
}
.container {
  margin: -10pt;
}
.v-input--selection-controls {
  margin: 0px;
}
</style>
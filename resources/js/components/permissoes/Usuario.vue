<template>
  <crud
    nomeEntidade="Usuário"
    nomeEntidadePlural="Usuários"
    :headers="cabecalhos"
    :items="registros"
    :carregando="carregando"
    @clicou-item="selecionarParaEdicao"
    @clicou-salvar="salvar"
    @clicou-cancelar="cancelar"
    @clicou-novo="novo"
  >
    <template slot="detalhe">
      <div v-if="entidadeAtual">
          <v-text-field
            label="Nome"
            v-model="entidadeAtual.name"
            disabled
          />
          <v-text-field
            label="CPF"
            v-model="entidadeAtual.cpf"
            type="number"
            :rules="[validacao.obrigatorio, validacao.min11]"
            required
            counter="11"
            maxlength=11
            :disabled="entidadeAtual.id ? true : false"            
          />
        <v-container fluid fill-height>
          <v-layout row wrap>
            <v-flex xs12 md6>
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
                  :disabled="false"
                ></v-checkbox>
              </div>
              <br>
            </v-flex>
            <v-flex xs12 md6>
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
                  :disabled="false"
                ></v-checkbox>
              </div>
            </v-flex>
          </v-layout>
        </v-container>
      </div>
    </template>
  </crud>
</template>

<script>
import rotas from "./../../rotas-servico.js";
import CRUD from "./../CRUD";

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
      this.formatarPermissoes(this.entidadeAtual);
    },
    salvar() {
      let formData = new FormData();
      let permissoes = [];
      formData.append("user[id]", this.entidadeAtual.id);
      formData.append("user[cpf]", this.entidadeAtual.cpf);

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
      let url =
        this.entidadeAtual.id === null
          ? rotas.rotas().usuario.criar
          : rotas.rotas().usuario.editar + "" + this.entidadeAtual.id;

      this.$http.post(url, formData).then(
        response => {
          this.$store.commit(
            "sistema/mensagem",
            "Usuário atualizado com sucesso",
          );
          this.$router.push("/permissao");
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
      this.$http.get(rotas.rotas().permissao.permissao).then(
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
    carregarItens() {
      this.carregando = true;
      this.registros = [];
      var registrosLocal = [];
      this.$http.get(rotas.rotas().usuario.listar).then(
        response => {
          response.body.forEach(element => {
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
    this.carregarPermissoes();
    this.carregarDivisoes();
    this.carregarItens();
  }
};
</script>
<style scoped>
.itemLista {
  height: 25pt;
}
.container {
  margin: -10pt;
}
.v-input--selection-controls {
  margin: 0px;
}
</style>
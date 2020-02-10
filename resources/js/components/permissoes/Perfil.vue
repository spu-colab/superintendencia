<template>
  <crud
    nomeEntidade="Permissão"
    nomeEntidadePlural="Permissões"
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
          label="Permissao"
          v-model="entidadeAtual.permissao"
          :rules="[validacao.obrigatorio]"
          :disabled=true    
          required     
        />
        <v-text-field
          label="Descrição"
          v-model="entidadeAtual.descricao"
          :disabled=true          
        />
        <div v-if="entidadeAtual.id">
          <h5><p style="text-align:center">Usuários</p></h5>
          <v-divider/>
          <CaixaSelecao
            :itensCaixa="itensCaixa"
          />  
        </div>              
      </div>
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
          text: "Permissão",
          value: "permissao"
        },
        {
          text: "Descrição",
          value: "descricao"
        }
      ],
      registros: [],
      usuarios:[],
      entidadeAtual: null,
      carregando: false,
      itensCaixa:[],      
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
      this.entidadeAtual = item
      this.formatarUsuarios(this.entidadeAtual);
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
    salvar() {
      let formData = new FormData();
      formData.append("permissao[id]", this.entidadeAtual.id);
      formData.append("permissao[permissao]", this.entidadeAtual.permissao);
      formData.append("permissao[descricao]", this.entidadeAtual.descricao);
      $.each( $(".itemSelecionado option"), function() {
        formData.append("usuarios[]", this.value);
      });

      if (this.entidadeAtual.id != null) {
        formData.append("_method", "PUT");
      }
      let url =
        this.entidadeAtual.id === null
          ? rotas.rotas().perfil.criar
          : rotas.rotas().perfil.editar + "" + this.entidadeAtual.id;
      this.$http.post(url, formData).then(
        response => {
          this.$store.commit(
            "sistema/mensagem",
            "Permissão atualizada com sucesso",
          );
          this.$router.push("/perfil");
          this.carregarItens();
        },
        error => {
          console.log(error.body);
          this.$store.commit("sistema/alerta", error.body.message);
        }
      );
    },
    cancelar() {
    },
    novo() {
      this.entidadeAtual = {
        id: null,     
        usuarios: [],         
      };
      this.formatarUsuarios(this.entidadeAtual);
    },
    carregarItens() {
      this.carregarUsuarios();
      this.carregando = true;
      this.registros = [];
      var registrosLocal = [];
      this.$http.get(rotas.rotas().perfil.listar).then(
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
    this.carregarItens();
  }
}
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
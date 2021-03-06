<template>
    <crud
        nomeEntidade="Permissão"
        nomeEntidadePlural="Permissões"
        :headers="cabecalhos"
        :items="registros"
        :carregando="carregando"
        :imprimir="false"
        :paginas="paginas"
        :exibirPaginacaoCliente="false"
        @mudaPagina="mudaPagina"
        @clicou-item="selecionarParaEdicao"
        @clicou-salvar="salvar"
        @clicou-cancelar="cancelar"
        @clicou-novo="novo"
    >
        <template slot="detalhe">
            <div v-if="entidadeAtual">
                <v-text-field
                    label="Permissão"
                    v-model="entidadeAtual.permissao"
                    :rules="[validacao.obrigatorio]"
                    :disabled="true"
                    required
                />

                <v-text-field
                    label="Descrição"
                    v-model="entidadeAtual.descricao"
                    :disabled="true"
                />

                <div v-if="entidadeAtual.id">
                    <h5><p style="text-align:center">Usuários</p></h5>
                    <v-divider />
                    <caixa-selecao :itensCaixa="itensCaixa" />
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
            paginas: [],
            paginaAtual: [],
            registros: [],
            usuarios: [],
            entidadeAtual: null,
            carregando: false,
            itensCaixa: [],
            validacao: {
                obrigatorio: value => !!value || "Preenchimento obrigatório.",
                min11: v =>
                    (!!v && v.length >= 11) || "No mínimo 11 caracteres",
                min2: v => (!!v && v.length >= 2) || "No mínimo 2 caracteres",
                email: v => /.+@.+\..+/.test(v) || "E-mail precisa ser válido"
            }
        };
    },

    methods: {
        mudaPagina(page) {
            this.carregarItens(page);
        },
        selecionarParaEdicao(item) {
            this.entidadeAtual = item;
            this.formatarUsuarios(this.entidadeAtual);
        },

        carregarUsuarios() {
            this.carregando = true;
            this.usuarios = [];
            this.$http.get(rotas.rotas().usuario.listar).then(
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

            (usuariosLocal = JSON.parse(JSON.stringify(this.usuarios))),
                usuariosLocal.forEach(elem => {
                    itensCaixaLocal.push({
                        id: elem.id,
                        nome: elem.name,
                        checked: false
                    });
                });
            element.usuarios.forEach(elem => {
                index = usuariosLocal.findIndex(p => p.id == elem.idUsuario);
                itensCaixaLocal[index]["checked"] = true;
            });
            this.itensCaixa = itensCaixaLocal;
            element["usuariosL"] = usuariosLocal;
            return element;
        },
        salvar() {
            let formData = new FormData();
            $.each($(".itemSelecionado option"), function() {
                formData.append("usuarios[]", this.value);
            });
            if (this.entidadeAtual.id != null) {
                formData.append("_method", "PUT");
            }
            let url =
                this.entidadeAtual.id === null
                    ? rotas.rotas().permissao.criar
                    : rotas.rotas().permissao.editar +
                      "" +
                      this.entidadeAtual.id;
            this.$http.post(url, formData).then(
                response => {
                    this.$store.commit(
                        "sistema/mensagem",
                        "Permissão atualizada com sucesso"
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
        novo() {
            this.entidadeAtual = {
                id: null,
                usuarios: []
            };
            this.formatarUsuarios(this.entidadeAtual);
        },
        carregarItens(page) {
            this.paginaAtual = page;
            this.carregarUsuarios();
            this.carregando = true;
            this.registros = [];
            this.paginas = [];
            if (!page[1]) {
                page[1] = 10;
            }
            var parametros =
                "?page=" +
                page[0] +
                "&per_page=" +
                page[1] +
                "&search=" +
                page[2] +
                "&ordem=" +
                this.cabecalhos[page[3]].value +
                "&ascending=" +
                page[4];
            this.$http.get(rotas.rotas().perfil.listar + parametros).then(
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
        }
    },
    mounted() {
        this.carregarItens([1, "10", "", "0", true]);
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

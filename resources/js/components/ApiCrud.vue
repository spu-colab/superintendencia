<template>
  <v-container fill-height fluid>
    <v-layout row wrap>
      <v-flex xs12 fill-height v-if="exibirGrid" transition="slide-x-reverse-transition">
        <v-card>
          <v-card-title>
            <v-toolbar-title>{{ nomeEntidadePlural }}</v-toolbar-title>
            <v-divider class="mx-2" inset vertical></v-divider>
            <v-spacer></v-spacer>
            <v-text-field v-model="search" append-icon="search" label="Buscar" single-line :error-messages="searchMessage()" 
                @keyup.enter="doSearch()" @click:append="doSearch()" 
                @focus="searchFocused = true" @blur="searchFocused = false"></v-text-field>
            <v-spacer></v-spacer>
            <v-divider class="mx-2" inset vertical></v-divider>
            <v-flex>
              <slot name="beforeAdd"></slot>
            </v-flex>
            <v-spacer></v-spacer>
            <slot name="addButtonArea">
              <v-btn color="primary" dark class="mb-2" @click="cadastrarNovo">
                <v-icon>add</v-icon>
                {{ verboAdicionarEntidade}} {{ nomeEntidade }}
              </v-btn>
            </slot>
            <v-container>
              <v-layout row wrap></v-layout>
            </v-container>
          </v-card-title>

          <slot name="beforeTable"></slot>

          <v-data-table
            :headers="headers"
            :items="items"
            v-model="selected"
            :options="options"
            show-select
            :item-key="itemKey"
            :loading="carregando"
            :hide-default-header="true"
            :hide-default-footer="true"
          >
            <v-progress-linear slot="progress" color="blue" indeterminate></v-progress-linear>

            <template slot="body.prepend">
                
                    <tr style="border-bottom: thin solid rgba(0,0,0,.12);">
                        <th></th>
                        <th
                        v-for="(header, index) in headers"
                        :key="index"
                        :style="header.text == 'id' ? '' :estiloDaColuna(header)"
                        role="columnheader"
                        @click="toggleSort(index)"
                        class="text-start sortable"
                        >
                        <h4 v-if="header.type == 'filter'">
                            <v-layout align-center row fill-height>
                            <v-autocomplete label tabindex="2" clearable v-model="columnFilters[index]"></v-autocomplete>
                            </v-layout>
                        </h4>
                        <span else>{{ headers[index].text }}</span>
                        <v-icon v-if="headers[index].sortable && headers[index].value == options.order" small>{{ options.ascending ? 'arrow_upward' : 'arrow_downward' }}</v-icon>
                        </th>
                    </tr>
                
            </template>

            <template slot="item" slot-scope="props">
              <tr>
                <td>
                  <v-checkbox v-model="props.selected" primary hide-details></v-checkbox>
                </td>
                <td
                  v-for="(header, index2) in headers"
                  :key="index2"
                  :style="estiloDaColuna(header)"
                  v-on:click="clicouItem(props.item)"
                  :class="header.type == 'hidden' ? 'hidden' : ''"
                >
                  <!-- hidden -->
                  <div v-if="header.type == 'hidden'"></div>

                  <!-- checkbox -->
                  <div v-else-if="header.type == 'checkbox'">
                    <v-checkbox disabled v-model="props.item[header.value]" :color="header.color"></v-checkbox>
                  </div>

                  <!-- boolean-icon -->
                  <div v-else-if="header.type == 'boolean-icon'">
                    <v-icon v-if="props.item[header.value]" :color="header.color">{{ header.icon }}</v-icon>
                  </div>

                  <!-- chip -->
                  <div v-else-if="header.type == 'chip'">
                    <v-chip
                      v-for="(chip, chipIndex) in props.item[header.value]"
                      :key="chipIndex"
                      small
                    >
                      <small>{{ chip.value }}</small>
                    </v-chip>
                  </div>

                  <!-- date -->
                  <div v-else-if="header.type == 'date'">
                    <v-badge v-if="props.item[header.icon]" :color="header.color">
                      <template slot="badge">
                        <v-tooltip top>
                          <template v-slot:activator="{ on }">
                            <v-icon dark small v-on="on">{{ props.item[header.icon] }}</v-icon>
                          </template>
                          {{ props.item.iconTooltip }}
                        </v-tooltip>
                      </template>
                      <span>{{ formatDate(props.item[header.value]) }}</span>
                    </v-badge>
                    <span v-else>{{ formatDate(props.item[header.value]) }}</span>
                  </div>

                  <!-- outros -->
                  <div v-else>
                    <v-badge v-if="props.item[header.icon]" :color="props.item[header.color]" left>
                      <template slot="badge">
                        <v-tooltip top>
                          <template v-slot:activator="{ on }">
                            <v-icon dark small v-on="on">{{ props.item[header.icon] }}</v-icon>
                          </template>
                          {{ props.item[header.iconTooltip] }}
                        </v-tooltip>
                      </template>
                      {{ props.item[header.value] }}
                      <div
                        v-if="props.item[header.subheader]"
                        class="caption grey--text"
                      >{{ props.item[header.subheader] }}</div>
                      <div
                        v-if="props.item[header.subheader2]"
                        class="caption grey--text"
                      >{{ props.item[header.subheader2] }}</div>
                    </v-badge>
                    <div v-else>
                      <span
                        v-html="props.item[header.value] ? props.item[header.value].replace(/(?:\r\n|\r|\n)/g, '<br>') : ''"
                      ></span>
                      <div
                        v-if="props.item[header.subheader]"
                        class="caption grey--text"
                      >{{ props.item[header.subheader] }}</div>
                      <div
                        v-if="props.item[header.subheader2]"
                        class="caption grey--text"
                      >{{ props.item[header.subheader2] }}</div>
                    </div>
                  </div>
                </td>
              </tr>
            </template>

            <template slot="footer">
              <td v-if="imprimir" colspan="2">
                <v-btn @click="print">
                  <v-icon>print</v-icon>Imprimir
                </v-btn>
              </td>
              <td :colspan="headers.length - 2">
                <slot name="footer"></slot>
              </td>
            </template>

            <v-alert
              slot="no-results"
              :value="true"
              color="error"
              icon="warning"
            >Sua busca por "{{ search }}" não retornou resultados.</v-alert>
          </v-data-table>

          <v-card-actions>
            <v-container>

                <v-row  v-if="paginationInfo" align="center" justify="center">    
                  <v-col xs="12" md="8" class="text-center caption">
                    {{ paginationInfo }}
                  </v-col>
                </v-row>
                <!--
                <v-row align="center" justify="center">
                    
                    <v-col xs="12" md="8" class="text-center caption">
                        {{ options.total == 0 
                          ? 'Nenhum registro' 
                          : ( options.total == 1
                            ? "Exibindo o único registro" 
                            : "Exibindo registros de " + options.from + " a " + options.to + " do total de " + options.total) }}
                        {{ options.total <= 1 
                          ? ' encontrado'
                          : ' encontrados'}}
                        {{ (options.search.length > 0) 
                          ? " para a pesquisa por '" + options.search + "'" 
                          : "" }}.
                    </v-col>
                </v-row>
                -->
                <v-row align="center" justify="center">
                    <v-col xs="12" md="2">
                        <div class="v-data-footer">Registros por página:</div>
                    </v-col>
                    <v-col xs="12" md="1">
                        <v-select
                        :items="options.itemsPerPageOptions"
                        :value="options.itemsPerPage"
                        @input="paginationPerPageValuedChanged"
                        dense light />
                    </v-col>
                    <v-col xs="9">
                        <div class="v-data-footer__select">
                        <v-pagination
                            v-if="options"
                            :value="options.current_page"
                            :length="options.last_page"
                            total-visible="7"
                            @input="paginationPageValueChanged"
                        />
                        </div>
                    </v-col>
                </v-row>
            </v-container>
          </v-card-actions>
        </v-card>
      </v-flex>
      <v-flex xs12 v-else fill-height transition="slide-x-transition">
        <v-form v-model="valid">
          <v-card>
            <v-card-title>
              <v-toolbar-title>{{ (entidade.id == null ? verboAdicionarEntidade : verboAlterarEntidade) + ' ' + nomeEntidade }}</v-toolbar-title>
              <v-divider class="mx-2" inset vertical></v-divider>
              <v-spacer></v-spacer>
              <slot name="topFormArea"></slot>
              <v-spacer></v-spacer>
              <v-btn @click="cancelar">
                <v-icon>arrow_back</v-icon>Voltar
              </v-btn>
            </v-card-title>
            <v-container>
              <slot name="detalhe"></slot>
            </v-container>
            <v-card-actions>
              <v-spacer></v-spacer>
              <v-btn color="grey ligthen" @click="cancelar">
                <v-icon>arrow_back</v-icon>Voltar
              </v-btn>
              <slot name="beforeSaveButton"></slot>
              <v-btn color="primary" @click="salvar" :disabled="!valid || !podeSalvar">
                <v-icon>save_alt</v-icon>Salvar
              </v-btn>
            </v-card-actions>
          </v-card>
        </v-form>
      </v-flex>
    </v-layout>
  </v-container>
</template>

<script>
export default {
  data: () => {
    return {
      exibirGrid: true,
      entidade: { id: null },
      search: "",
      searchFocused: false,
      selected: [],
      valid: false,

      options: {
        search: "",
        current_page: 1,
        itemsPerPage: 10,
        ascending: true,
        itemsPerPageOptions: [
          10,
          25,
          50,
          100,
          200,
          { text: "Todos", value: -1 }
        ]
      },
      paginationInfo: '',

      filteredItems: [],
      columnFilters: [],
      columnFilterProperties: [],

      items: [],
      carregando: false,

      // remover
      buscaPaginada: null,
      page: null,
      filtro: "",
      ordem: "0",
      pesquisa: "",
      filtrar: ""
    };
  },
  props: {
    exibirPrimeiraTela: {
      type: Boolean,
      default: true
    },

    voltarParaPrimeiraTelaAoSalvar: {
      type: Boolean,
      default: true
    },

    nomeEntidade: String,

    nomeEntidadePlural: String,

    verboAdicionarEntidade: {
      type: String,
      default: "Cadastrar"
    },

    verboAlterarEntidade: {
      type: String,
      default: "Editar"
    },

    headers: {
      type: Array,
      required: true
    },

    imprimir: {
      type: Boolean,
      default: false
    },

    podeSalvar: {
      type: Boolean,
      default: true
    },

    "resource-url": {
      type: String,
      required: true
    },
    "item-key": {
      type: String,
      required: true
    },
    "for-each-item-callback": {
      type: Function
    }
  },

  methods: {
    clicouItem(item) {
      this.entidade = item;
      this.$emit("clicou-item", item);
      this.exibirGrid = false;
    },
    cadastrarNovo() {
      (this.entidade = { id: null }), this.$emit("clicou-novo");
      this.exibirGrid = false;
    },
    salvar() {
      this.$emit("clicou-salvar");
      if (this.voltarParaPrimeiraTelaAoSalvar) {
        this.exibirGrid = true;
      }
    },
    cancelar() {
      this.$emit("clicou-cancelar");
      this.exibirGrid = true;
    },

    print() {
      this.$emit("clicou-imprimir", this.selected);
    },

    formatDate(date) {
      if (!date) return null;

      const [year, month, day] = date.split("-");
      return `${day}/${month}/${year}`;
    },
    
    estiloDaColuna(cabecalhoColuna) {
      let estilo = "cursor: pointer; ";
      if (cabecalhoColuna.type == "hidden") {
        estilo = estilo + "display: none; ";
        estilo = estilo + "width: 0px; ";
      }
      return estilo;
    },

    toggleSort(index) {
      if(this.headers[index].sortable) {
        let sortByColumnChanged = this.setSortByColumn(index)
        if(sortByColumnChanged) {
            this.options.ascending = true
        } else {
            this.options.ascending = !this.options.ascending;
        }
  
        this.loadItems();
      }
    },

    setSortByColumn(index) {
        let newSortedColumn = this.headers[index].value
        let sortByColumnChanged = this.options.order != newSortedColumn
        this.options.order = newSortedColumn
        return sortByColumnChanged
    },

    initialize() {
      this.setSortByColumn(0)
      this.loadItems();
    },

    getRequestQuery() {
      // console.log("getRequestQuery", this.options);
      this.options.current_page = this.options.current_page
        ? this.options.current_page
        : 1;

      let firstOp = this.resourceUrl.includes("?") ? "&" : "?"
      let parametros = firstOp + "page=" + this.options.current_page;

      this.options.per_page = this.options.per_page ? this.options.per_page : 10;
      parametros += "&per_page=" + this.options.per_page;

      if(this.options.order) {
          parametros += "&order=" + this.options.order
      }

      parametros += "&ascending=" + (this.options.ascending ? "true" : "false");

      if(this.options.search) {
          parametros += "&search=" + this.options.search
      }

      return parametros;
    },

    async loadItems() {
      // console.log("CRUD.loadItems()");
      let parametros = this.getRequestQuery();
      let url = this.resourceUrl + parametros;
      // console.log(url);

      this.items = [];
      this.$http.get(url).then(
        response => {
          // console.log(response.body)
          this.fillPagination(response.body);
          response.body.data.forEach((element, e) => {
              if(this.forEachItemCallback) {
                element = this.forEachItemCallback(element)
              }
            this.items.push(element);
          })
          // this.buscaPaginada.atualizar(response.body)
          this.carregando = false;
        },
        error => {
          this.carregando = false;
          console.log(error);
        }
      );
    },

    fillPagination(apiResponse) {
      // console.log("CRUD.fillPagination()", apiResponse);
      this.options.current_page = apiResponse.current_page;
      this.options.last_page = apiResponse.last_page;
      this.options.from = Number.parseInt(apiResponse.from)
      this.options.to = Number.parseInt(apiResponse.to)
      this.options.total = Number.parseInt(apiResponse.total);

      this.options.itemsPerPage = Number.parseInt(apiResponse.per_page)

      Vue.nextTick(this.updatePaginationInfo)
    },

    paginationPageValueChanged(newPage) {
      // console.log("paginationPageValueChanged", newPage);
      this.options.current_page = newPage;
      this.loadItems();
    },

    paginationPerPageValuedChanged(newPerPage) {
      // console.log("paginationPerPageValuedChanged", newPerPage);
      this.options.per_page = newPerPage;

      let paginas = Math.floor(this.options.total / this.options.per_page);
      paginas = paginas + (this.options.total % this.options.per_page > 0 ? 1 : 0);
      if (this.options.current_page > paginas) {
        this.options.current_page = paginas;
      }

      this.loadItems();
    },

    searchMessage() {
        if(this.search == null || this.search == this.options.search) {
            return null
        }
        if(this.searchFocused) {
            return "Pressione ENTER para realizar a pesquisa"
        } else {
            return "Clique na lupa para realizar a pesquisa"
        }
    },

    resetPagination() {
      this.options.current_page = 1
      this.options.last_page = 1
      this.options.total = 0
    },

    doSearch() {
        this.resetPagination()
        this.options.search = this.search
        this.loadItems();
    },
    updatePaginationInfo: function() {
      let info = ''
      if(this.items == null || this.items.last_page == 0 || this.options.total == 0) {
        info = 'Nenhum registro encontrado'
      } else {
        if(this.items.length == 1 || this.options.total == 1) {
          info = 'Exibindo o único registro encontrado'
        } else {
          info = 'Exibindo registros de ' + this.options.from + ' a ' + this.options.to + ' do total de ' + this.options.total + ' encontrados'
        }
      }
      if(this.options.search != null && this.options.search != '') {
        info = info + ' para a pesquisa por "' + this.options.search + '"'
      }
      this.paginationInfo = info + "."

    }

  },
  watch: {
    exibirPrimeiraTela: function(val) {
      // console.log("CRUD.watch:exibirPrimeiraTela", val);
      this.exibirGrid = val;
    },

    valid: function(val) {
      // console.log("CRUD.watch:valid", val);
      this.$emit("validou-formulario", val);
    },

    exibirGrid: function(val) {
      // console.log("CRUD.watch:exibirGrid", val);
      this.$emit("modou-tela", val);
    },

    resourceUrl: function(val) {
      console.log("CRUD.watch:resourceUrl", val);
      this.loadItems()
    },

    "options.total": function(val, oldVal) {
      console.log("CRUD.watch:options", val, oldVal);
      this.updatePaginationInfo()
    }
    

  },

  mounted() {
    if (this.$route.params.id) {
      this.exibirGrid = false;
    }
    this.initialize();
  }
};
</script>

<style>
.hidden {
  display: none;
}
</style>

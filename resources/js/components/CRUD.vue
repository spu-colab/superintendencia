<template>
  <v-container fill-height fluid>
    <v-layout row wrap>
      <v-flex xs12 fill-height v-if="exibirGrid" transition="slide-x-reverse-transition">
        <v-card>
          <v-card-title>
            <v-toolbar-title>{{ nomeEntidadePlural }}</v-toolbar-title>
            <v-divider class="mx-2" inset vertical></v-divider>
            <v-spacer></v-spacer>
            <v-text-field
              v-model="search"
              append-icon="search"
              label="Buscar"
              single-line
              hide-details
            ></v-text-field>
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
            :items="filteredItems"
            :search="search"
            v-model="selected"
            :sort-by="pagination.sortBy"
            :descending="pagination.descending" 
            show-select
            item-key="id"
            :loading="carregando"
            :hide-default-header="false"
            :hide-default-footer="!exibirPaginacao"
            :footer-props="footerProps"
          >
            <v-progress-linear slot="progress" color="blue" indeterminate></v-progress-linear>

            <template slot="body.prepend">
              <tr>
                <th></th>
                <th
                  v-for="(header, index) in headers"
                  :key="index"
                  :style="estiloDaColuna(header)"
                  role="columnheader"
                >
                  <h4 v-if="header.type == 'filter'">
                    <v-layout align-center row fill-height>
                      <v-autocomplete
                        label=""
                        tabindex="2"
                        clearable
                        :items="computedColumnFilterItems(index, header.value)"
                        v-model="columnFilters[index]"
                      ></v-autocomplete>
                    </v-layout>
                  </h4>
                </th>
              </tr>
            </template>

            <template slot="item" slot-scope="props">
              <tr>
                <td>
                  <v-checkbox v-model="props.selected" primary hide-details></v-checkbox>
                </td>
                <td v-for="(header, index2) in headers" :key="index2"
                  :style="estiloDaColuna(header)"
                  v-on:click="clicouItem(props.item)"
                  :class="header.type == 'hidden' ? 'hidden' : ''">

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
                    <v-chip v-for="(chip, chipIndex) in props.item[header.value]" :key="chipIndex" small>
                      <small>{{ chip.value }}</small>
                    </v-chip>
                  </div>

                  <!-- date -->
                  <div v-else-if="header.type == 'date'">
                    <v-badge v-if="props.item[header.icon]" :color="header.color">
                      <template slot="badge">
                        <v-tooltip top>
                          <template slot="activator">
                            <v-icon dark small>{{ props.item[header.icon] }}</v-icon>
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
                          <template slot="activator">
                            <v-icon dark small>{{ props.item[header.icon] }}</v-icon>
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
      selected: [],
      valid: false,

      footerProps: {
        itemsPerPageText : "Registros por página",
        itemsPerPageOptions : [50, 100, 200, { text: "Todos", value: -1 }]
      },

      pagination: {
        descending: true
      },
      filteredItems: [],
      columnFilters: [],
      columnFilterProperties: [],
    };
  },
  props: {
     exibirPrimeiraTela: {
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

    items: {
      type: Array,
      required: true
    },
    exibirPaginacao: {
      type: Boolean,
      default: true
    },
    imprimir: {
      type: Boolean,
      default: false
    },
    carregando: {
      type: Boolean,
      default: true
    },
    podeSalvar: {
      type: Boolean,
      default: true
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
      // this.exibirGrid = true;
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
    computedColumnFilterItems(index, valueProperty) {
      // console.log(index + ': ' + valueProperty)
      this.columnFilterProperties[index] = valueProperty;
      let filterItems = new Array();
      if (Array.isArray(this.$props.items)) {
        // console.log(this.$props.items)
        this.$props.items.forEach(item => {
          if (!filterItems.includes(item[valueProperty])) {
            filterItems.push(item[valueProperty]);
          }
        });
      }
      return filterItems.sort();
    }
  },
  watch: {
    items: function() {
      this.columnFilters = this.columnFilters.slice(0);
    },

    exibirPrimeiraTela: function(val) {
      this.exibirGrid = val
    },

    valid: function(val) {
      this.$emit("validou-formulario", val);
    },

    exibirGrid: function(val) {
      // console.log('CRUD emitiu mudou-tela com val = ' + val)
      this.$emit("modou-tela", val);
    },

    columnFilters: function(columnFilters) {
      // console.log(columnFilters)
      this.filteredItems = this.$props.items.filter(item => {
        var coluna;
        for (coluna = 0; coluna < columnFilters.length; coluna++) {
          if (columnFilters[coluna] && columnFilters[coluna] !== undefined) {
            if (
              item[this.columnFilterProperties[coluna]] !==
              columnFilters[coluna]
            ) {
              return false;
            }
          }
        }
        return true;
      });
    }
  },

  mounted() {
    if (this.$route.params.id) {
      this.exibirGrid = false;
    }
  }
};
</script>

<style>
.hidden {
  display: none;
}
</style>

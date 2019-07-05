<template>
  <v-container fill-height fluid>
    <v-layout row wrap>
      <v-flex xs12 fill-height v-if="exibirGrid"  transition="slide-x-reverse-transition">
        <v-card>
          <v-card-title>
            <v-toolbar-title>{{ nomeEntidadePlural }}</v-toolbar-title>
            <v-divider
              class="mx-2"
              inset
              vertical
            ></v-divider>
            <v-spacer></v-spacer>
            <v-text-field
              v-model="search"
              append-icon="search"
              label="Buscar"
              single-line
              hide-details
            ></v-text-field>
            <v-spacer></v-spacer>
            <v-divider
              class="mx-2"
              inset
              vertical
            ></v-divider>
            <v-flex>
              <slot name="beforeAdd">
              </slot>
            </v-flex>
            <v-spacer></v-spacer>
            <v-btn color="primary" dark class="mb-2" @click="cadastrarNovo">
              <v-icon>add</v-icon>
              CADASTRAR {{ nomeEntidade }}</v-btn>
            <v-container>
                <v-layout row wrap>  
                </v-layout>
            </v-container>
          </v-card-title>

            <slot name="beforeTable">
            </slot>
          
          <v-data-table :headers="headers" :items="filteredItems" :search="search"
            v-model="selected" select-all item-key="id" 
            :loading="carregando" :pagination.sync="pagination"
            :hide-actions="!exibirPaginacao"
            :rows-per-page-items="registrosPorPagina()" rows-per-page-text="Registros por página">
            <v-progress-linear slot="progress" color="blue" indeterminate></v-progress-linear>

            <template slot="headers" slot-scope="props">
              <tr>
                <th></th>
                <th v-for="(header, index) in headers" :key="index" 
                  :style="estiloDaColuna(header)" 
                  role="columnheader" @click="toggleSort(index)">
                  <h4 v-if="header.type == 'filter'">
                    <v-layout align-center row fill-height>
                      
                        <v-autocomplete :label="header.text" tabindex="2" clearable 
                          :items="computedColumnFilterItems(index, header.valueProperty)" v-model="columnFilters[index]" 
                        >
                        </v-autocomplete>
                        <v-icon small :color="colunaSelecionadaOrdenacao(index) ? 'blue' : 'gray'">
                          {{ setaOrdenacaoColuna(index) }}
                        </v-icon>
                      
                    </v-layout>
                  </h4>
                  <v-card-text v-else>
                    {{ header.text }}
                    <v-icon small :color="colunaSelecionadaOrdenacao(index) ? 'blue' : 'gray'">
                      {{ setaOrdenacaoColuna(index) }}
                    </v-icon>
                  </v-card-text>
                </th>
              </tr>
            </template>

            <template slot="items" slot-scope="props">
              <td>
                <v-checkbox
                  v-model="props.selected"
                  primary
                  hide-details
                ></v-checkbox>
              </td>
              <td v-for="header in headers" :key="header.value" :style="estiloDaColuna(header)" @click="clicouItem(props.item)" :class="header.type == 'hidden' ? 'hidden' : ''"> 
                  <!-- hidden -->
                  <div v-if="header.type == 'hidden'">
                  </div>

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
                    <v-chip v-for="chip in props.item[header.value]" :key="chip.id" small>
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
                        <div v-if="props.item[header.subheader]" class="caption grey--text">
                            {{ props.item[header.subheader] }}
                        </div>
                        <div v-if="props.item[header.subheader2]" class="caption grey--text">
                            {{ props.item[header.subheader2] }}
                        </div>
                    </v-badge>
                    <div v-else>
                      {{ props.item[header.value] }}
                      <div v-if="props.item[header.subheader]" class="caption grey--text">
                          {{ props.item[header.subheader] }}
                      </div>
                      <div v-if="props.item[header.subheader2]" class="caption grey--text">
                            {{ props.item[header.subheader2] }}
                        </div>
                    </div>
                  </div>
              </td>
            </template>

            <template slot="footer">
              <td :colspan="headers.length">
                <slot name="footer">
                </slot>
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
              <v-toolbar-title>{{ (entidade.id == null ? 'Cadastrar ' : 'Editar ') + nomeEntidade }}</v-toolbar-title>
              <v-divider
                class="mx-2"
                inset
                vertical
              ></v-divider>
              <v-spacer></v-spacer>
              <v-btn @click="cancelar">
                <v-icon>arrow_back</v-icon> Voltar</v-btn>
            </v-card-title>
            <v-container>
              <slot name="detalhe">
              </slot>
            </v-container>
            <v-card-actions>
              <v-spacer></v-spacer>
              <v-btn color="grey ligthen" @click="cancelar">
                <v-icon>arrow_back</v-icon> Voltar</v-btn>
              <slot name="beforeSaveButton">
              </slot>
              <v-btn color="primary" @click="salvar" 
                :disabled="!valid || !podeSalvar"
                >
                <v-icon>save_alt</v-icon> Salvar</v-btn>
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
      pagination: {
      },
      exibirGrid: true,
      entidade: { id: null },
      search: '',
      selected: [],
      valid: false,
      filteredItems: [],
      columnFilters: [],
      columnFilterProperties: []
    };
  },
  props: {
      nomeEntidade: String, 
      nomeEntidadePlural: String,
      headers: Array,
      items: Array,
      exibirPaginacao: {
        type: Boolean,
        default: true
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
      this.entidade = item
      this.$emit('clicou-item', item);
      this.exibirGrid = false;
    },
    cadastrarNovo() {
      this.entidade = { id: null },
      this.$emit('clicou-novo')
      this.exibirGrid = false;
    },
    salvar() {
      this.$emit('clicou-salvar')
      // this.exibirGrid = true;
    },
    cancelar() {
      this.$emit('clicou-cancelar')
      this.exibirGrid = true;
    },
    registrosPorPagina() {
      return [50,100,200,{"text":"Todos","value":-1}]
    },
    formatDate (date) {
        if (!date) return null

        const [year, month, day] = date.split('-')
        return `${day}/${month}/${year}`
    },
    estiloDaColuna(cabecalhoColuna) {
      let estilo = 'cursor: pointer; '
      if(cabecalhoColuna.type == 'hidden') {
        estilo = estilo + 'display: none; '
        estilo = estilo + 'width: 0px; '
      }
      return estilo
    },
    toggleSort(index) {
      this.pagination.descending = !this.pagination.descending
      this.pagination.sortBy = this.headers[index].value
    },
    setaOrdenacaoColuna(index) {
      // console.log(index)
      // console.log(this.pagination.sortBy)
      // console.log(this.headers[index].value)
      if(this.pagination.sortBy == this.headers[index].value) {
        return this.pagination.descending ? 'arrow_downward' : 'arrow_upward';
      }
      return 'arrow_upward'
    },
    colunaSelecionadaOrdenacao(index) {
      return this.pagination.sortBy == this.headers[index].value
    },

    computedColumnFilterItems(index, valueProperty) {
      this.columnFilterProperties[index] = valueProperty
      let filterItems = new Array()
      if(Array.isArray(this.$props.items)) {
        var i;
        for(i = 0; i < this.$props.items.length; i++) {
          let item = this.$props.items[i]
          if(!filterItems.includes(item[valueProperty])) {
            filterItems.push(item[valueProperty])
          }
        }
      }
      return filterItems.sort()
    },
  },
  watch: {

    items: function (val) {
      this.columnFilters = this.columnFilters.slice(0)
    },
    
    columnFilters: function (columnFilters) {
      // console.log(columnFilters)
      this.filteredItems = this.$props.items.filter(item => {
        var coluna;
        for(coluna = 0;coluna < columnFilters.length; coluna++) {
          if(columnFilters[coluna] && columnFilters[coluna] !== undefined) {
            if (item[this.columnFilterProperties[coluna]] !== columnFilters[coluna]) {
              return false
            }
          }
        }
        return true
      })
    }

  },

  computed: {
  },

  mounted() {
    if(this.$route.params.id) {
      this.exibirGrid = false
    }
  }
};
</script>

<style>
.hidden {
  display: none;
}
</style>

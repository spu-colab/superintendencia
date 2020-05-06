<template>
  <v-container fill-height fluid>
    <v-layout row wrap>
      <v-flex xs12 fill-height v-if="exibirGrid" transition="slide-x-reverse-transition">
        <v-card>
          <v-card-title>
            <v-toolbar-title>{{ nomeEntidadePlural }}</v-toolbar-title>
            <v-divider class="mx-2" inset vertical></v-divider>
            <v-spacer></v-spacer>
            <v-select style="width: 70px; margin: 0 auto"
              :items="anoPostagem"
              v-model="anoSelectAtual"
              label="Ano da Postagem"  
              hide-details              
            ></v-select>
            <v-spacer></v-spacer>   
            <v-select style="width: 100px; margin: 0 auto"
              :items="tipoDocumento"
              v-model="tipoSelectAtual"
              label="Tipo"  
              hide-details              
            ></v-select>
            <v-spacer></v-spacer>   
            <v-select style="width: 100px; margin: 0 auto"
              :items="setores"
              v-model="setorSelectAtual"
              label="Setor de Origem"                
              hide-details
            ></v-select>
            <v-spacer></v-spacer>      
            <v-text-field 
              v-if="exibirPaginacaoCliente"
              v-model="search"
              append-icon="search"
              label="Buscar"
              single-line
              hide-details
            ></v-text-field>             
            <v-text-field 
              v-if="!exibirPaginacaoCliente"
              style="width: 250px; margin: 0 auto"
              v-model="pesquisa"
              :append-outer-icon="filtro ? 'highlight_off' : 'search'"
              :color="filtro ? 'red' : 'blue'"
              :background-color="filtro ? 'blue lighten-5' : ''"              
              @click:append-outer="tratarFiltro"
              @keyup.enter="tratarFiltro"
              :label="filtro ? 'Exibindo resultados para - '+ filtro : 'Pesquisar na Base de Dados'" 
              :readonly="filtro ? true : false"
              single-line
              hide-details
            ></v-text-field> 
            <v-divider class="mx-2" inset vertical></v-divider>
            <v-flex>
              <slot name="beforeAdd"></slot>
            </v-flex>
              <v-btn color="green" dark class="mb-2" @click="receberApoio">
                <v-icon>add</v-icon>
                Postagens
              </v-btn>

            <slot name="addButtonArea">
              <v-btn color="primary" dark class="mb-2" @click="cadastrarNovo">
                <v-icon>add</v-icon>
                {{ verboAdicionarEntidade}} {{ nomeEntidade }}
              </v-btn>
            </slot>
          </v-card-title>

          <slot name="beforeTable"></slot>

          <v-data-table     
            :dense="true"
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
            :hide-default-footer="!exibirPaginacaoCliente"
            :footer-props="footerProps"
          >
            <v-progress-linear slot="progress" color="blue" indeterminate></v-progress-linear>

            <template v-if="textHeader" slot="headers" slot-scope="props">
              <tr>
                <th ></th>
                <th
                  v-for="(header, index) in headers"
                  :key="index"
                  :style="header.text== 'id' ? '' :estiloDaColuna(header)"
                  role="columnheader"
                  @click="toggleSort(index)"
                >
                  <h4 v-if="header.type == 'filter'">
                    <v-layout align-center row fill-height>
                      <v-autocomplete
                        :label="header.text"
                        tabindex="2"
                        clearable
                        :items="computedColumnFilterItems(index, header.valueProperty)"
                        v-model="columnFilters[index]"
                      ></v-autocomplete>
                      <v-icon
                        small
                        :color="colunaSelecionadaOrdenacao(index) ? 'blue' : 'gray'"
                      >{{ setaOrdenacaoColuna(index) }}</v-icon>
                    </v-layout>
                  </h4>
                  <v-card-text v-else-if="header.text == 'id'" hidden style="cursor: auto;">
                    {{ header.text }}
                    <v-icon
                      small
                      :color="colunaSelecionadaOrdenacao(index) ? 'blue' : 'gray'"
                    >{{ setaOrdenacaoColuna(index) }}</v-icon>
                  </v-card-text>
                  <v-card-text v-else>
                    {{ header.text }}
                    <v-icon
                      small
                      :color="colunaSelecionadaOrdenacao(index) ? 'blue' : 'gray'"
                    >{{ setaOrdenacaoColuna(index) }}</v-icon>
                  </v-card-text>
                </th>
              </tr>
            </template>

            <template slot="items" slot-scope="props" :dense="true">
              <tr>
              <td >
                <v-checkbox  v-if="imprimir" v-model="props.selected" primary hide-details></v-checkbox>
              </td>
              <td
                v-for="header in headers"                
                :key="header.value"
                :style="estiloDaColuna(header)"
                @click="clicouItem(props.item)"
                :class="header.type == 'hidden' ? 'hidden' : header.class"
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
                    <div
                      v-if="props.item[header.subheader]"
                      class="caption grey--text"
                    >{{ props.item[header.subheader] }}</div>
                    <div
                      v-if="props.item[header.subheader2]"
                      class="caption grey--text"
                    >{{ props.item[header.subheader2] }}</div>
                  </v-badge>
                  <div v-else-if ="header.text != 'id'">
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
              <td>
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
          <paginador v-if="!exibirPaginacaoCliente" :pgCorrente="paginaCorrente" :pagina="paginas" :filtro="filtro" :ordem="ordem" :ascending="ascending" @mudaPagina="mudaPagina"/> 
        </v-card>
      </v-flex>
      <v-flex xs12 v-else fill-height transition="slide-x-transition">
        <v-form v-model="valid">
          <v-card>
            <v-card-title>
              <v-toolbar-title>{{ (entidade.id == null ? verboAdicionarEntidade : verboConsultarEntidade) + ' ' + nomeEntidade }}</v-toolbar-title>
              <v-divider class="mx-2" inset vertical></v-divider>
              <v-spacer></v-spacer>
              <slot name="topFormArea"></slot>
              <v-spacer></v-spacer>
              <v-btn @click="cancelar">
                <v-icon>arrow_back</v-icon>Voltar
              </v-btn>
            </v-card-title>
            <v-container v-if="exibirItem" fluid>
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
      exibirItem: false,
      footerProps: {
        itemsPerPageText : "Registros por página",
        itemsPerPageOptions : [50, 100, 200, { text: "Todos", value: -1 }]
      },
      pagination: {
        descending: true
      },
      entidade: { id: null },
      search: "",
      setorSelectAtual:null,
      anoSelectAtual:null,
      tipoSelectAtual:null,
      selected: [],
      valid: false,
      filteredItems: [],
      columnFilters: [],
      columnFilterProperties: [],
      page:null,
      filtro:'',
      ordem:'0',
      ascending:[true],
      pesquisa: "",
      filtrar:"",
    };
  },
  props: {
    setores:Array,
    anoPostagem:Array,
    tipoDocumento:Array,
    descartar:Boolean,
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
    verboConsultarEntidade: {
      type: String,
      default: "Controle de "
    },
    headers: Array,
    items: Array,
    exibirPaginacaoCliente: {
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
    },
    setorSelect:null,
    anoSelect:null,
    tipoSelect:null,
    textHeader: {
      type: Boolean,
      default: true
    },
    paginas:{},
    paginaCorrente:null,
  },
  methods: {
    descartarItem(item){
      if (confirm("Deseja Descartar Este Item?")){
        this.$emit("descartarItem", item);
      }
    },

    clicouItem(item) {
      this.entidade = item;
      this.$emit("clicou-item", item);
      this.exibirGrid = false;
      this.exibirItem = true;
    },
    receberApoio(){
      this.exibirGrid = false;
      this.exibirItem = true;
      this.$emit("clicou-postar");
    },
    cadastrarNovo() {
      (this.entidade = { id: null }), this.$emit("clicou-novo");
      this.exibirGrid = false;
      this.exibirItem = true;
    },
    salvar() {
      this.exibirGrid = false;
      this.$emit("clicou-salvar");
    },
    cancelar() {
      this.$emit("clicou-cancelar");
      this.exibirGrid = true;
      this.exibirItem = false;

    },
    print() {
      this.$emit("clicou-imprimir", this.selected);
    },
    registrosPorPagina() {
      return [50, 100, 200, { text: "Todos", value: -1 }];
    },
    setorSel(event){
        console.log("entrei setorSel " +  event.target.value);
    },
    anoSel(event){
        console.log("entrei anoSel " +  event.target.value);
    },
    tratarFiltro(){
      if (this.filtro && this.filtro.trim().length>0){
        this.filtro = '';
        this.pesquisa = null;
        this.$emit('mudaPagina',[1, this.paginas.per_page, '', this.ordem, this.ascending]);
      }
      else
      if (this.pesquisa && this.pesquisa.trim().length>0){
        this.$emit('mudaPagina',[1, this.paginas.per_page, this.pesquisa, this.ordem, this.ascending]);
        this.filtro = this.pesquisa;
        this.pesquisa = null;
      }      
    },
    mudaPagina(page){  
      this.$emit('mudaPagina',page)
    },
    formatDate(date) {
      if (!date) return null;

      const [year, month, day] = date.split("-");
      return `${day}/${month}/${year}`;
    },
    estiloDaColuna(cabecalhoColuna) {
      let estilo = "cursor: pointer;";
      if (cabecalhoColuna.type == "hidden") {
        estilo = estilo + "display: none; ";
        estilo = estilo + "width: 0px; ";
      }
      return estilo;
    },
    toggleSort(index) {
      this.pagination.descending = !this.pagination.descending;
      this.pagination.sortBy = this.headers[index].value;
      if (!this.exibirPaginacaoCliente){
        if( this.ordem != index){
          this.pagination.descending = false;
          this.ascending[index] = false;
        }
        this.ordem = index;
        this.ascending[index] = !this.ascending[index];
        this.$emit('mudaPagina',['1', this.paginas.per_page, this.filtro, this.ordem, this.ascending[index]]); 
      }
    },
    setaOrdenacaoColuna(index) {
      // console.log(index)
      // console.log(this.pagination.sortBy)
      // console.log(this.headers[index].value)
      if (this.pagination.sortBy == this.headers[index].value) {
        return this.pagination.descending ? "arrow_downward" : "arrow_upward";
      }
      return "arrow_upward";
    },
    colunaSelecionadaOrdenacao(index) {
      return this.pagination.sortBy == this.headers[index].value;
    },

    computedColumnFilterItems(index, valueProperty) {
      this.columnFilterProperties[index] = valueProperty;
      let filterItems = new Array();
      if (Array.isArray(this.$props.items)) {
        var i;
        for (i = 0; i < this.$props.items.length; i++) {
          let item = this.$props.items[i];
          if (!filterItems.includes(item[valueProperty])) {
            filterItems.push(item[valueProperty]);
          }
        }
      }
      return filterItems.sort();
    }
  },
  watch: {
    setorSelectAtual: function(val){
      var index = this.ordem;
      this.$emit('mudaAnoSetor',
        ['1', this.paginas.per_page, this.filtro, this.ordem, this.ascending[index], this.setorSelectAtual, this.anoSelectAtual, this.tipoSelectAtual]); 
    },
    setorSelect: function(val){
      this.setorSelectAtual = this.setorSelect;
    },
    anoSelectAtual: function(val){
      var index = this.ordem;
      this.$emit('mudaAnoSetor',
        ['1', this.paginas.per_page, this.filtro, this.ordem, this.ascending[index], this.setorSelectAtual, this.anoSelectAtual, this.tipoSelectAtual ]); 

    },
    anoSelect: function(val){
      this.anoSelectAtual = this.anoSelect;
    },
    tipoSelectAtual: function(val){
      var index = this.ordem;
      this.$emit('mudaAnoSetor',
        ['1', this.paginas.per_page, this.filtro, this.ordem, this.ascending[index], this.setorSelectAtual, this.anoSelectAtual, this.tipoSelectAtual]); 

    },
    tipoSelect: function(val){
      this.tipoSelectAtual = this.tipoSelect;
    },

    items: function(val) {
      this.columnFilters = this.columnFilters.slice(0);
    },

    exibirPrimeiraTela: function(val) {
      console.log('mudou prim '+ val);
      this.exibirGrid = val;
    },

    valid: function(val) {
      this.$emit("validou-formulario", val);
    },

    exibirGrid: function(val) {
      // console.log('CRUD emitiu mudou-tela com val = ' + val)
      console.log('mudou grid '+ val);
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

  computed: {},
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

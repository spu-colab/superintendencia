<template>
    <v-container fluid fill-height id="caixaSelecao">
        <v-layout row wrap align-center>
            <v-flex xs12 md5 class="flexSelecao">
                <h4>Disponíveis</h4>
                <v-divider/>
                <v-card class="d-inline-block mx-auto cardSelecao" >
                    <section id="disponiveis">
                        <select  class="itemDisponivel"  multiple  >
                            <option
                                v-for="(item) in selecionados(false)" 
                                v-bind:value="item.id"
                                v-bind:key="item.id">
                                {{item.nome}}
                            </option>
                        </select>
                    </section>
                </v-card>                
            </v-flex>
            <v-flex xs12 md1>                
                <p  class="pSelecao" v-if ="!window_estreita">
                    <button type="button">
                        <v-icon v-on:click="alteraSelecao('itemDisponivel')">keyboard_arrow_right</v-icon>
                    </button>
                </p>
                <p class="pSelecao" v-if ="!window_estreita && !marcaDisponiveis">
                    <button type="button">
                        <v-icon v-on:click="marcaSelecao('itemDisponivel','selected',true);">check_box_outline_blank</v-icon>
                    </button>                    
                </p>
                <p class="pSelecao" v-if ="!window_estreita  && marcaDisponiveis"  >
                    <button type="button">
                        <v-icon v-on:click="marcaSelecao('itemDisponivel','',false)">check_box</v-icon>
                    </button>                    
                </p>
                <p class="pSelecao" align="center" v-if ="window_estreita">
                    <button v-if ="!marcaDisponiveis" type="button">
                        <v-icon v-on:click="marcaSelecao('itemDisponivel','selected',true)">check_box_outline_blank</v-icon>
                    </button>                    
                    <button v-if ="marcaDisponiveis" type="button">
                        <v-icon v-on:click="marcaSelecao('itemDisponivel','',false)">check_box</v-icon>
                    </button>                    
                    <button type="button">
                        <v-icon v-on:click="alteraSelecao('itemDisponivel');">keyboard_arrow_down</v-icon>                        
                    </button>
                </p>
            </v-flex>
            <v-flex xs12 md1>                
                <p class="pSelecao" align="right" v-if ="!window_estreita">
                    <button type="button">
                        <v-icon v-on:click="alteraSelecao('itemSelecionado');">keyboard_arrow_left</v-icon>
                    </button>         
                </p>
                <p class="pSelecao" align="right" v-if ="!window_estreita && ! marcaSelecionados">
                    <button type="button">
                        <v-icon v-on:click="marcaSelecao('itemSelecionado','selected',true)">check_box_outline_blank</v-icon>
                    </button>                    
                </p>
                <p class="pSelecao" align="right" v-if ="!window_estreita  && marcaSelecionados">
                    <button type="button">
                        <v-icon v-on:click="marcaSelecao('itemSelecionado','',false)">check_box</v-icon>
                    </button>                    
                </p>
                <v-divider class= "dividerSelecao" v-if ="window_estreita" />
                <h4 class= "h4Selecao" v-if ="window_estreita" >Selecionados</h4>
                <p class="pSelecao"  align="center" v-if ="window_estreita" >                    
                    <button v-if ="!marcaSelecionados" type="button">
                        <v-icon v-on:click="marcaSelecao('itemSelecionado','selected',true)">check_box_outline_blank</v-icon>
                    </button>                    
                    <button v-if ="marcaSelecionados" type="button">
                        <v-icon v-on:click="marcaSelecao('itemSelecionado','',false)">check_box</v-icon>
                    </button>                    
                    <button  type="button">
                        <v-icon v-on:click="alteraSelecao('itemSelecionado')" >keyboard_arrow_up</v-icon>
                    </button>
                </p>
                <v-divider class= "dividerSelecao" v-if ="window_estreita"/>
            </v-flex>
            <v-flex  xs12 md5  class="flexSelecao">                      
                <h4 v-if ="!window_estreita">Selecionados</h4>
                <v-divider v-if ="!window_estreita"/>
                <v-card class="d-inline-block mx-auto cardSelecao">
                    <section id="selecionados">
                        <select class="itemSelecionado" multiple >
                            <option 
                                v-for="(item) in selecionados(true)" 
                                v-bind:value="item.id" 
                                v-bind:key="item.id">
                                {{item.nome}}
                            </option>
                        </select>
                    </section>
                </v-card>                                                
            </v-flex>
        </v-layout>
    </v-container>
</template>
<script>
export default {
    data: () => {
        return {
            window_estreita:false,
            marcaSelecionados:false,
            marcaDisponiveis:false,
        }
    },
    props: {
        itensCaixa:{
            id: String,
            nome: String,
            checked: Boolean
        },
    },
    created() {
        window.addEventListener('resize', this.handleResize)
        this.handleResize();
    },
    destroyed() {
        window.removeEventListener('resize', this.handleResize)
    },
    methods: {
        handleResize() {
            this.window_estreita = window.innerWidth < 960 ? true : false;
        },
        marcaSelecao(caixa, selecao, marca){
            var itens = "." + caixa + " option" ;
                $.each( $(itens), function() {
                    this.selected = selecao;                    
                });
            caixa=='itemDisponivel' ? this.marcaDisponiveis=marca : this.marcaSelecionados=marca;
        },
        alteraSelecao(selecao){
            var index = null;
            var itensCaixa = this.itensCaixa;
            var itens = "." + selecao + " option:selected";
            $.each( $(itens), function() {
                index = itensCaixa.findIndex(p => p.id == this.value);
                itensCaixa[index]['checked']= (itensCaixa[index]['checked'] ? false : true);
            });
            this.marcaSelecao('itemDisponivel','',false);
            this.marcaSelecao('itemSelecionado','',false);
        },
        selecionados(check) {
            return this.itensCaixa.filter(function (item) {return item.checked == check});
        },
    },
}
</script>
<style scoped>
#caixaSelecao{
    margin-left:0pt;
    margin-right:0pt;
}
#caixaSelecao .cardSelecao {
    width:99%;
}
#caixaSelecao select {
    width:100%;
    height: 150pt;
}
#caixaSelecao option {
    height: 15pt;
    margin: 10pt; 
    margin-left:10pt;
}
#caixaSelecao .dividerSelecao {
    height: 15pt;
    margin-top: 0pt;
}
#caixaSelecao .pSelecao {
    height: 15pt;
    margin-left: -3pt;
}
#caixaSelecao .h4Selecao {
    height: 17pt;
    margin-bottom: -17pt;
}
.itemLista {
  margin: 10pt;
  margin-left:10pt;
  height: 15pt;  
}
</style>
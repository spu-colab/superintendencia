<template>   
 <v-container fluid >
     <hr style="margin-left:0pt;width: 100%;">

    
      <v-col  align="end" cols="12">
        <v-row
          style="margin-top:-10px;text-align:right;"
        >
        <v-flex md12>
            <v-layout align="end" style="width: 100%; margin: 0 auto">
                <v-flex class="center" align="end" xs5>
                    Registros por página:
                </v-flex>
                <v-flex class="center" xs1>
                    <v-select 
                        style="margin-left:10pt;margin-top:10pt;width: 50px;"
                        class="select_pag"
                        v-model="pagina.per_page"
                        :items="registrosPorPagina()"
                        v-on:change="mudaRegistros"               
                        dense
                    >
                    </v-select>
                </v-flex>
                <v-flex class="center" xs2>
                    Exibindo {{(pagina.current_page * pagina.per_page) - pagina.per_page + 1}}-{{pagina.current_page == pagina.last_page ? pagina.total : pagina.current_page * pagina.per_page}} de {{pagina.total}}
                </v-flex>
                <v-flex class="center" xs4>
                    <v-pagination 
                        v-model="pagina.current_page"
                        :length="pagina.last_page"
                        :total-visible="8"
                        v-on:input="mudaPagina"
                    ></v-pagination>
                </v-flex>
            </v-layout>
    </v-flex>

        </v-row>
      </v-col>
</v-container>
</template>
<script>
    export default {
        props:['pagina','filtro','ordem', 'ascending', 'pgCorrente'],
        data: () => {
            return {
                paginaCorrente: null,
            }
        },
        methods:{
            registrosPorPagina() {
                const total = this.pagina.total;
                switch (true) {
                    case (total > 200):
                        return ['10', '25', '50', '100', '200', '400'];
                    case (total > 100):
                        return ['10', '25', '50', '100', '200'];
                    case (total > 50):
                        return ['10', '25', '50', '100'];
                    case (total > 25):
                        return ['10', '25', '50'];
                    case (total > 10):
                        return ['10', '25'];
                }
                return ['10'];
            },
            mudaPagina(page){
                if (this.paginaCorrente == null){
                    this.paginaCorrente = this.pgCorrente;
                }                
                if (page != this.paginaCorrente){
                    this.paginaCorrente = page;
                    this.$emit('mudaPagina', [page, this.pagina.per_page, this.filtro, this.ordem, this.ascending[this.ordem]]);
                }
            },
            mudaRegistros(registros){
                this.paginaCorrente = 1;
                this.$emit('mudaPagina', [1, registros, this.filtro, this.ordem, this.ascending[this.ordem]]);
            },
        },
    }
</script>
<style>
.center {
  display: flex;
  justify-content: right;
  align-items: center;
}
</style>
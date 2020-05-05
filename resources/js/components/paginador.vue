<template>   
<div  style="vertical-align: middle" class="v-datatable theme--light" >
    <div  class="v-datatable__actions theme--light">
        <div style="height: 50px;vertical-align: middle" class="v-datatable__actions__select theme--light">   
            <span>Registros por página:</span>
            <v-select 
                style="margin:0pt; margin-left:10pt;margin-top:12pt"
                class="select_pag"
                v-model="pagina.per_page"
                :items="registrosPorPagina()"
                messages=""
                v-on:change="mudaRegistros"               
                dense
            >
            </v-select>
        </div>
        <div  class="v-datatable__actions__range-controls theme--light">  
            Exibindo {{(pagina.current_page * pagina.per_page) - pagina.per_page + 1}}-{{pagina.current_page == pagina.last_page ? pagina.total : pagina.current_page * pagina.per_page}} de {{pagina.total}}
            <v-pagination 
                v-model="pagina.current_page"
                :length="pagina.last_page"
                :total-visible="8"
                v-on:input="mudaPagina"
            ></v-pagination>
        </div>
    </div>
</div>
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
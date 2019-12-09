<template>
    <v-container fluid fill-height>
        <v-layout column>
            <v-flex xs12>
                <v-layout align-start justify-space-between row>
                        <crud 
                            nomeEntidade="Atendimento" nomeEntidadePlural="Atendimento"
                            :headers="cabecalhos" :items="registros" :carregando="carregando"
                            @clicou-item="selecionarParaEdicao" 
                            @clicou-salvar="salvar"
                            @clicou-cancelar="cancelar"
                            @clicou-novo="novo">
                        </crud>
                </v-layout>
            </v-flex>
        </v-layout>     
    </v-container>
</template>

<script>
import Crud from './../CRUD'
export default {
    components: {
        'crud': Crud
    },
    data: () => {
        return {
            cabecalhos: [],
            registros: [],
            carregando: true,
        }
    },
    methods: {
        carregarRegistros() {
        }
    },
    mounted() {
        this.carregarRegistros();
    }    
}
</script>
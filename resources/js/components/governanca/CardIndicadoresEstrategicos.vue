<template>
    <v-container fluid fill-height>
        <v-layout column>
            <v-flex xs12>

                <v-card>
                    <v-card-title primary title>
                        <h3>Metas SPU-SC</h3>            
                    </v-card-title>
                    
                    <v-container fluid fill-height>
                        <v-layout row wrap>
                            <v-flex xs12 md6 v-for="metaSPU in metas" :key="metaSPU.id">
                                <v-container>
                                    <card-indicador-estrategico  :meta="metaSPU"/>
                                </v-container>
                            </v-flex>
                        </v-layout>
                    </v-container>

                </v-card>
            </v-flex>
        </v-layout>
    </v-container>
</template>

<script>
import CardIndicadorEstrategico from './CardIndicadorEstrategico'
import dadosMetasGovernanca from './../../dados-governanca'

export default {
    data: () => {
        return {
            metas: []
        }
    },
    methods: {
        carregarMetas() {
            // console.log(dadosMetasGovernanca)
            this.metas = dadosMetasGovernanca.metas
        }
    },
    mounted() {
        this.carregarMetas()
    }
}
</script>
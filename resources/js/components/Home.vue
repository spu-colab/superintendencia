<template>
    <v-container fluid>
        <v-row align="stretch">
            <!-- Base de Conhecimento -->
            <v-col xs="12" md="4">
                <v-card class="align-stretch" href="http://conhecimento.spu.nossa.floripa.br" target="_blank">
                    <v-img src="/images/baseconhecimento.jpg" aspect-ratio="2.75" />
                    <v-card-title primary title>
                        Base de Conhecimento
                    </v-card-title>
                </v-card>
            </v-col>

            <!-- Geovisualização -->
            <v-col xs="12" md="4">
                <v-card class="align-stretch" to="/geo">
                    <v-img src="/images/geo.jpg" aspect-ratio="2.75" />
                    <v-card-title primary title>
                        Geovisualizador
                    </v-card-title>
                </v-card>
            </v-col>

            <!-- Demandas Jurídicas e de Controle -->
            <v-col xs="12" md="4">
                <v-card class="align-stretch" to="/nujuc">
                    <v-img src="/images/juridicas.jpg" aspect-ratio="2.75" />
                    <v-card-title primary title>
                        Demandas Jurídicas
                    </v-card-title>
                </v-card>
            </v-col>

            <!-- Metas SPU-SC -->
            <v-col cols="12">
                <v-layout align-start justify-space-between row>
                    <!--
                    <card-indicadores-estrategicos/>
                    -->
                </v-layout>
            </v-col>

        </v-row>
        
    </v-container>

</template> 
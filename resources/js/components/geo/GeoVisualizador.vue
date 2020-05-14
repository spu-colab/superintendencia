<template>
    <div id="painelGeo" :class="estiloPainelGeo()">
        <v-container fluid grid-list no-gutters v-resize="onResize">
            <v-row no-gutters class="overflow-y-auto">
                <v-col xs="12">
                    <v-toolbar dense dark color="primary">
                        <v-toolbar-title>SPU-SC - Geovisualizador</v-toolbar-title>
                        <v-spacer></v-spacer>
                        <v-tooltip bottom>
                            <template v-slot:activator="{ on }">
                                <v-btn icon v-on="on" @click="exibirCamadas = !exibirCamadas">
                                    <v-icon large>{{ exibirCamadas ? 'layers_clear' : 'layers' }}</v-icon>
                                </v-btn>
                            </template>
                            <span>{{ this.dicaExibirCamadas() }}</span>
                        </v-tooltip>
                        <v-tooltip left>
                            <template v-slot:activator="{ on }">
                                <v-btn icon v-on="on" @click="telaCheia = !telaCheia">
                                    <v-icon large>{{ telaCheia ? 'fullscreen_exit' : 'fullscreen' }}</v-icon>
                                </v-btn>
                            </template>
                            <span>{{ this.dicaTelaCheia() }}</span>
                        </v-tooltip>
                    </v-toolbar>
                </v-col>
            </v-row>
            <v-row no-gutters>
                <v-col xs="12" :md="exibirCamadas ? 8 : 12">
                    <div id="mapGeo" class="map"></div>
                </v-col>
                <v-col v-if="exibirCamadas" xs="12" md="4">
                    <v-card tile flat>
                        <v-card-title>
                            <h6 class="title text-capitalize">
                                Camadas
                            </h6>
                        </v-card-title>
                        <v-card-text>
                            <div id="painelCamadas" style="overflow: auto;">
                                <div v-for="camada in camadas" :key="camada.id">
                                    <v-layout row>
                                        <v-flex col xs1>
                                            <v-icon @click="expandirCamada(camada)">{{ camada.expandida ? 'expand_less' : 'expand_more' }}</v-icon>
                                        </v-flex>
                                        <v-flex col xs1>
                                            <v-icon  
                                                :color="camada.selecionada ? camada.cor : ''" 
                                                @click="selecionarCamada(camada); return;">
                                                {{ camada.selecionada ? 'visibility' : 'visibility_off' }}
                                                </v-icon>
                                        </v-flex>
                                        <v-flex col xs10>
                                            <div class="subheading">{{ camada.name }}</div>
                                        </v-flex>
                                    </v-layout>
                                    <v-progress-linear v-if="camada.carregando" indeterminate small />
                                    <v-divider />
                                    <transition name="slide-y">
                                        <div v-if="camada.expandida">
                                            <v-layout row v-for="item in camada.children" v-bind:key="item.id">
                                                <v-flex xs2>
                                                    &nbsp;
                                                </v-flex>
                                                <v-flex xs1>
                                                    <v-icon @click="clicouItemCamada(item)" :color="item.selecionado ? item.cor : ''" >
                                                        {{ item.selecionado ? 'visibility' : 'visibility_off' }}
                                                    </v-icon>
                                                </v-flex>
                                                <v-flex xs9>
                                                    <div class="body-1">{{ item.name }}</div>
                                                    <div class="caption text--grey-lighten-5">{{ item.subheader }}</div>
                                                    <v-tooltip bottom>
                                                        <template v-slot:activator="{ on }">
                                                            <v-icon small 
                                                                @click="clicouZoomItemCamada(item)" v-on="on">zoom_in</v-icon>
                                                        </template>
                                                        Mostrar no Mapa
                                                    </v-tooltip>
                                                    <v-tooltip bottom>
                                                        <template v-slot:activator="{ on }">
                                                            <v-icon small 
                                                                @click="clicouAbrirCadastroItemCamada(item)" v-on="on">launch</v-icon>
                                                        </template>
                                                        Abrir Cadastro
                                                    </v-tooltip>
                                                    <v-divider />
                                                </v-flex>
                                            </v-layout>
                                        </div>
                                    </transition>
                                </div>
                            </div>
                        </v-card-text>
                    </v-card>
                </v-col>
            </v-row>
        </v-container>
    </div>
</template>

<script>
import L from 'leaflet'
import 'leaflet/dist/leaflet.css'
import 'leaflet.pm/dist/leaflet.pm.min'
import 'leaflet.pm/dist/leaflet.pm.css'

import rotas from './../../rotas-servico.js'
import { isString, isArray } from 'util'

import GeoVisualizador from './GeoVisualizador.class.js'
import configuracoesGeoVisualizador from './configuracoes'

export default {
    data() {
        return {
            map: null,
            camadas: [],
            idsSelecionados: [],
            itensAtivos: [],
            exibirCamadas: true,
            telaCheia: true,
            geovisualizador: null
        }
    },

    methods: {

        estiloPainelGeo() {
            return this.telaCheia ? 'painelGeoTelaCheia' : ''
        },

        dicaExibirCamadas() {
            return this.exibirCamadas ? 'Esconder painel de camadas' : 'Mostrar painel de camadas'
        },

        dicaTelaCheia() {
            return this.telaCheia ? 'Sair do modo tela cheia' : 'Exibir em tela cheia'
        },

        carregarCamadas() {
            this.carregando = true
            this.camadas = []
            let url = rotas.rotas().geo.camada.listar
            return this.$http.get(url)
            .then(
                response => {
                    response.body.forEach(element => {
                        let camada = {
                            id: element.id,
                            name: element.titulo,
                            open: false,
                            icon: 'layers',
                            children: null,
                            cor: element.cor,
                            expandida: false,
                            selecionada: false,
                            carregando: false,
                            rotaFrontEnd: element.rotaFrontEnd
                        }
                        // console.log(camada)
                        this.camadas.push(camada)
                    })
                    this.carregando = false
                },
                error => {
                    console.log(error)
                    this.carregando = false
                }
            )
        },

        async carregarCamada(camada) {
            // console.log('carregarCamada')

            if(camada.children && camada.children.length) {
                return
            }

            if(camada && camada.id) {
                let url = rotas.rotas().geo.camada.referencia.listar
                url = url.replace('[idCamada]', camada.id)
                camada.carregando = true
                return this.$http.get(url)
                .then(
                    response => {
                        camada.children = []
                        response.body.forEach(element => {
                            element.conteudoPopup = this.montarConteudoPopupDaReferencia(element)
                            element.rotaFrontEnd = camada.rotaFrontEnd.replace('[id]', element.idReferenciado)
                            element.id += 1000000 * camada.id
                            let feature = {
                                id: element.id,
                                rotaFrontEnd: element.rotaFrontEnd,
                                name: element.titulo,
                                subheader: element.subtitulo,
                                popupContent: element.conteudoPopup,
                                type: element.poligonais.type,
                                cor: camada.cor,
                                selecionado: false,
                                coords: element.poligonais.coordinates,
                                features: element.poligonais.geometries
                            }
                            let options = { color: camada.cor }
                            feature.leafletObject = this.geovisualizador.criarVetor(feature, options)
                            this.geovisualizador.inserirVetorNoGrupo(feature.leafletObject, feature.name, camada.name)
                            camada.children.push(feature)
                        })
                        this.atualizarElementosNoMapa()
                        camada.expandida = true
                        camada.carregando = false
                        },
                        error => {
                            console.log(error)
                            camada.children = null
                            camada.carregando = false
                        }
                )
            }
        },

        expandirCamada(camada) {
            // console.log('expandirCamada')
            camada.expandida = !camada.expandida

            if(!camada.selecionada && camada.children == null) {
                this.carregarCamada(camada)
            }
        },

        montarConteudoPopupDaReferencia(referencia) {
            var conteudo = referencia.rotulo;
            conteudo += '<h4>' + referencia.titulo + '</h4>'
            conteudo += '<small><i>' + referencia.subtitulo + '</i></small>'
            return conteudo
        },

        atualizarElementosNoMapa() {
            // console.log('atualizarElementosNoMapa')
            this.camadas.forEach(function(camada) {
                if(isArray(camada.children)) {
                    camada.children.forEach(function(elemento) {
                        if (this.idsSelecionados.includes(elemento.id)) {
                            // console.log('addTo')
                            elemento.leafletObject.addTo(this.geovisualizador.mapa)
                        } else {
                            // console.log('remove')
                            elemento.leafletObject.remove()
                        }
                        }.bind(this))
                }
            }.bind(this))
        },

        selecionarCamada(camada) {
            // console.log('clicouSelecaoCamada')
            
            if(camada.carregando) {
                return
            }

            // console.log(camada)
            if(!camada.selecionada && (camada.children == null || camada.children.length == 0)) {
                this.carregarCamada(camada)
                return
            }

            camada.selecionada = !camada.selecionada
            if(camada.selecionada) {
                camada.expandida = true
            }
            if(isArray(camada.children)) {
                camada.children.forEach(itemCamada => {
                    if(itemCamada.selecionado != camada.selecionada) {
                        this.clicouItemCamada(itemCamada)
                    }
                })
            }
        },

        clicouItemCamada(itemCamada) {
            // console.log(itemCamada)
            let index = this.idsSelecionados.indexOf(itemCamada.id)
            // console.log(index)
            if(index > -1) {
                this.idsSelecionados.splice(index, 1)
                itemCamada.selecionado = false
            } else {
                this.idsSelecionados.push(itemCamada.id)
                itemCamada.selecionado = true
            }
        },

        clicouZoomItemCamada(itemDaArvore) {
            // console.log('clicouZoomItemCamada')
            // console.log(itemDaArvore)
            if(itemDaArvore.leafletObject) {
                if(!this.idsSelecionados.includes(itemDaArvore.id)) {
                    this.clicouItemCamada(itemDaArvore)
                }
                this.geovisualizador.getMapa().flyToBounds(itemDaArvore.leafletObject.getBounds())
            }
        },

        clicouAbrirCadastroItemCamada(itemDaArvore) {
            console.log(itemDaArvore)
            this.$router.push(itemDaArvore.rotaFrontEnd)
        },

        onResize() {
            // console.log('onResize()')
            // console.log(window.innerHeight - 70)
            var divMap = document.getElementsByClassName('map')[0]
            divMap.style.height = (window.innerHeight - 70) + 'px'

            var painelCamadas = document.getElementById('painelCamadas')
            painelCamadas.style.height = (window.innerHeight - 170) + 'px'
        },

        inicializarMapa() {
            configuracoesGeoVisualizador.opcoes.crs = L.CRS.EPSG3857
            this.geovisualizador = new GeoVisualizador('mapGeo', 
                configuracoesGeoVisualizador.opcoes, 
                configuracoesGeoVisualizador.mapas)

            // carrega as camadas da API
            this.carregarCamadas();

            // carregar camandas GeoJson estáticas
            this.geovisualizador.carregarGeoJsons(configuracoesGeoVisualizador.geojsons)

            this.geovisualizador.carregarGrupos()

        },

    },

    watch: {

        idsSelecionados() {
            this.atualizarElementosNoMapa()
        }

    },

    mounted () {
        this.onResize()
        this.inicializarMapa()

    },
}
</script>

<style scoped>
.map {
  height: 100%;
  overflow: hidden;
}
.slide-y-enter-active, .slide-y-leave-active {
  transition: opacity .5s;
}
.slide-y-enter, .slide-y-leave-to /* .fade-leave-active below version 2.1.8 */ {
  opacity: 0;
}

div.painelGeoTelaCheia {
    z-index: 99999;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: #CECECE;
}
</style>
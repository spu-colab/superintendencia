<template>
    <v-container fill-height fluid grid-list>
        <v-layout row>
            <v-flex col xs12 md9>
                <div id="mapGeo" class="map"></div>
            </v-flex>
            <v-flex col xs12 md3>
                <v-card>
                    <v-card-title>
                        <h6 class="title text-capitalize">
                            Camadas
                        </h6>
                    </v-card-title>
                    <v-container>
                        <v-layout row>
                            <v-flex col xs12>
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
                                                        <template slot="activator">
                                                            <v-icon small @click="clicouZoomItemCamada(item)">zoom_in</v-icon>
                                                        </template>
                                                        Mostrar no Mapa
                                                    </v-tooltip>
                                                    <v-tooltip bottom>
                                                        <template slot="activator">
                                                            <v-icon small @click="clicouAbrirCadastroItemCamada(item)">launch</v-icon>
                                                        </template>
                                                        Abrir Cadastro
                                                    </v-tooltip>
                                                    <v-divider />
                                                </v-flex>
                                            </v-layout>
                                        </div>
                                    </transition>
                                </div>
                            </v-flex>
                        </v-layout>
                    </v-container>
                    
                </v-card>
            </v-flex>
        </v-layout>
    </v-container>
</template>

<script>
import L from 'leaflet'
import 'leaflet/dist/leaflet.css'
import 'leaflet.pm/dist/leaflet.pm.min'
import 'leaflet.pm/dist/leaflet.pm.css'

import rotas from './../../rotas-servico.js'
import { isString, isArray } from 'util'

export default {
    data() {
        return {
            map: null,
            camadas: [],
            idsSelecionados: [],
            itensAtivos: [],
        }
    },

    methods: {

        initMap () {
            console.log('initMap()')
            if(this.map == null) {
                console.log('Map não inicializado...')
                this.map = L.map('mapGeo', {
                    crs: L.CRS.EPSG3857
                }).setView([-28.1, -47.5], 7);
               this.adicionarTileLayers()            
            }
        },

        adicionarTileLayers() {
            console.log('adicionarTileLayers()')
            let tileLayerMapa = L.tileLayer(
                'https://cartodb-basemaps-{s}.global.ssl.fastly.net/rastertiles/voyager/{z}/{x}/{y}.png', {
                maxZoom: 18,
                attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>, &copy; <a href="https://carto.com/attribution">CARTO</a>',
                useCache: true,
                zIndex: 0
            })

            let tileLayerSatelite = L.tileLayer('https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}', {
                attribution: 'Tiles &copy; Esri &mdash; Source: Esri, i-cubed, USDA, USGS, AEX, GeoEye, Getmapping, Aerogrid, IGN, IGP, UPR-EGP, and the GIS User Community'
            });

            let googleStreets = L.tileLayer('http://{s}.google.com/vt/lyrs=m&x={x}&y={y}&z={z}',{
                maxZoom: 20,
                subdomains:['mt0','mt1','mt2','mt3']
            });

            let googleHybrid = L.tileLayer('http://{s}.google.com/vt/lyrs=s,h&x={x}&y={y}&z={z}',{
                maxZoom: 20,
                subdomains:['mt0','mt1','mt2','mt3']
            });

            let googleSat = L.tileLayer('http://{s}.google.com/vt/lyrs=s&x={x}&y={y}&z={z}',{
            maxZoom: 20,
                subdomains:['mt0','mt1','mt2','mt3']
            });    
            
            var baseMaps = {
            "OpenStreetMap": tileLayerMapa,
            "ArcGis Online": tileLayerSatelite,
            "Google Ruas": googleStreets,
            "Google Híbrido": googleHybrid,
            "Google Satélite": googleSat,
            }
            tileLayerMapa.addTo(this.map)
            L.control.layers(baseMaps).addTo(this.map)

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
                            element.rotaFrontEnd = camada.rotaFrontEnd.replace('[id]', element.id)
                            element.id += 1000000 * camada.id
                            let feature = {
                                id: element.id,
                                rotaFrontEnd: element.rotaFrontEnd,
                                name: element.titulo,
                                subheader: element.subtitulo,
                                popupContent: element.conteudoPopup,
                                type: 'polygon', // element.poligonais.type,
                                cor: camada.cor,
                                selecionado: false,
                                coords: element.poligonais.coordinates,
                            }
                            let options = { color: camada.cor }
                            feature.leafletObject = this.criarLeafletObject(feature, options)
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

        criarLeafletObject(feature, options = {}) {
            // console.log('criarLeafletObject')
            // console.log(feature)
            if(feature.type == 'polygon') {
                return L.polygon(feature.coords, options).bindPopup(feature.popupContent)
            } else {
                console.log('feature.type "'+ feature.type + '" não suportado')
            }
        },

        atualizarElementosNoMapa() {
            // console.log('atualizarElementosNoMapa')
            this.camadas.forEach(function(camada) {
                if(isArray(camada.children)) {
                    camada.children.forEach(function(elemento) {
                        if (this.idsSelecionados.includes(elemento.id)) {
                            // console.log('addTo')
                            elemento.leafletObject.addTo(this.map)
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
                this.map.flyToBounds(itemDaArvore.leafletObject.getBounds())
            }
        },

        clicouAbrirCadastroItemCamada(itemDaArvore) {
            // console.log(itemDaArvore)
            this.$router.push(itemDaArvore.rotaFrontEnd)
        },

    },

    watch: {

        idsSelecionados() {
            this.atualizarElementosNoMapa()
        }

    },

    mounted () {
        this.initMap()
        this.carregarCamadas();
    },
}
</script>

<style scoped>
.map {
  height: 100%;
  max-height: 840px;
  overflow: hidden;
}
.slide-y-enter-active, .slide-y-leave-active {
  transition: opacity .5s;
}
.slide-y-enter, .slide-y-leave-to /* .fade-leave-active below version 2.1.8 */ {
  opacity: 0;
}
</style>
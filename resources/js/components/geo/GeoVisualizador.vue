<template>
    <v-container fill-height fluid grid-list>
        <v-layout row>
            <v-flex col xs12 md9 xl8>
                <div id="map" class="map"></div>
            </v-flex>
            <v-flex col xs12 md3 xl4>
                <v-card>
                    <v-card-title>
                        <h6 class="title text-capitalize">Camadas</h6>
                    </v-card-title>
                    <v-card-text>
                        <v-treeview v-model="idsSelecionados"
                            :items="camadas" 
                            :load-children="carregarCamada"
                            selectable>
                            <template v-slot:prepend="{ item, active }">
                                <v-icon :color="item.cor">{{ item.icon }}</v-icon>
                            </template>
                            <template v-slot:label="{ item, open }">
                                <div class="body-1 itemDaArvore">{{ item.name }}</div>
                                <div class="caption itemDaArvore" v-if="item.subheader">{{ item.subheader }}</div>
                                <v-divider v-if="item.subheader"></v-divider>
                            </template>
                            <template v-slot:append="{ item }">
                                <v-icon v-if="!item.children" @click="clicouZoomItemCamada(item)">zoom_in</v-icon>
                            </template>
                        </v-treeview>
                    </v-card-text>
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
            this.map = L.map('map', {
                crs: L.CRS.EPSG3857
            }).setView([-28.1, -47.5], 7);
            /*
            this.map.pm.addControls({
            position: 'topleft',
            });
            */
           this.adicionarTileLayers()            
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
                            children: [],
                            cor: element.cor
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

            if(camada && camada.id) {
                let url = rotas.rotas().geo.camada.referencia.listar
                url = url.replace('[idCamada]', camada.id)
                return this.$http.get(url)
                .then(
                    response => {
                        response.body.forEach(element => {
                            element.conteudoPopup = this.montarConteudoPopupDaReferencia(element)
                            element.id += 1000000 * camada.id
                            let feature = {
                                id: element.id,
                                name: element.titulo,
                                subheader: element.subtitulo,
                                popupContent: element.conteudoPopup,
                                type: 'polygon', // element.poligonais.type,
                                icon: 'label',
                                cor: camada.cor,
                                coords: element.poligonais.coordinates,
                            }
                            // console.log(feature)
                            let options = { color: camada.cor }
                            feature.leafletObject = this.criarLeafletObject(feature, options)
                            camada.children.push(feature)
                            // this.atualizarItemDaArvoreNoMapa(feature)
                        })
                        this.atualizarElementosNoMapa()
                        this.carregandoCamada = false
                        },
                        error => {
                        console.log(error)
                        this.carregandoCamada = false
                        }
                )
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
                camada.children.forEach(function(elemento) {

                if (this.idsSelecionados.includes(elemento.id)) {
                    // console.log('addTo')
                    elemento.leafletObject.addTo(this.map)
                } else {
                    // console.log('remove')
                    elemento.leafletObject.remove()
                }
                }.bind(this))
            }.bind(this))
        },

        clicouZoomItemCamada(itemDaArvore) {
            // console.log('clicouZoomItemCamada')
            // console.log(itemDaArvore)
            if(itemDaArvore.leafletObject) {
                if(!this.idsSelecionados.includes(itemDaArvore.id)) {
                    this.idsSelecionados.push(itemDaArvore.id)
                }
                this.map.flyToBounds(itemDaArvore.leafletObject.getBounds())
            }
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
        // this.inicializarCamadas()
        // this.carregarCamada();
    },
}
</script>

<style scoped>
#map {
  height: 100%;
  max-height: 840px;
  overflow: hidden;
}

.itemDaArvore {
    white-space: nowrap;
    width: 100%;                   /* IE6 needs any width */
    overflow: hidden;              /* "overflow" value must be different from  visible"*/ 
    -o-text-overflow: ellipsis;    /* Opera < 11*/
    text-overflow:    ellipsis;    /* IE, Safari (WebKit), Opera >= 11, FF > 6 */
}
</style>
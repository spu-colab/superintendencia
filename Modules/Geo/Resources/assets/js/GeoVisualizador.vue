<template>
    <div id="painelGeo" :class="estiloPainelGeo()">
        <v-container fluid grid-list no-gutters v-resize="onResize">
            <v-row no-gutters class="overflow-y-auto">
                <v-col xs="12">
                    <v-toolbar dense dark color="primary">
                        <v-toolbar-title>Geovisualizador</v-toolbar-title>
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
                    <div id="painelCamadas" style="overflow: auto;">

                        <div class="cabealhoCamadas">Camadas</div>
                        <div v-for="camada in camadas" v-bind:key="camada.id">

                            <div class="camada">
                                <v-icon  @click="expandirCamada(camada)" :color="camada.selecionada ? camada.cor : ''" small >
                                    {{ camada.expandida ? 'expand_less' : 'expand_more' }}
                                </v-icon>
                                <v-icon v-if="camada.geojson && camada.geojson.features" @click="trocarVisibilidadeCamada(camada)" small>{{ camada.visible ? 'visibility' : 'visibility_off' }}</v-icon>
                                <span class="tituloCamada">{{ camada.titulo }}</span>
                                <v-progress-linear v-if="camada.carregando" indeterminate small />
                                <v-container class="features" v-if="camada.expandida && camada.geojson != null">
                                    <v-row v-for="(feature, f) in camada.geojson.features" v-bind:key="f">
                                        <v-flex xs1>
                                            <v-icon @click="trocarVisibilidadeFeature(camada, feature, f)" small>{{ feature.visible ? 'visibility' : 'visibility_off' }}</v-icon>
                                        </v-flex>
                                        <v-flex xs11>
                                            <div class="titulo">{{ feature.getTitulo() }}</div>
                                            <div>{{ feature.getSubTitulo() }}</div>
                                            <div>
                                                <v-tooltip bottom>
                                                    <template v-slot:activator="{ on }">
                                                        <v-icon small 
                                                            @click="clicouZoomItemCamada(camada, feature, f)" v-on="on">zoom_in</v-icon>
                                                    </template>
                                                    Mostrar no Mapa
                                                </v-tooltip>
                                                <v-tooltip bottom v-if="!camada.estatica">
                                                    <template v-slot:activator="{ on }">
                                                        <v-icon small 
                                                            @click="clicouAbrirCadastroItemCamada(camada, feature)" v-on="on">launch</v-icon>
                                                    </template>
                                                    Abrir Cadastro
                                                </v-tooltip>
                                            </div>
                                        </v-flex>
                                    </v-row>
                                </v-container>
                            </div>

                        </div>
                    </div>
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

import rotas from './../../../../../resources/js/rotas-servico'
import { isString, isArray } from 'util'

// import GeoVisualizador from './GeoVisualizador.class.js'
import configuracoesGeoVisualizador from './setup'
import LeafletSimpleSet from './LeafletSimpleSet'

export default {
    data() {
        return {
            map: null,
            camadas: [],
            idsSelecionados: [],
            itensAtivos: [],
            exibirCamadas: true,
            telaCheia: false,
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

        onResize() {
            // console.log('onResize()')
            // console.log(window.innerHeight - 70)
            var divMap = document.getElementsByClassName('map')[0]
            divMap.style.height = (window.innerHeight - 70) + 'px'

            var painelCamadas = document.getElementById('painelCamadas')
            painelCamadas.style.height = (window.innerHeight - 170) + 'px'
        },

        mensagemSucesso(msg) {
            this.$store.commit('sistema/mensagem', msg)
        },

        mensagemFalha(msg) {
            this.$store.commit('sistema/alerta', msg)
        },

        carregarCamadas() {
            this.$http.get("/api/geo/camada").then(
                response => {
                    this.camadas = response.body.data
                },
                error => {
                    console.log(error)
                }
            )  
        },

        carregarCamada(camada) {
            // console.log("GeoVisualizador.carregarCamada", camada)
            if(camada.geojson && camada.geojson.features) {
                // console.log("Camada já carregada")
                return
            }
            camada.carregando = true
            this.atualizarCamada(camada)
            this.$http.get("/api/geo/camada/" + camada.id + "/geojson").then(
                response => {
                    // console.log(response.body)
                    camada.geojson = response.body
                    this.prepararFeatures(camada)
                    // TODO carregar callback do banco
                    camada.getTituloItem = (feature) => {
                        return feature.properties.nome
                    }
                    camada.getSubTituloItem = (feature) => {
                        return feature.properties.geocodigo
                    }
                    camada.carregando = false
                    camada.selecionada = false
                    this.atualizarCamada(camada)
                },
                error => {
                    console.log(error)
                    camada.carregando = false
                })
        },

        prepararFeatures(camada) {
            // console.log("prepararFeatures", camada)
            if(camada.geojson && isArray(camada.geojson.features)) {

                let propriedadeTitulo = camada.propriedadeTitulo == null ? "titulo" : camada.propriedadeTitulo
                let propriedadeSubTitulo = camada.propriedadeSubTitulo == null ? "subtitulo" : camada.propriedadeSubTitulo

                camada.geojson.features = camada.geojson.features.map(function(feature) {
                    //console.log("prepararFeature", feature)

                    feature.getTitulo = function() {
                        return this.properties[propriedadeTitulo]
                    }

                    feature.getSubTitulo = function() {
                        // console.log("Feature.getSubTitulo", propriedadeSubTitulo)
                        return this.properties[propriedadeSubTitulo]
                    }

                    return feature
                })

                // sort
                camada.geojson.features = camada.geojson.features.sort((a, b) => {
                    return a.getTitulo() > b.getTitulo()
                })
            }
        },

        atualizarCamada(camadaAtualizada) {
            this.camadas = this.camadas.map(camada => {
                if(camada.id == camadaAtualizada.id) {
                    return camadaAtualizada
                }
                return camada
            })
        },

        atualizarFeature(camada, featureAtualizada, indexAAtualizar) {
            camada.geojson.features = camada.geojson.features.map((feature, index) => {
                if(index == indexAAtualizar) {
                    return featureAtualizada
                }
                return feature
            })
            this.montarLeafletVector(camada, featureAtualizada)
            if(featureAtualizada.visible) {
                featureAtualizada.leafletVector.addTo(this.geovisualizador.getMap())
                // this.geovisualizador.getMap().fitBounds(featureAtualizada.leafletVector.getBounds());
            } else {
                featureAtualizada.leafletVector.remove()
            }
            this.atualizarCamada(camada)
        },

        trocarExpandir(camada) {
            if(camada.expandida == null) {
                camada.expandida = false
            }
            camada.expandida = !camada.expandida
            this.atualizarCamada(camada)
        },

        expandirCamada(camada) {
            // console.log('expandirCamada')
            this.trocarExpandir(camada)
            if(!camada.selecionada) {
                this.carregarCamada(camada)
            }
        },

        montarLeafletVector(camada, feature) {
            if(feature.leafletVector == null) {
                feature.geometry.popupContent = this.montarPopupContent(camada, feature)
                if(camada.geojson.crs != L.CRS.EPSG3857.code) {
                    feature.geometry.coordinates = this.converterLongLatParaLagLongs(feature.geometry.coordinates)
                }
                let options = {}
                if(camada.cor != null) {
                    options.color = camada.cor
                    options.fillColor = camada.cor
                }
                // console.log(camada, options)
                feature.leafletVector = this.geovisualizador.createLeafletVector(feature.geometry, options)
            }
        },

        montarPopupContent(camada, feature) {
            // console.log("GeoVisualizador.montarPopupContent", camada, feature)
            // titulo
            let conteudo = "<table cellpadding=10>"
            conteudo += "   <tbody>"
            /*
            conteudo += "       <tr>"
            conteudo += "           <th>" + camada.rotulo + "</th>"
            conteudo += "           <td>" + feature.getTitulo() + "</td>"
            conteudo += "       </tr>"
            // subtitulo
            conteudo += "       <tr>"
            conteudo += "           <td colspan=2>" + feature.getSubTitulo() + "</td>"
            conteudo += "       </tr>"
            */
            if(typeof feature.properties === "object") {
                for(let propriedade in feature.properties) {
                    conteudo += "<tr>"
                    conteudo += "   <th style='padding:5px; vertical-align: top;'>" + propriedade + "</th>"
                    conteudo += "   <td style='padding:5px;'>" + feature.properties[propriedade] + "</td>"
                    conteudo += "</tr>"
                }
            }
            conteudo += "   </tbody>"
            conteudo += "</table>"

            return conteudo
        },

        trocarVisibilidadeCamada(camada) {
            // console.log("GeoVisualizador.trocarVisibilidadeCamada", camada)
            if(camada.visible == null) {
                camada.visible = true
            } else {
                camada.visible = !camada.visible
            }

            camada.geojson.features.map((feature, f) => {
                feature.visible = camada.visible
                this.atualizarFeature(camada, feature, f)
                return feature
            })
            this.atualizarCamada(camada)
        },

        trocarVisibilidadeFeature(camada, feature, index) {
            // console.log("GeoVisualizador.trocarVisibilidadeFeature", feature)
            if(feature.visible == null) {
                feature.visible = false
            }
            feature.visible = !feature.visible
            this.atualizarFeature(camada, feature, index)
        },

        converterLongLatParaLagLongs(longLatArray) {
            // console.log("converterLongLatParaLagLongs", longLatArray)
            if(isArray) {
                longLatArray.forEach(function(item) {
                if(item.length > 0) {
                    if(isArray(item[0])) {            
                    item = this.converterLongLatParaLagLongs(item) 
                    } else {
                    item = item.reverse()
                    }
                } 
                }.bind(this))
            }
            return longLatArray
        },

        clicouZoomItemCamada(camada, feature, index) {
            // console.log('GeoVisualizador.clicouZoomItemCamada', camada, feature, index)
            feature.visible = true
            this.atualizarFeature(camada, feature, index)
            this.geovisualizador.getMap().fitBounds(feature.leafletVector.getBounds());
        },

        clicouAbrirCadastroItemCamada(camada, feature) {
            // console.log("GeoVisualizador.clicouAbrirCadastroItemCamada", feature)
            feature.rotaFrontEnd = camada.rotaFrontEnd.replace('[id]', feature.idReferenciado)
            this.$router.push(feature.rotaFrontEnd)
        },

        inicializar() {
            this.carregarCamadas()
            configuracoesGeoVisualizador.config.crs = L.CRS.EPSG3857
            this.geovisualizador = new LeafletSimpleSet("mapGeo", configuracoesGeoVisualizador.config)
            this.geovisualizador.setSuccessCallback(this.mensagemSucesso.bind(this))
            this.geovisualizador.setFailCallback(this.mensagemFalha.bind(this))
            // this.geovisualizador.addMap(configuracoesGeoVisualizador.maps[0])
            this.geovisualizador.addMaps(configuracoesGeoVisualizador.maps)
            /*
            this.geovisualizador.loadGeoJSON({
                title: "América Latina",
                group: "Limites Territoriais",
                url: "https://raw.githubusercontent.com/Cadastro-Marinho/LatinAmericaData/master/LatinAmerica.geojson",
                active: true,
                searchAttribute: "CNTRY_NAME",
                callbacks: {
                    style: function(feature) {
                        return {
                            fillOpacity: 0.25,
                            color: feature.COLORMAP,
                            weight: 0.75
                        }
                    },
                    onEachFeature: function( feature, layer ) {
                        layer.bindPopup(
                            "<b>Nome: </b>" + feature.properties.LOCLNGNAM + "<br>" +
                            "<b>Status: </b>" + feature.properties.STATUS + "<br>" +
                            "<b>Área: </b>" + feature.properties.SQKM.toLocaleString('de-DE', { maximumFractionDigits: 2 }) + " km &#178; <br>" +
                            "<b>População (2019): </b>" + feature.properties.POP_CNTRY.toLocaleString('de-DE', { maximumFractionDigits: 0 })
                            );
                        layer.bindTooltip(feature.properties.LOCSHRTNAM, {
                            permanent: false
                        });
                    }
                }
            })
            
            // this.geovisualizador.loadGeoJSONCollection(configuracoesGeoVisualizador.geoJSONFeatures)
            */
            this.geovisualizador.initialize()
        }

    },

    watch: {
        camadas: function (val) {
            // console.log("GeoVisualizador.watch.camadas", this.camadas)
        }
    },

    mounted () {
        this.inicializar()
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

div.camada {
    margin-left: 20px;
}

div.features {
    margin-left: 40px;
}

span.tituloCamada {
    padding:5px;
    padding-top: 8px;
}

div.featureRow {
    display: block;
    border-bottom-style: 1px solid #EAEAEA;
    width: 100%;
    overflow-x: hidden;
}

div.feature {
  float: left;
  font-size: 9pt;
}

div.feature div.titulo {
  font-weight: 600;
}

div.icone {
  float: left;
  display: table-column;
  padding: 3%;
}

div.featureContent_row {
    display: block;
}

div.featureContent_label {
    float: left;
    display: table-column;
}

div.featureContent_value {
    float: left;
}

</style>
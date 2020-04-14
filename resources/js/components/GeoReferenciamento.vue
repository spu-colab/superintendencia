<template>
  <div id="painelGeo" :class="estiloPainelGeo()">
    <v-container fluid grid-list no-gutters v-resize="onResize">
      <v-row no-gutters class="overflow-y-auto">
          <v-col xs="12">
              <v-toolbar dense dark color="primary">
                  <v-toolbar-title></v-toolbar-title>
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
        <!-- MAPA -->
        <v-col xs="12" :md="exibirCamadas ? 8 : 12">
          <div id="map" class="map"></div>
        </v-col>
        <!-- Fim de MAPA -->

        <!-- Coluna Importação -->
        <!-- Geometrias a Importar -->
        <v-col v-if="exibirCamadas" xs="12" md="4">
          <v-card tile flat>
            <v-card-title>
              <h6 class="title text-capitalize">Importar Geometrias</h6>
            </v-card-title>
            <v-card-subtitle>
              <input type="file" id="files" ref="files" v-on:change="handleFiles()" value="Importar shapefile (.shp)"/>
            </v-card-subtitle>
            <v-card-text>
              <div id="painelCamadas" style="overflow: auto;">
                <div v-if="camadaImportacao && camadaImportacao.children.length > 0">
                  <v-row>
                    <v-col xs="12">
                      <v-checkbox dense 
                        v-model="camadaImportacao.selected"
                        :label="camadaImportacao.name" @change="selecionouCamada(camadaImportacao)" />
                    </v-col>
                  </v-row>
                  <v-row dense v-for="item in camadaImportacao.children" v-bind:key="item.id">
                    <v-col xs="2">
                      <v-tooltip bottom>
                        <template v-slot:activator="{ on }">
                          <v-icon small @click="selecionouElementoCamada(item)" v-on="on">
                            {{ item.selected ? 'check_box' : 'check_box_outline_blank' }}
                          </v-icon>
                        </template>
                        Mostrar no Mapa
                      </v-tooltip>
                      <v-tooltip bottom>
                        <template v-slot:activator="{ on }">
                          <v-icon small @click="clicouZoomItemCamada(item)" v-on="on">zoom_in</v-icon>
                        </template>
                        Mostrar no Mapa
                      </v-tooltip>
                      {{ item.name + '' }}
                    </v-col>
                  </v-row>
                </div>
              </div>
              
            </v-card-text>
            <v-card-actions>
              <!-- Botão salvar -->
              <v-btn :disabled="botaoSalvarGeometriasSelecionadasDesativado()" 
                @click="salvarGeometrias">Salvar Selecionadas</v-btn>
            </v-card-actions>
          </v-card>
        </v-col>
        <!-- Fim da Coluna Importação -->
      </v-row>
    </v-container>
  </div>
</template>

<script>
import rotas from './../rotas-servico.js'

import L from 'leaflet'
import 'leaflet/dist/leaflet.css'
import 'leaflet.pm/dist/leaflet.pm.min'
import 'leaflet.pm/dist/leaflet.pm.css'
import shp from './../shp'
import { isObject, isArray } from 'util';
import { setTimeout } from 'timers';
require('./../leaflet.shpfile')

export default {
  data: function () {
    return {
      map: null,
      baseMaps: {},
      files: [],

      camada: null,
      referencia: null,
      camadaImportacao: null,
      exibirCamadas: true,
      telaCheia: false,
    }
  },
  props: {
    idCamada: {
      type: Number,
      default: 0
    },
    idReferenciado: {
      type: Number,
      default: 0
    },
    atualizarMapa: {
      type: Boolean,
      default: false
    }
  },

  mounted () {
    this.initMap()
    this.inicializarCamadaImportacao();
    this.carregarCamada();
  },

  methods: {  
    initMap ()
    {
      this.map = L.map('map', {
        crs: L.CRS.EPSG3857
      }).setView([-28.1, -47.5], 7)
     
    let tileLayerMapa = L.tileLayer(
      'https://cartodb-basemaps-{s}.global.ssl.fastly.net/rastertiles/voyager/{z}/{x}/{y}.png', {
        maxZoom: 18,
        attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>, &copy; <a href="https://carto.com/attribution">CARTO</a>',
        useCache: true,
        zIndex: 0
      }
    )

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

    reinicializarMapa() {
      this.map.remove()
      this.initMap()
      this.inicializarCamadaImportacao()
      this.carregarCamada();
    },

    inicializarCamadaImportacao() {
      //  console.log("inicializarCamadaImportacao()");
      // TODO - Limpar poligonos dessa camada do map
      this.camadaImportacao = {
        id: -1,
        name: 'Geometrias a importar',
        selected: true,
        children: []
      }
    },

    carregarCamada() {
      if(this.idReferenciado == null) return
      this.referencia = null
      // console.log('carregarCamada()')
      this.carregandoCamada = true
      if(this.idCamada != null && this.idCamada > 0) {
        let url = rotas.rotas().geo.camada.referencia.obter
        url = url.replace('[idCamada]', this.idCamada)
        url = url.replace('[idReferenciado]', this.idReferenciado)
        // console.log(url)


        return this.$http.get(url)
          .then(
              response => {
                this.camada = response.body.camada
                this.camada.children = []
                this.referencia = response.body.referencia
                this.carregarReferencia()
                this.carregandoCamada = false
              },
              error => {
                console.log(error)
                this.carregandoCamada = false
              }
          )
      }
    },

    carregarReferencia() {
      // console.log('carregarReferencia()')
      // console.log(this.referencia)
      if(this.referencia == null) return

      this.referencia.conteudoPopup = this.montarConteudoPopupDaReferencia(this.referencia)
      let feature = {
        id: this.referencia.id,
        name: this.referencia.titulo,
        popupContent: this.referencia.conteudoPopup,
        selected: true,
        type: this.referencia.poligonais.type,
        features: this.referencia.poligonais.geometries,
        coordinates: this.referencia.poligonais.coordinates,
      }
      let options = { color: 'green' }
      feature.leafletObject = this.criarLeafletObject(feature, options)
      this.camada.children.push(feature)
      this.atualizarElementosNoMapa()
      this.clicouZoomItemCamada(feature)
    },

    atualizarElementosNoMapa() {
      // console.log('atualizarElementosNoMapa')
      
      this.camada.children.forEach(function(elemento) {
        if (elemento.selected) {
          // console.log('addTo')
          elemento.leafletObject.addTo(this.map)
        } else {
          // console.log('remove')
          elemento.leafletObject.remove()
        }
      }.bind(this))
      

      this.camadaImportacao.children.forEach(function(elemento) {
        if (elemento.selected) {
          // console.log('addTo')
          elemento.leafletObject.addTo(this.map)
        } else {
          // console.log('remove')
          elemento.leafletObject.remove()
        }
      }.bind(this))

    },

    selecionouElementoCamada(itemDaArvore) {
      // console.log('selecionouElementoCamada')
      // console.log(itemDaArvore)
      itemDaArvore.selected = !itemDaArvore.selected
      if (itemDaArvore.selected) {
        itemDaArvore.leafletObject.addTo(this.map)
      } else {
        itemDaArvore.leafletObject.removeFrom(this.map)
      }
      this.atualizarElementosNoMapa()
    },

    clicouZoomItemCamada(itemDaArvore) {
      itemDaArvore.selected = true
      if(itemDaArvore.leafletObject) {
        this.map.flyToBounds(itemDaArvore.leafletObject.getBounds())
      }
      this.atualizarElementosNoMapa()
    },

    selecionouCamada(camada) {
      console.log('selecionouCamada')
      console.log(camada)
      if(isArray(camada.children)) {
        camada.children.forEach(function(elementoCamada) {
          elementoCamada.selected = !camada.selected
          this.selecionouElementoCamada(elementoCamada)
        }.bind(this))
      }
    },

    criarLeafletObject(feature, options = {}) {
      // console.log('criarLeafletObject()')
      // console.log(feature)
      switch (feature.type) {
        case 'MultiPolygon':
          return L.polygon(feature.coordinates, options)
              .bindPopup(feature.popupContent)
        
        case 'Polygon':
          return L.polygon(feature.coordinates, options)
              .bindPopup(feature.popupContent)

        case 'LineString':
          // console.log('LineString')
          // console.log(feature)
          return L.polyline(feature.coordinates, options)
            .bindPopup(feature.popupContent)

        case 'GeometryCollection':
          // console.log('GeometryCollection')
          // console.log(feature)
          let geometrias = []
          feature.features.forEach(geometria => {
            geometrias.push(this.criarLeafletObject(geometria, options))
          })
          return L.featureGroup(geometrias).bindPopup(feature.popupContent)

        default:
          console.log('feature.type "'+ feature.type + '" não suportado')
          break;
      }
    },

    handleFiles() {
      // console.log("handleFiles()")
        let uploadedFiles = this.$refs.files.files;
        for(var i = 0; i < uploadedFiles.length; i++) {
          let file = uploadedFiles[i]
          this.files.push(file);

          if (file.name.slice(-3) != 'zip'){
            this.$store.commit('sistema/alerta', 'Selecione um arquivo .zip')
            return;
          }          
          this.handleZipFile(file);
        }
    },

    handleZipFile(file) {
      // console.log("handleZipFile()")
      var reader = new FileReader();
      reader.onload = function() {
        if (reader.readyState != 2 || reader.error){
          console.log("error:")
          console.log(reader)
          return;
        } else {
          this.importarPoligonos(reader.result)
        }
      }.bind(this)
      reader.readAsArrayBuffer(file);
    },

    importarPoligonos(buffer) {
      // console.log("importarPoligonos()")
      this.inicializarCamadaImportacao()
      shp(buffer)
        .then(function(geojson) {
          // console.log("geojson")
          // console.log(geojson)
          let shapefile = L.shapefile(geojson)
          // console.log(shapefile)
          this.camada_id = 1000000000;
          shapefile.pm.findLayers().forEach(function(layer) {
            // console.log("layer")
            // console.log(layer)
            layer.feature.geometry.coordinates = this.converterLongLatParaLagLongs(layer.feature.geometry.coordinates)
            layer.conteudoPopup = this.montarConteudoPopupDaGeometria(layer.feature.properties)
            let feature = {
              id: this.camada_id,
              name: this.camada_id,
              popupContent: layer.conteudoPopup,
              type: layer.feature.geometry.type,
              selected: true,
              coordinates: layer.feature.geometry.coordinates,
            }
            feature.leafletObject = this.criarLeafletObject(feature, { color: 'red' })
            // console.log('this.camadaImportacao.children')
            // console.log(this.camadaImportacao.children)
            this.camadaImportacao.children.push(feature)
            this.camada_id++;
          }.bind(this))
          this.atualizarElementosNoMapa()
        }.bind(this));
      this.onResize()
    },

    montarConteudoPopupDaGeometria(properties) {
      // console.log(properties)
      var conteudo = '';
      for (var variable in properties) {
        // console.log(variable)
        conteudo += variable + ': ' + properties[variable] + '<br>'
      }
      return conteudo
    },

    montarConteudoPopupDaReferencia(referencia) {
      // console.log('montarConteudoPopupDaReferencia(referencia)')
      // console.log(referencia)
      var conteudo = referencia.rotulo;
      conteudo += '<h4>' + referencia.titulo + '</h4>'
      conteudo += '<small><i>' + referencia.subtitulo + '</i></small>'
      return conteudo
    },

    converterLongLatParaLagLongs(longLatArray) {
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

    salvarGeometrias() {
      // console.log('salvarGeometrias')
      var geometriasASalvar = []
      if(isArray(this.camadaImportacao.children)) {
        this.camadaImportacao.children.forEach(function(feature, f) {
          if(feature.selected) {
            geometriasASalvar.push(feature)
          }
        })
      }
      this.salvarGeometriasAPI(geometriasASalvar)
    },

    salvarGeometriasAPI(geometrias) {
      // console.log('salvarGeometriasAPI()')
        if(geometrias.length < 0) {
          this.$store.commit('sistema/alerta', 'Nenhuma geometria a ser salva')
          return
        }

        let jsonPostData = {
          idCamada: this.idCamada,
          idReferenciado: this.idReferenciado,
          geoJson : {
            'type' : 'FeatureCollection',
            'features' : []
          }
        }

        geometrias.forEach(geometria => {
          let feature = {
            'type' : 'Feature',
            'properties' : [],
            'geometry' : {
              'type' : geometria.type,
              'coordinates' : geometria.coordinates
            }
          }
          jsonPostData.geoJson.features.push(feature)
          // console.log('feature')
          // console.log(feature)
        });
        // console.log(jsonPostData)

        let url = rotas.rotas().geo.camada.referencia.criar        

        this.$http.post(url, jsonPostData)
            .then(
                response => {
                    // console.log(response)
                    this.$store.commit('sistema/mensagem', 'Geometrias salvas com sucesso!')
                    this.reinicializarMapa()
                },
                error => {
                    console.log(error.body)
                    this.$store.commit('sistema/alerta', error.body.message)
                }
            )
            // this.carregarItens()
    },

    botaoSalvarGeometriasSelecionadasDesativado() {

      if(this.idCamada == null || this.idCamada == 0 || this.idReferenciado == null) {
        return true
      }
      
      if(this.camadaImportacao == null || !isArray(this.camadaImportacao.children)) {
        return true
      }
      if(this.camadaImportacao.children.length <= 0) {
        return true
      }
      for(var f= 0; f < this.camadaImportacao.children.length; f++) {
          var feature = this.camadaImportacao.children[f]
          if(feature.selected) {
            return false
          }
      }
      return true
    },

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
      var divMap = document.getElementsByClassName('map')[0]
      divMap.style.height = (window.innerHeight - 70) + 'px'

      var painelCamadas = document.getElementById('painelCamadas')
      if(painelCamadas != null) {
        painelCamadas.style.height = (window.innerHeight - 232) + 'px'
      }
    }

  },

  mounted () {
    this.onResize()
    this.initMap()
    this.inicializarCamadaImportacao();
    this.carregarCamada();
  },

  watch: {
    atualizarMapa(val) {
      setTimeout(function() {
        this.map.invalidateSize(true)
      }.bind(this), 1000)
    }
  }

}
</script>

<style scoped>

  #map {
    height: 512px;
    overflow: hidden;
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


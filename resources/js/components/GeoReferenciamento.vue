<template>
    <v-container fill-height fluid grid-list>
      <v-layout align-start justify-start row wrap>
        <!-- MAPA -->
        <v-flex d-flex col xs12>
          <div id="map" class="map"></div>
        </v-flex>
        <!-- Fim de MAPA -->

        <!-- Painel -->
        <!-- Coluna Camadas -->
        <v-flex d-flex col xs12 md7>
          <v-container>  
            <v-flex d-flex row xs12>
              <h3>Camadas</h3>
            </v-flex>
            <v-flex d-flex row xs12>
              <v-list dense>
                <v-list-group
                  v-for="camada in camadas"
                  :key="camada.id"
                  v-model="camada.open"
                  :prepend-icon="camada.icon"
                  no-action
                >
                  <template v-slot:activator>
                    <v-list-tile>
                      <v-list-tile-action>
                        <v-checkbox dense
                            v-model="camada.selected"
                            :label="camada.name" @change="selecionouCamada(camada)"
                          ></v-checkbox>
                      </v-list-tile-action>
                    </v-list-tile>
                  </template>

                  <v-list-tile
                    v-for="elementoCamada in camada.children"
                    :key="elementoCamada.id"
                    @click="selecionouElementoCamada(elementoCamada)"
                  >
                    <v-list-tile-action>
                      <v-icon v-if="elementoCamada.selected">check_box</v-icon>
                      <v-icon v-else>check_box_outline_blank</v-icon>
                    </v-list-tile-action>

                    <v-list-tile-content>
                      <v-list-tile-title>{{ elementoCamada.name }}</v-list-tile-title>
                    </v-list-tile-content>                
                    
                  </v-list-tile>
                </v-list-group>
              </v-list>
            </v-flex>
          </v-container>
        </v-flex>
        <!-- Fim da Coluna Camadas -->

        <!-- Coluna Importação -->
        <v-flex d-flex col xs12 md5>
          <v-container>
            <v-flex d-flex row xs12>
              <h3>Importar Shapefile</h3>
            </v-flex>
            <v-flex d-flex row xs12>
              <input type="file" id="files" ref="files" v-on:change="handleFiles()" value="Importar shapefile (.shp)"/>
            </v-flex>
            <v-flex d-flex row xs12 v-if="camadaImportacao">
              <v-list dense>
                <v-list-group v-if="camadaImportacao.children.length > 0"
                  prepend-icon="layers"
                  no-action
                >
                  <template v-slot:activator>
                    <v-list-tile>
                      <v-list-tile-action>
                        <v-checkbox dense color="red"
                            v-model="camadaImportacao.selected"
                            :label="camadaImportacao.name" @change="selecionouCamada(camadaImportacao)"
                          ></v-checkbox>
                      </v-list-tile-action>
                    </v-list-tile>
                  </template>

                  <v-list-tile
                    v-for="elementoCamada in camadaImportacao.children"
                    :key="elementoCamada.id"
                    @click="selecionouElementoCamada(elementoCamada)"
                  >
                    <v-list-tile-action>
                      <v-icon v-if="elementoCamada.selected">check_box</v-icon>
                      <v-icon v-else>check_box_outline_blank</v-icon>
                    </v-list-tile-action>

                    <v-list-tile-content>
                      <v-list-tile-title v-html="elementoCamada.name"></v-list-tile-title>
                    </v-list-tile-content>                
                    
                  </v-list-tile>
                </v-list-group>
              </v-list>
            </v-flex>
          </v-container>
        </v-flex>
        <!-- Fim da Coluna Importação -->
            
      </v-layout>
    </v-container>
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
      tileLayer: null,
      camadas: [],
      camadaImportacao: null,
      files: []
    }
  },
  props: {
    idCamada: {
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
    this.inicializarCamadas()
    this.carregarCamada();
  },

  methods: {
    initMap () {
      this.map = L.map('map', {
        crs: L.CRS.EPSG3857
      }).setView([-28.1, -47.5], 7);
      /*
      this.map.pm.addControls({
        position: 'topleft',
      });
      */
     
     this.tileLayer = L.tileLayer(
       'https://cartodb-basemaps-{s}.global.ssl.fastly.net/rastertiles/voyager/{z}/{x}/{y}.png', {
         maxZoom: 18,
          attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>, &copy; <a href="https://carto.com/attribution">CARTO</a>',
          useCache: true,
          zIndex: 0
        })
     this.tileLayer.addTo(this.map)
    },

    inicializarCamadas() {
      this.camadas = []
      this.inicializarCamadaImportacao();
    },

    inicializarCamadaImportacao() {
      // TODO - Limpar poligonos dessa camada do map
      this.camadaImportacao = {
        id: -1,
        name: 'Geometrias a importar',
        selected: true,
        children: []
      }
    },

    carregarCamada() {
      this.carregandoCamada = true
      if(this.idCamada != null && this.idCamada > 0) {
        let url = rotas.rotas().geo.camada.listar + '/' + this.idCamada
        return this.$http.get(url)
          .then(
              response => {
                response.body.forEach(element => {
                  let camada = {
                    id: element.id,
                    name: element.titulo,
                    open: false,
                    selected: true,
                    icon: 'layers',
                    children: [],
                  }
                  this.carregarElementosCamada(camada)
                  this.camadas.push(camada)
                })
                this.carregandoCamada = false
              },
              error => {
                console.log(error)
                this.carregandoCamada = false
              }
          )
      }
    },

    async carregarElementosCamada(camada) {
      // console.log('carregarElementosCamada')
      camada.children = []
      this.carregandoCamada = true
      let url = rotas.rotas().geo.camada.referencia.listar
      url = url.replace('[idCamada]', camada.id)
      return this.$http.get(url)
        .then(
          response => {
              response.body.forEach(element => {
                let feature = {
                  id: element.id,
                  name: element.titulo,
                  selected: true,
                  type: 'polygon', // element.poligonais.type,
                  coords: element.poligonais.coordinates[0],
                }
                feature.leafletObject = this.criarLeafletObject(feature)
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
    },

    atualizarElementosNoMapa() {
      // console.log('atualizarElementosNoMapa')
      this.camadas.forEach(function(camada) {
        camada.children.forEach(function(elemento) {
          if (elemento.selected) {
            // console.log('addTo')
            elemento.leafletObject.addTo(this.map)
          } else {
            // console.log('remove')
            elemento.leafletObject.remove()
          }
        }.bind(this))
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
    },

    selecionouCamada(camada) {
      // console.log('selecionouCamada')
      // console.log(camada)
      if(isArray(camada.children)) {
        camada.children.forEach(function(elementoCamada) {
          elementoCamada.selected = !camada.selected
          this.selecionouElementoCamada(elementoCamada)
        }.bind(this))
      }
    },

    criarLeafletObject(feature, options = {}) {
      // console.log('criarLeafletObject')
      // console.log(feature)
      if(feature.type == 'polygon') {
        return L.polygon(feature.coords, options).bindPopup(feature.name)
      } else {
        console.log('feature.type "'+ feature.type + '" não suportado')
      }
    },

    handleFiles() {
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
      var reader = new FileReader();
      reader.onload = function() {
        if (reader.readyState != 2 || reader.error){
          return;
        } else {
          this.importarPoligonos(reader.result)
        }
      }.bind(this)
      reader.readAsArrayBuffer(file);
    },

    importarPoligonos(buffer) {
      this.inicializarCamadaImportacao()
      shp(buffer)
        .then(function(geojson) {
          let shapefile = L.shapefile(geojson)
          // console.log(shapefile)
          this.camada_id = 1000000000;
          shapefile.pm.findLayers().forEach(function(layer) {
            layer.feature.geometry.coordinates = this.converterLongLatParaLagLongs(layer.feature.geometry.coordinates)
            layer.conteudoPopup = this.montarConteudoPopupDaGeometria(layer.feature.properties)
            let feature = {
              id: this.camada_id,
              name: layer.conteudoPopup,
              type: 'polygon', // element.poligonais.type,
              selected: true,
              coords: layer.feature.geometry.coordinates,
            }
            feature.leafletObject = this.criarLeafletObject(feature, { color: 'red' })
            // console.log(feature.leafletObject)
            this.camadaImportacao.children.push(feature)
            this.camada_id++;
          }.bind(this))
          this.atualizarElementosNoMapa()
        }.bind(this));
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
    }

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

.dropbox {
    outline: 2px dashed grey; /* the dash box */
    outline-offset: -10px;
    background: lightcyan;
    color: dimgray;
    padding: 10px 10px;
    min-height: 200px; /* minimum height */
    position: relative;
    cursor: pointer;
  }

  .input-file {
    opacity: 0; /* invisible but it's there! */
    width: 100%;
    height: 200px;
    position: absolute;
    cursor: pointer;
  }

  .dropbox:hover {
    background: lightblue; /* when mouse over to the drop zone, change color */
  }

  .dropbox p {
    font-size: 1.2em;
    text-align: center;
    padding: 50px 0;
  }
</style>


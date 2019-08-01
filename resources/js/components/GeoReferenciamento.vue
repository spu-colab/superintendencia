<template>
    <v-container fluid grid-list-md>
        <v-layout row wrap>
            <v-flex d-flex xs10>
              <div id="map" class="map"></div>
            </v-flex>
            <v-flex d-flex xs2>
              <v-container>
                <v-layout>
                  <v-checkbox  v-for="layer in layers" :key="layer.id" 
                    v-model="layer.active" 
                    @change="layerChanged(layer.id, layer.active)" 
                    class="mx-2" :label="layer.name"></v-checkbox>
                </v-layout>
                <!--
                <v-layout row wrap>
                  <input type="file" id="files" ref="files" v-on:change="handleFiles()"/>
                  <p>
                      Drop your files here <br>or click to search
                  </p>
                </v-layout>
                -->
              </v-container>

            </v-flex>
        </v-layout>
    </v-container>
</template>

<script>
import rotas from './../rotas-servico.js'

import L from 'leaflet'
import 'leaflet/dist/leaflet.css'
import 'leaflet.pm/dist/leaflet.pm.min'
import 'leaflet.pm/dist/leaflet.pm.css'

require('./../shp')
require('./../leaflet.shpfile')

export default {
  data: function () {
    return {
      isInitial: true,
      isSaving: false,
      fileCount: 0,
      map: null,
      tileLayer: null,
      layers: [
        /*
        {
          id: 0,
          name: 'Imóveis',
          active: false,
          features: [
            {
              id: 2,
              name: 'City of St. Louis',
              type: 'polygon',
              coords: [
                [-27.1, -47.5000001],
                [-27.1, -48.6000001],
                [-28.4, -47.6000010],
                [-28.4, -47.5000010]
              ]
            }
          ]
        },
        {
          id: 1,
          name: 'Demandas Judiciais',
          active: false,
          features: [
            {
              id: 3,
              name: 'City of St. Louis',
              type: 'marker',
              coords: [-27.1, -47.5000001]
            }
          ]
        }
        */
      ],
      files: []
    }

  },
  mounted () {
    this.initMap()
    this.carregarCamadas();
    // this.initLayers()
  },
  methods: {
    carregarCamadas() {
      this.carregandoCamadas = true
      this.$http.get(rotas.rotas().geo.camada.listar)
        .then(
            response => {
              response.body.forEach(element => {
                let layer = {
                  id: element.id,
                  name: element.titulo,
                  active: false,
                  features: []
                }
                  this.layers.push(layer)
              })
              this.carregandoCamadas = false
            },
            error => {
              console.log(error)
              this.carregandoCamadas = false
            }
        )
    },
    initMap () {
      this.map = L.map('map').setView([-28.1, -47.5], 7)
      //*
      this.map.pm.addControls({
        position: 'topleft',
        // drawCircle: false,
      });
      //*/

      this.tileLayer = L.tileLayer(
        'https://cartodb-basemaps-{s}.global.ssl.fastly.net/rastertiles/voyager/{z}/{x}/{y}.png', {
          maxZoom: 18,
          attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>, &copy; <a href="https://carto.com/attribution">CARTO</a>'
        })

      this.tileLayer.addTo(this.map)
    },

    initLayers () {
      this.layers.forEach((layer) => {
        const markerFeatures = layer.features.filter(feature => feature.type === 'marker')
        const polygonFeatures = layer.features.filter(feature => feature.type === 'polygon')

        markerFeatures.forEach((feature) => {
          feature.leafletObject = L.marker(feature.coords).bindPopup(feature.name)
        })

        polygonFeatures.forEach((feature) => {
          feature.leafletObject = L.polygon(feature.coords).bindPopup(feature.name)
        })
      })
    },

    layerChanged (layerId, active) {
      const layer = this.layers.find(layer => layer.id === layerId)
      if (layer) {
        this.carregandoCamada = true
        let url = rotas.rotas().geo.camada.referencia.listar
        url = url.replace('[idCamada]', layer.id)
        this.$http.get(url)
          .then(
              response => {
                response.body.forEach(element => {
                  let feature = {
                    id: element.id,
                    name: element.titulo,
                    type: 'polygon',
                    coords: [
                      [-27.1, -47.5000001],
                      [-27.1, -48.6000001],
                      [-28.4, -47.6000010],
                      [-28.4, -47.5000010]
                    ]
                  }
                    layer.feature.push(feature)
                })
                this.carregandoCamada = false
              },
              error => {
                console.log(error)
                this.carregandoCamada = false
              }
          )
        layer.features.forEach((feature) => {
          console.log(feature)
          // console.log(active)
          if (active) {
            feature.leafletObject.addTo(this.map)
          } else {
            feature.leafletObject.removeFrom(this.map)
          }
        })
      } else {
        console.log('Camada não encontrada')
      }
    },

    handleFiles() {
        let uploadedFiles = this.$refs.files.files;
        console.log(uploadedFiles)
        for(var i = 0; i < uploadedFiles.length; i++) {
          let file = uploadedFiles[i]
          console.log('uploaded file: ')
          console.log(file)
          this.files.push(file);

          if (file.name.slice(-3) != 'zip'){
            this.$store.commit('sistema/alerta', 'Selecione um arquivo .zip')
            return;
          }          
          this.handleZipFile(file);
        }
        // this.getImagePreviews();
    },

    handleZipFile(file) {
      var reader = new FileReader();
      reader.onload = function() {
        if (reader.readyState != 2 || reader.error){
          return;
        } else {
          this.convertToLayer(reader.result)
        }
      }.bind(this)
      reader.readAsArrayBuffer(file);
    },

    convertToLayer(buffer){
          // console.log(buffer)
          shp(buffer)
            .then(function(geojson) {	//More info: https://github.com/calvinmetcalf/shapefile-js
              console.log('geojson:')
              console.log(geojson)

             
             // this.initLayers();
              var layer = L.shapefile(geojson);
              console.log('layer:');
              console.log(layer);
              layer.addTo(this.map); //More info: https://github.com/calvinmetcalf/leaflet.shapefile
            }.bind(this));
    }
  }
}
</script>

<style>
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


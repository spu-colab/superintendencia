<template>
    <v-container fluid grid-list-md>
        <v-layout row wrap>
            <v-flex d-flex xs10>
              <div id="map" class="map"></div>
            </v-flex>
            <v-flex d-flex xs2>
              <v-container>
                <v-layout>
                  <div  v-for="layer in layers" :key="layer.id">
                    <v-checkbox v-model="layer.active" 
                      @change="layerChanged(layer.id, layer.active)" 
                      class="mx-2" :label="layer.name">
                    </v-checkbox>

                    <v-checkbox  v-for="feature in layer.features" :key="feature.id" 
                      v-model="feature.active" 
                      @change="featureChanged(layer.id, feature.id)" 
                      class="mx-2" :label="feature.name"></v-checkbox>
                  </div>
                    


                </v-layout>
                
                <v-layout row wrap>
                  <input type="file" id="files" ref="files" v-on:change="handleFiles()"/>
                  <p>
                      Drop your files here <br>or click to search
                  </p>
                </v-layout>
                
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

//require('./../shp')
import shp from './../shp'
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

        // ST_GeoFromText('MULTIPOLYGON(((0 0,11 0,12 11,0 9,0 0)),((3 5,7 4,4 7,7 7,3 5)))')
        // UPDATE `geo_referencia` SET `poligonais` = GeomFromText('MULTIPOLYGON(((4386527.743637 6825410.124561, 4386527.743637 6825410.134561, 4386527.753637 6825410.134561)), 5641') WHERE `geo_referencia`.`id` = 1;
        // UPDATE `geo_referencia` SET `poligonais` = GeomFromText('MULTIPOLYGON(((4386527.743637 6825410.124561, 4386527.743637 6825410.134561, 4386527.753637 6825410.134561))),5641'), `created_at` = NULL, `updated_at` = NULL WHERE `geo_referencia`.`id` = 1 
        // 'MULTIPOLYGON(((4386527.743637 6825410.124561,4386527.743637 6825410.124761,4386527.743837 6825410.124761,4386527.743637 6825410.124561)))',5641
        MULTIPOLYGON(((-5400581.80 -3196290.77, -5400581.80 -3196390.77, -5400681.80 -3196390.77,-5400681.80 -3196290.77))),3857
        
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
    initMap () {
      this.map = L.map('map', {
        crs: L.CRS.EPSG3857
      }).setView([-28.1, -47.5], 7)
      this.map.pm.addControls({
        position: 'topleft',
      });

      this.tileLayer = L.tileLayer(
        'https://cartodb-basemaps-{s}.global.ssl.fastly.net/rastertiles/voyager/{z}/{x}/{y}.png', {
          maxZoom: 18,
          attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>, &copy; <a href="https://carto.com/attribution">CARTO</a>'
        })

      this.tileLayer.addTo(this.map)
    },

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

    layerChanged (layerId, active) {
      const layer = this.layers.find(layer => layer.id === layerId)
      if (layer) {
        layer.features = []
        this.carregandoCamada = true
        let url = rotas.rotas().geo.camada.referencia.listar
        url = url.replace('[idCamada]', layer.id)
        this.$http.get(url)
          .then(
            response => {
                response.body.forEach(element => {
                  let feature = {
                    id: element.id,
                    active: true,
                    name: 'element.titulo',
                    type: 'polygon', // element.poligonais.type,
                    coords: element.poligonais.coordinates[0],
                  }
                  feature.leafletObject = this.criarLeafletObject(feature)
                  layer.features.push(feature)
                  this.featureChanged(layer.id, feature.id)
                })
                this.carregandoCamada = false
              },
              error => {
                console.log(error)
                this.carregandoCamada = false
              }
          )
      } else {
        console.log('Camada não encontrada')
      }
    },

    criarLeafletObject(feature) {
      if(feature.type == 'polygon') {
        console.log(feature.coords)
        return L.polygon(feature.coords).bindPopup(feature.name)
      }
      // TODO temporário
      return L.polygon(feature.coords).bindPopup(feature.name)
    },

    featureChanged(layerId, featureId) {
      const layer = this.layers.find(layer => layer.id === layerId)
      const feature = layer.features.find(feature => feature.id === featureId)
      console.log(this.layers)
      if (feature.active) {
        console.log(feature.leafletObject)
        feature.leafletObject.addTo(this.map)
      } else {
        feature.leafletObject.removeFrom(this.map)
      }
    },

    /*
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
    */

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

  },
  watch: {
    layers() {
      console.log(this.layers.length)
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


<template>
    <div id="mapa"></div>
</template>

<script>
import LeafletSimpleSet from '@spu-colab/leaflet-simple-set'

export default {

    data() {
        return {
            geoVis: null,

            opcoesMapa: {
                "center": [-27.7000, -50.5000],
                "zoom": 7,
            },

            mapasBase: [
                {
                    url: "http://sigsc.sc.gov.br/sigserver/SIGSC/wms",
                    wms: true,
                    active: true,
                    config: {
                        label: "SIG/SC",
                        maxNativeZoom: 19,
                        maxZoom: 100,
                        layers: "OrtoRGB-Landsat-2012",
                        iconURL: "sig-sc.png"
                    }
                }, 
                {
                    url: "http://server.arcgisonline.com/ArcGIS/rest/services/World_Street_Map/MapServer/tile/{z}/{y}/{x}.png", 
                    active: true,
                    config: {
                        label: "World Street Map",
                        maxZoom: 18,
                        attribution: "Map data © <a href='http://openstreetmap.org'>OpenStreetMap</a> contributors"
                    }
                },
            ],

            geoJSONs: [
                {
                    title: "Municípios",
                    group: "Brasil",
                    url: "https://raw.githubusercontent.com/lfpdroubi/SPUData/master/municipios.geojson",
                    callbacks: {
                        style: LeafletSimpleSet.helpers.areaStyle,
                        onEachFeature: function( feature, layer ){
                            layer.bindPopup(
                            "<b>Município: </b>" + feature.properties.nome + "<br>" +
                            "<b>Geocodigo: </b>" + feature.properties.geocodigo + "<br>" +
                            "<b>Gestão de Praias: </b>" + LeafletSimpleSet.helpers.gestaoPraiaStatus(feature)  + "<br>" +
                            "<b>NUP: </b>" + "<a href=" + feature.properties.nup_gpraia + ">Link para portaria.</a>"
                            );
                            layer.bindTooltip(feature.properties.nome,{
                            permanent: false
                            });
                        }
                    }
                },
            ]
        }
    },

    methods: {

        inicializar() {
            this.geoVis = new LeafletSimpleSet('mapa', this.opcoesMapa)
            this.geoVis.addMaps(this.mapasBase)
            this.geoVis.loadGeoJSONCollection(this.geoJSONs)
            this.geoVis.initialize()
        }

    },

    mounted() {
        this.inicializar()
    }
    
}
</script>

<style scoped>
#mapa {
    border: 1px solid black;
    width: 100%;
    height: 100%;
    min-height: 600px;
    overflow: hidden;
}
</style>
require('jquery')
import L from 'leaflet'

require('leaflet-basemaps')
import 'leaflet-basemaps/L.Control.Basemaps.css'

require('leaflet-minimap')
import 'leaflet-minimap/src/Control.MiniMap.css'

require('leaflet-groupedlayercontrol')
import 'leaflet-groupedlayercontrol/src/leaflet.groupedlayercontrol.css'




export default class Geovisualizador {

    constructor(idDivDoMapa, opcoesMapa = {}, mapas = {}) {
        this.divDoMapa = document.getElementById(idDivDoMapa);
        if(!this.divDoMapa) {
            throw new Error('Elemento para renderização do mapa não foi encontrado.')
        }
        this.opcoesMapaLeaflet = opcoesMapa
        this.mapas = mapas
        this.inicializarMapa();
    }

    inicializarMapa() {
        if(this.mapa == null) {
            this.mapa = L.map('mapGeo', this.opcoesMapaLeaflet); // .setView([-28.1, -47.5], 7);
            this.carregarBaseMaps()
        }
    }

    carregarBaseMaps() {
        
        this.mapa.addControl(L.control.basemaps({
            basemaps: this.getMapasBase(),
            tileX: 0,  // tile X coordinate
            tileY: 0,  // tile Y coordinate
            tileZ: 1   // tile zoom level
        }))
        // */

        new L.Control.MiniMap(this.getMapasBase()[1], {
            position: 'topright',
            toggleDisplay: true
          }
        ).addTo(this.mapa);

        let groupedOverlays = {

        }

        
    }

    carregarGrupos() {
        // console.log('carregarGrupos')
        // console.log(this.gruposCamadas)
        if(!this.gruposCamadas) {
            this.gruposCamadas = {}
        }
        this.layerControl = L.control.groupedLayers(null, this.gruposCamadas, {
            position: 'topleft',
            groupCheckboxes: true
        })  
        this.layerControl.addTo(this.mapa);
    }

    criarVetor(feature, options = {}) {
        // console.log('criarLeafletObject()')
        // console.log(feature)
        if(feature.coordinates == null) {
            feature.coordinates = feature.coords
        }
        switch (feature.type) {
            case 'MultiPolygon':
                return L.polygon(feature.coordinates, options).bindPopup(feature.popupContent)

            case 'Polygon':
                return L.polygon(feature.coordinates, options).bindPopup(feature.popupContent)

            case 'LineString':
                return L.polyline(feature.coordinates, options).bindPopup(feature.popupContent)

            case 'GeometryCollection':
                // console.log('GeometryCollection')
                // console.log(feature)
                let geometrias = []
                feature.features.forEach(geometria => {
                    geometrias.push(this.criarVetor(geometria, options))
                })
                return L.featureGroup(geometrias).bindPopup(feature.popupContent)

            default:
                console.log('feature.type "'+ feature.type + '" não suportado')
        }
    }

    getTileLayers() {
        let mapasBase = {}
        this.mapas.forEach(mapa => {
            mapasBase[mapa.configuracoes.label] = mapa.wms ? 
                L.tileLayer.wms(mapa.url, mapa.configuracoes) : 
                L.tileLayer(mapa.url, mapa.configuracoes)
        })
        return mapasBase
    }
    
    getMapasBase() {
        let mapasBase = []
        // console.log(this.mapas)
        this.mapas.forEach(mapa => {
            if(mapa.ativo) {
                mapasBase.push(mapa.wms ? 
                    L.tileLayer.wms(mapa.url, mapa.configuracoes) : 
                    L.tileLayer(mapa.url, mapa.configuracoes))
            }
        })
        return mapasBase
    }

    getMapa() {
        return this.mapa
    }

    carregarGeoJson(camadaGeoJson) {
        let callbackSucesso = console.log
        let callbackFalha = console.log
        if(camadaGeoJson.callbacks) {
            callbackSucesso = camadaGeoJson.callbacks.sucesso
            callbackFalha = camadaGeoJson.callbacks.falha
        }
        $.ajaxSetup({async: false})
        console.log('Carregando camada ' + camadaGeoJson.titulo)
        $.get(camadaGeoJson.url, null, callbackSucesso, "json")

            .done(this.criarLeafletGeoJson.bind(this, camadaGeoJson))

            .fail(callbackFalha)

            .always(() => {
                console.log('Camada ' + camadaGeoJson.titulo + ' carregada.')
            })
    }

    inserirCamadaNoGrupo(camadaGeoJson, leafletVector) {
        // console.log("inserirCamadaNoGrupo")
        let nomeGrupo = camadaGeoJson.grupo ? camadaGeoJson.grupo : "Outros"
        if(this.gruposCamadas == null) {
            this.gruposCamadas = {}
        }
        if(this.gruposCamadas[nomeGrupo] == null) {
            this.gruposCamadas[nomeGrupo] = {}
        }
        this.gruposCamadas[nomeGrupo][camadaGeoJson.titulo] = leafletVector
        // console.log(this.gruposCamadas)
    }

    inserirVetorNoGrupo(leafletVector, titulo, grupo) {
        this.layerControl.addOverlay(leafletVector, titulo, grupo)
    }

    carregarGeoJsons(geojsons) {
        if(geojsons == null || !Array.isArray(geojsons)) {
            throw new Error('Geovisualizador.carregarGeoJson() espera um array como parâmetro')
        }
        geojsons.forEach(geojson => {
            this.carregarGeoJson(geojson)
        })
    }

    criarLeafletGeoJson(camadaGeoJson, dadosGeoJson) {
        // console.log('criarLeafletGeoJson')
        let leafletGeoJson = L.geoJSON(dadosGeoJson, {
            snapIgnore : true,
            style: camadaGeoJson.callbacks ?
                (camadaGeoJson.callbacks.estilo ? camadaGeoJson.callbacks.estilo(dadosGeoJson) : null)
                : null,
            onEachFeature: camadaGeoJson.callbacks ? 
                (camadaGeoJson.callbacks.onEachFeature ? camadaGeoJson.callbacks.onEachFeature : null)
                : null
        })
        this.inserirCamadaNoGrupo(camadaGeoJson, leafletGeoJson)
        if(camadaGeoJson.ativa) {
            leafletGeoJson.addTo(this.mapa)
        }
        return leafletGeoJson
    }

}
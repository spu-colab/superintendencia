require('jquery')

import 'leaflet/dist/leaflet.css'
import 'leaflet-groupedlayercontrol/src/leaflet.groupedlayercontrol.css'
import 'leaflet-minimap/src/Control.MiniMap.css'
import 'leaflet-basemaps/L.Control.Basemaps.css'
import 'leaflet-search/dist/leaflet-search.src.css'

import L from 'leaflet'
require('leaflet-groupedlayercontrol')
require('leaflet-minimap')
require('leaflet-basemaps')
require('leaflet-search')



export default class LeafletSimpleSet {

    constructor(divId, options = {}) {
        this.successCallback = console.log
        this.failCallback = console.log
        if(divId == null) {
            throw new Error('divId argument cannot be null')
        }
        this._divId = divId
        this._mapDiv = document.getElementById(this._divId);
        if(!this._mapDiv) {
            throw new Error('no div found for id ' + this._divId)
        }

        if(options == null) {
            throw new Error('options argument cannot be null')
        }
        
        if(typeof options !== 'object') {
            throw new Error('options must be an Object')
        }
        this._options = options

        this._maps = []
        this._map = null
    }

    addMap(map) {
        this._maps.push(map)
    }

    addMaps(mapCollection) {
        if(mapCollection == null || !Array.isArray(mapCollection)) {
            throw new Error('mapCollection must be a not empty Array')
        }
        mapCollection.forEach(map => {
            this.addMap(map)
        })

    }

    initialize() {
        // console.log('initialize')
        if(this._map == null) {
            this._map = L.map(this._divId, this._options); // .setView([-28.1, -47.5], 7);
            this.assembleBaseMapsControl()
            this.assembleMiniMapControl()
            this.assembleLayerGroupsControl()

            // this.assembleSearchControl()
        }
    }

    assembleBaseMapsControl() {
        // console.log('assembleBaseMapsControl')
        let baseMaps = this.filterActiveBaseMaps()
        baseMaps = baseMaps.map(this.createLeafletTileLayer)
        if(!Array.isArray(baseMaps) || baseMaps.length == 0) {
            console.log('No basemap provided')
            return
        }
        
        this._map.addControl(L.control.basemaps({
            basemaps: baseMaps,
            tileX: 0,  // tile X coordinate
            tileY: 0,  // tile Y coordinate
            tileZ: 1   // tile zoom level
        }))
    }

    assembleMiniMapControl() {
        // console.log('assembleMiniMapControl');
        if(this.filterActiveBaseMaps().length == 0) {
            console.log('No basemap provided')
            return
        }

        let miniMap = new L.Control.MiniMap(
            this.createLeafletTileLayer(this.filterActiveBaseMaps()[0])
            , {
            position: 'topright',
            toggleDisplay: true
          })
        // console.log(miniMap)
        miniMap.addTo(this._map);
        
    }

    assembleLayerGroupsControl() {
        // console.log('assembleLayerGrouControlps')
        // console.log(this._layerGroups)
        if(!this._layerGroups) {
            this._layerGroups = {}
        }
        this._layerControl = L.control.groupedLayers(null, this._layerGroups, {
            position: 'topleft',
            groupCheckboxes: true
        })  
        this._layerControl.addTo(this._map);
    }

    addToLayerGroup(geoJSONLayer, leafletVector) {
        // console.log("addToLayerGroup")
        // console.log(geoJSONLayer)
        let groupName = geoJSONLayer.group ? geoJSONLayer.group : "Others"
        if(this._layerGroups == null) {
            this._layerGroups = {}
        }
        if(this._layerGroups[groupName] == null) {
            this._layerGroups[groupName] = {}
        }
        this._layerGroups[groupName][geoJSONLayer.title] = leafletVector
        // console.log(this._layerGroups)
    }

    createLeafletVector(feature, options = {}) {
        // console.log('createLeafletVector()')
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
                    geometrias.push(this.createLeafletVector(geometria, options))
                })
                return L.featureGroup(geometrias).bindPopup(feature.popupContent)

            default:
                console.log('feature.type "'+ feature.type + '" não suportado')
        }
    }

    getTileLayers() {
        let baseMaps = {}
        if(Array.isArray(this._maps)) {
            this._maps.forEach(map => {
                baseMaps[map.config.label] = map.wms ? 
                    L.tileLayer.wms(map.url, map.config) : 
                    L.tileLayer(map.url, mapa.config)
            })
        }
        return baseMaps
    }

    
    filterActiveBaseMaps() {
        if(!Array.isArray(this._maps)) return []
        return this._maps.filter(map => {
            return map.active == null || map.active
        })
    }

    createLeafletTileLayer(map) {
        return map.wms ? 
            L.tileLayer.wms(map.url, map.config) : 
            L.tileLayer(map.url, map.config)
    }

    loadGeoJSON(geoJSONLayer) {
        let successCallback = this.successCallback
        let failCallback = this.failCallback
        if(geoJSONLayer.callbacks) {
            successCallback = geoJSONLayer.callbacks.sucesso
            failCallback = geoJSONLayer.callbacks.falha
        }
        $.ajaxSetup({async: false})
        // console.log('Loading "' + geoJSONLayer.title + '" layer...')
        $.get(geoJSONLayer.url, null, successCallback, "json")

            .done(this.createLeafletGeoJSON.bind(this, geoJSONLayer))

            .fail(this.failCallback("Error"))

            .always(() => {
                this.successCallback('Layer "' + geoJSONLayer.title + '" loaded')
                console.log('Layer "' + geoJSONLayer.title + '" loaded')
            })
    }

    loadGeoJSONCollection(geoJSONCollection) {
        if(geoJSONCollection == null || !Array.isArray(geoJSONCollection)) {
            throw new Error('geoJSONCollection must be a not empty Array')
        }
        geoJSONCollection.forEach(geoJSON => {
            this.loadGeoJSON(geoJSON)
        })
    }

    createLeafletGeoJSON(geoJSONLayer, geoJsonData) {
        // console.log('createLeafletGeoJSON')
        let leafletGeoJson = L.geoJSON(geoJsonData, {
            snapIgnore : true,
            searchAttribute: geoJSONLayer.searchAttribute,
            style: geoJSONLayer.callbacks ?
                (geoJSONLayer.callbacks.style ? geoJSONLayer.callbacks.style(geoJsonData) : null)
                : null,
            onEachFeature: geoJSONLayer.callbacks ? 
                (geoJSONLayer.callbacks.onEachFeature ? geoJSONLayer.callbacks.onEachFeature : null)
                : null
        })
        this.addToLayerGroup(geoJSONLayer, leafletGeoJson)
        //*
        if(geoJSONLayer.active && this._map != null) {
            leafletGeoJson.addTo(this._map)
        }
        //*/
        return leafletGeoJson
    }

    /*
    inserirVetorNoGrupo(leafletVector, titulo, grupo) {
        this._layerControl.addOverlay(leafletVector, titulo, grupo)
    }
    */

    assembleSearchControl() {
        // console.log('assembleSearchControl')
        let groupName = "Limites Territoriais"
        let layerName = "América Latina"
        let geoJSON = this._layerGroups[groupName][layerName]
        let layersArray = new Array()
        for(let key in geoJSON._layers) {
            layersArray.push(geoJSON._layers[key])
        }

        var searchAttribute = geoJSON.options.searchAttribute
        let searchLayer = L.layerGroup(layersArray)

        var searchControl = new L.Control.Search({
            layer: searchLayer,
            propertyName: searchAttribute,
            marker: false,
            moveToLocation: function(latlng, title, map) {
                //map.fitBounds( latlng.layer.getBounds() );
                var zoom = map.getBoundsZoom(latlng.layer.getBounds());
                map.setView(latlng, zoom); // access the zoom
            },
            buildTip: function(text, val) {
                return '<a href="#" class=""><i>' + groupName + ' - ' + layerName + '</i> : <b>' + text + '</b></a>';
            },
        });
        
        // console.log(searchControl)
        searchControl.addTo(this._map);
    }

    setSuccessCallback(callback) {
        this.successCallback = callback
    }

    setFailCallback(callback) {
        this.failCallback = callback
    }

    getMap() {
        return this._map
    }

}
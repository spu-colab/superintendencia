import LeafletSimpleSet from './index';
import './style.css';
import setup from './setup'

console.log(LeafletSimpleSet)

//*
var divMap = document.createElement("DIV")
divMap.id = "map"
document.body.appendChild(divMap);
//*/

var GeoVis = new LeafletSimpleSet("map", setup.config)

// Its possible add one map at a time...
/*
GeoVis.addMap({
    url: "http://server.arcgisonline.com/ArcGIS/rest/services/World_Street_Map/MapServer/tile/{z}/{y}/{x}.png", 
    active: true,
    config: {
        label: "World Street Map",
        maxZoom: 18,
        attribution: "Map data © <a href='http://openstreetmap.org'>OpenStreetMap</a> contributors"
    }
})
*/

// ... or a collection of them
GeoVis.addMaps(setup.maps)

// You can upload one geoJSON file at a time...
GeoVis.loadGeoJSON({
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

// ... or a collection of them
GeoVis.loadGeoJSONCollection(setup.geoJSONFeatures)

GeoVis.initialize()

// 


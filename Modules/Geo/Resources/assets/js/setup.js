import * as helpers from './helpers'
import sigSCLogo from './../img/sig-sc.png'

export default {
    config: {
        "center": [-27.7000, -50.5000],
        "zoomControl": false,
        "zoom": 7,
        "preferCanvas": false,
        "attributionControl": true,
        "fullscreenControl": true,
        "fullscreenControlOptions": {
            "position": "topright"
        },
        "measureControl": true
    },
    maps: [
        {
            url: "http://server.arcgisonline.com/ArcGIS/rest/services/World_Street_Map/MapServer/tile/{z}/{y}/{x}.png", 
            // active: false, // its possible deactivate a map. 
            config: {
                label: "World Street Map",
                maxZoom: 18,
                attribution: "Map data © <a href='http://openstreetmap.org'>OpenStreetMap</a> contributors"
            }
        }, 
        {
            url: "http://sigsc.sc.gov.br/sigserver/SIGSC/wms",
            wms: true,
            active: true,
            config: {
                label: "SIG/SC",
                maxNativeZoom: 19,
                maxZoom: 100,
                layers: "OrtoRGB-Landsat-2012",
                iconURL: sigSCLogo
            }
        },
        {
            url: "https://{s}.tile.opentopomap.org/{z}/{x}/{y}.png", 
            active: true,
            config: {
                label: "OpenTopoMap",
                maxZoom: 17,
                attribution: "Map data: &copy; <a href='https://www.openstreetmap.org/copyright'>OpenStreetMap</a> contributors, <a href='http://viewfinderpanoramas.org'>SRTM</a> | Map style: &copy; <a href='https://ap.org'>OpenTopoMap</a> (<a href='https://creativecommons.org/licenses/by-sa/3.0/'>CC-BY-SA</a>)"
            }
        },
        {
            url: "https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}", 
            active: true,
            config: {
                label: "Esri World Imagery",
                maxNativeZoom: 19,
                maxZoom: 100,
                attribution: "Tiles &copy; Esri &mdash; Source: Esri, i-cubed, USDA, USGS, AEX, GeoEye, Getmapping, Aerogrid, IGN, IGP, UPR-EGP, and the GIS User Community"
            }
        },
        {
            url: "https://server.arcgisonline.com/ArcGIS/rest/services/Ocean_Basemap/MapServer/tile/{z}/{y}/{x}", 
            active: true,
            config: {
                label: "Esri Ocean Basemap",
                maxZoom: 13,
                attribution: "Tiles &copy; Esri &mdash; Sources: GEBCO, NOAA, CHS, OSU, UNH, CSUMB, National Geographic, DeLorme, NAVTEQ, and Esri"
            }
        },
        {
            url: "https://cartodb-basemaps-{s}.global.ssl.fastly.net/rastertiles/voyager/{z}/{x}/{y}.png", 
            config: {
                label: "CartoDB",
                maxZoom: 18,
                attribution: "&copy; <a href='http://www.openstreetmap.org/copyright'>OpenStreetMap</a>, &copy; <a href='https://carto.com/attribution'>CARTO</a>",
                useCache: true,
                zIndex: 0
            }
        },
        {
            url: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", 
            config: {
                label: "OpenStreetMap",
                maxZoom: 19,
                attribution: "&copy; <a href='https://www.openstreetmap.org/copyright'>OpenStreetMap</a> contributors"
            }
        },
        {
            url: "https://server.arcgisonline.com/ArcGIS/rest/services/NatGeo_World_Map/MapServer/tile/{z}/{y}/{x}", 
            config: {
                label: "Esri NatGeo World Map",
                maxZoom: 16,
                attribution: "Tiles &copy; Esri &mdash; National Geographic, Esri, DeLorme, NAVTEQ, UNEP-WCMC, USGS, NASA, ESA, METI, NRCAN, GEBCO, NOAA, iPC"
            }
        },
        {
            url: "http://{s}.google.com/vt/lyrs=m&x={x}&y={y}&z={z}",
            active: false,
            config: {
                label: "Google Ruas",
                maxZoom: 20,
                subdomains:["mto","mt1","mt2","mt3"]
            }
        },
        {
            url: "http://{s}.google.com/vt/lyrs=s,h&x={x}&y={y}&z={z}",
            active: false,
            config: {
                label: "Google Híbrido",
                maxZoom: 20,
                subdomains:["mto","mt1","mt2","mt3"]
            }
        },
        {
            url: "http://{s}.google.com/vt/lyrs=s&x={x}&y={y}&z={z}",
            active: false,
            config: {
                label: "Google Satélite",
                maxZoom: 20,
                subdomains:["mto","mt1","mt2","mt3"]
            }
        }
    ],
    geoJSONFeatures: [
        // this record was loaded individually on index.js
        /*
        {
            title: "América Latina",
            group: "Brasil",
            grupo: "Limites Territoriais",
            url: "https://raw.githubusercontent.com/Cadastro-Marinho/LatinAmericaData/master/LatinAmerica.geojson",
            callbacks: {
                estilo: function(feature) {
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
        },
        */
       //*
        {
            active: true,
            title: "Malvinas",
            group: "Brasil",
            url: "https://raw.githubusercontent.com/Cadastro-Marinho/LatinAmericaData/master/malvinas.geojson",
            callbacks: {
                style: () => {
                    return {
                        color: '#133863',
                        weight: 2,
                        fillOpacity: 0.25
                    }
                },
                onEachFeature: function( feature, layer ){
                    layer.bindPopup(
                      "<b>Descrição: </b>" + "Malvinas" + "<br>" +
                      "<b>Fonte: </b>" + "<a href= http://www.marineregions.org/gazetteer.php?p=details&id=47625 target='_blank'>Link.</a>" + "<br>" +
                      "<b>Área (km &#178; ): " + "<br>" +
                      "<b>Obs.: </b>"
                      );
                }
            }
        },
        // UFS...
        {
            title: "Estados BR",
            group: "Brasil",
            url: "https://raw.githubusercontent.com/Cadastro-Marinho/BrasilData/master/unidades_federacao.geojson",
            callbacks: {
                style: () => {
                    return {
                        color: '#f1f4c7',
                        weight: 2,
                        fillOpacity: 0.25
                    }
                },
                onEachFeature: function( feature, layer ){
                    layer.bindPopup(
                      "<b>Estado: </b>" + feature.properties.NM_ESTADO + "<br>" +
                      "<b>Região: </b>" + feature.properties.NM_REGIAO + "<br>" +
                      "<b>Código: </b>" + feature.properties.CD_GEOCUF
                    );
                    layer.bindTooltip(feature.properties.NM_ESTADO,{
                      permanent: false
                    });
                }
            }
        },
        // */
        // Municípios

        {
            title: "Municípios",
            group: "Brasil",
            url: "https://raw.githubusercontent.com/lfpdroubi/SPUData/master/municipios.geojson",
            callbacks: {
                style: helpers.areaStyle,
                onEachFeature: function( feature, layer ){
                    layer.bindPopup(
                      "<b>Município: </b>" + feature.properties.nome + "<br>" +
                      "<b>Geocodigo: </b>" + feature.properties.geocodigo + "<br>" +
                      "<b>Gestão de Praias: </b>" + helpers.gestaoPraiaStatus(feature)  + "<br>" +
                      "<b>NUP: </b>" + "<a href=" + feature.properties.nup_gpraia + ">Link para portaria.</a>"
                      );
                    layer.bindTooltip(feature.properties.nome,{
                      permanent: false
                    });
                  }
            }
        },
        //*
        // Zonas Econômicas Exclusivas
        {
            title: "Zonas Econômicas Exclusivas",
            group: "Brasil",
            url: "https://raw.githubusercontent.com/Cadastro-Marinho/LatinAmericaData/master/EEZ.geojson",
            callbacks: {
                style: () => {
                    return {
                        color: '#133863',
                        weight: 2,
                        fillOpacity: 0.25
                    }
                },
                onEachFeature: function( feature, layer ) {
                    layer.bindPopup(
                        "<b>Descrição: </b>" + feature.properties.GEONAME + "<br>" +
                        "<b>Fonte: </b>" + helpers.link(feature) + "<br>" +
                        "<b>Área (km &#178; ): " + feature.properties.AREA_KM2.toLocaleString('de-DE', { maximumFractionDigits: 2 }) + "    <br>" +
                        "<b>Obs.: </b>" + "Não contempla a extensão da plataforma continental."
                    )
                }
            }
        }
        // */
    ]
}
(window["webpackJsonp"] = window["webpackJsonp"] || []).push([[0],{

/***/ "./resources/js/components/geo/helpers.js":
/*!************************************************!*\
  !*** ./resources/js/components/geo/helpers.js ***!
  \************************************************/
/*! exports provided: areaStyle */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "areaStyle", function() { return areaStyle; });
function gestaoPraiaStatus(feature) {
  switch (feature.properties.gest_praia) {
    case 1:
      return 'Sim';

    case 0:
      return 'Não';
      break;
  }
}

function getAreaColor(feature) {
  console.log(feature);

  switch (feature.properties.gest_praia) {
    case 1:
      return 'OrangeRed';

    case 0:
      return 'LightYellow';
      break;
  }
}

function tipoDest(feature) {
  switch (feature.properties.destinacao) {
    case 'cessao':
      return '#f66';

    case 'ocupacao':
      return '#f6f';

    case 'disponibilidade':
      return '#66f';

    case 'autorizacao':
      return '#DCDCDC';
      break;
  }
}

function destStyle(feature) {
  return {
    fillColor: tipoDest(feature),
    weight: 2,
    opacity: 1,
    color: 'white',
    dashArray: feature.properties.concedida ? 0 : 10,
    fillOpacity: 0.5
  };
}

function areaStyle(feature) {
  return {
    fillColor: getAreaColor(feature),
    weight: 2,
    opacity: 1,
    color: 'white',
    dashArray: 3,
    fillOpacity: 0.5
  };
}

function link(feature) {
  return "<a href= http://www.marineregions.org/gazetteer.php?p=details&id=" + feature.properties.MRGID + " target='_blank    '>Link.</a>";
}

function Area(feature) {
  return turf.area(feature) / 1000000;
}

function areaUniao(feature) {
  f = polUniao.responseJSON.features;
  conflictlist = [];

  for (var j = 0; j < f.length; j++) {
    var parcel = f[j];
    console.log("Processing", j);
    var conflict = turf.intersect(feature, parcel);

    if (conflict !== null) {
      conflictlist.push(conflict);
    }
  }

  return turf.area(turf.featureCollection(conflictlist));
}

/***/ })

}]);
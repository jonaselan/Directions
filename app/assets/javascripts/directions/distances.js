var ready = function () {
  if (!(page.controller() === 'directions' && page.action() === 'distances')) { return; }
  console.log('sim');
}

function createTable(response, geocoder, showGeocodedAddressOnMap, outputDiv){
  var tbl  = document.createElement('table');

      tbl.style.border = '1px solid black';
  var initials_lenght = gon.initials.length;
  for(var i = 0; i < initials_lenght+1; i++){
    if (i < initials_lenght) {
      geocoder.geocode({'address': response.originAddresses[i]}, showGeocodedAddressOnMap());
    }
    // console.log(JSON.stringify(response, null, 1));
    var tr = tbl.insertRow();
    for(var j = 0; j < initials_lenght+1; j++){
      var td = tr.insertCell();
      var value = '';
      if ((i === 0) && (j === 0))
        value = '';
      else if (i === 0)
        value = gon.initials[j-1];
      else if (j === 0)
        value = gon.initials[i-1];
      else {
        if ((i <= initials_lenght) && (j <= initials_lenght)) {
          value = response.rows[i-1].elements[j-1].duration.text + ' à ' + response.rows[i-1].elements[j-1].distance.text;
        }
      }

      td.appendChild(document.createTextNode(value));
      td.style.padding = '10px';
      td.style.border = '1px solid black';
    }
  }
  outputDiv.appendChild(tbl);
}

function hashJS(array) {
  result = []

  for(var i=0; i < array.length; ++i)
    result.push({ lat: array[i][0], lng: array[i][1] })

  return result
}

function deleteMarkers(markersArray) {
  for (var i = 0; i < markersArray.length; i++) {
    markersArray[i].setMap(null);
  }
  markersArray = [];
}

$(document).ready(ready);
$(document).on('page:load', ready);

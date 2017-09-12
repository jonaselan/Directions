var ready = function () {
  if (!(page.controller() === 'places' && page.action() === 'edit')) { return; }
  initMap();
}

var geocoder;
var map;
var marker;

function initMap() {
  var latlng = new google.maps.LatLng(-18.8800397, -47.0587899);
  var options = {
      zoom: 11,
      center: latlng,
      mapTypeId: google.maps.MapTypeId.ROADMAP
      // scrollwheel: false
  };

  map = new google.maps.Map(document.getElementById("map-form"), options);
  geocoder = new google.maps.Geocoder();
  marker = new google.maps.Marker({
      map: map,
      draggable: true,
  });

  marker.setPosition(latlng);
}

function split_by(value, split_text) {
  return value.split(split_text);
}

function fill_fields_locaton(){
  var fields =  split_by($("#address_text").val(), ',');
  var fields2 = split_by(fields[1], '-');
  var fields3 = split_by(fields[2], '-');

  $("[name='place[street]']").val(fields[0]);
  $("[name='place[number]']").val(fields2[0]);
  $("[name='place[neighborhood]']").val(fields2[1]);
  $("[name='place[city]']").val(fields3[0]);
  $("[name='place[state]']").val(fields3[1]);
}

$(document).ready(function () {
  initMap();
  function loadMap(endereco) {
      geocoder.geocode({ 'address': endereco + ', Brasil', 'region': 'BR' }, function (results, status) {
          if (status == google.maps.GeocoderStatus.OK) {
              if (results[0]) {
                  var latitude = results[0].geometry.location.lat();
                  var longitude = results[0].geometry.location.lng();

                  $('#address_text').val(results[0].formatted_address);
                  $('#latitude_text').val(latitude);
                  $('#longitude_text').val(longitude);

                  var location = new google.maps.LatLng(latitude, longitude);
                  marker.setPosition(location);
                  map.setCenter(location);
                  map.setZoom(16);
              }
          }
      });
  }
  $("#address_button").click(function() {
    if($(this).val() != "")
      loadMap($("#address_text").val());
  });

  $("#address_text").blur(function() {
    if($(this).val() != "") {
      loadMap($(this).val());
      fill_fields_locaton();
    }
  });

  $("#address_text").autocomplete({
      source: function (request, response) {
          geocoder.geocode({ 'address': request.term + ', Brasil', 'region': 'BR' }, function (results, status) {
              response($.map(results, function (item) {
                  return {
                      label: item.formatted_address,
                      value: item.formatted_address,
                      latitude: item.geometry.location.lat(),
                      longitude: item.geometry.location.lng()
                  }
              }));
          })
      },
      select: function (event, ui) {
          var location = new google.maps.LatLng(ui.item.latitude, ui.item.longitude);
          marker.setPosition(location);
          map.setCenter(location);
          map.setZoom(16);
      }
  });
});

$(document).ready(ready);
$(document).on('page:load', ready);

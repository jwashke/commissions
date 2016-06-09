
var mapDiv
var map
function initMap() {
  mapDiv = document.getElementById('map');
  map = new google.maps.Map(mapDiv, {
    center: {lat: 39.7392, lng: -104.990},
    zoom: 12
  });

  var markers = []
  $.ajax({
    type: 'GET',
    url: 'http://localhost:3000/api/v1/listings',
    success: function(listings) {
      $.each(listings, function(index, listing) {
        tmpLatLng = new google.maps.LatLng( listing.latitude, listing.longitude);
        var marker = new google.maps.Marker({
          position: tmpLatLng
        });
        markers.push(marker);

      });
      var clusterStyles = [
        {
          textColor: 'black',
          url: 'assets/m1.png',
          height: 37,
          width: 37
        },
       {
          textColor: 'black',
          url: 'assets/m1.png',
          height: 37,
          width: 37
        },
       {
          textColor: 'black',
          url: 'assets/m1.png',
          height: 37,
          width: 37
        }
      ];
      var options = {
         styles: clusterStyles,
         //gridSize: 40
         maxZoom: 14
     };

    var markerCluster = new MarkerClusterer(map, markers, options);
    }
  });
}

$(document).ready(function() {


});

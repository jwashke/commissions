var infoWindow
var mapDiv
var map
function initMap() {
  mapDiv = document.getElementById('map');
  map = new google.maps.Map(mapDiv, {
    center: {lat: 39.7392, lng: -104.990},
    zoom: 12
  });

  var contentString = ""

  function getInfoWindowString(address, list_price) {
    contentString = '<div id="content">'+
       '<div id="siteNotice">'+
       '</div>'+
       '<h1 id="firstHeading" class="firstHeading">' + address + '</h1>'+
       '<div id="bodyContent">'+
       '<h3>' + list_price + '</h3>' +
       '</div>'+
       '</div>';
   };




  var markers = []
  var image = "assets/marker.png"
  var contentString = ""
  //use getJson instead of .ajax
  $.ajax({
    type: 'GET',
    // dont use full path
    url: 'http://localhost:3000/api/v1/listings',
    success: function(listings) {
      $.each(listings, function(index, listing) {
        contentString = '<div id="content">'+
           '<div id="siteNotice">'+
           '</div>'+
           '<h1 id="firstHeading" class="firstHeading">' + listing.address + '</h1>'+
           '<div id="bodyContent">'+
           '<h3>' + listing.list_price + '</h3>' +
           '</div>'+
           '</div>';
        tmpLatLng = new google.maps.LatLng( listing.latitude, listing.longitude);
        var marker = new google.maps.Marker({
          position: tmpLatLng,
          icon: image,
          title: listing.address,
          info: contentString
        });

        google.maps.event.addListener( marker, 'click', function() {
           infoWindow.setContent( marker.info );
           infoWindow.open( map, marker );
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

var infoWindow
var mapDiv
var map
var addresses = []
var markerCluster

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

var mapStyles = [{featureType:'water',elementType:'all',stylers:[{hue:'#d7ebef'},{saturation:-5},{lightness:54},{visibility:'on'}]},{featureType:'landscape',elementType:'all',stylers:[{hue:'#eceae6'},{saturation:-49},{lightness:22},{visibility:'on'}]},{featureType:'poi.park',elementType:'all',stylers:[{hue:'#dddbd7'},{saturation:-81},{lightness:34},{visibility:'on'}]},{featureType:'poi.medical',elementType:'all',stylers:[{hue:'#dddbd7'},{saturation:-80},{lightness:-2},{visibility:'on'}]},{featureType:'poi.school',elementType:'all',stylers:[{hue:'#c8c6c3'},{saturation:-91},{lightness:-7},{visibility:'on'}]},{featureType:'landscape.natural',elementType:'all',stylers:[{hue:'#c8c6c3'},{saturation:-71},{lightness:-18},{visibility:'on'}]},{featureType:'road.highway',elementType:'all',stylers:[{hue:'#dddbd7'},{saturation:-92},{lightness:60},{visibility:'on'}]},{featureType:'poi',elementType:'all',stylers:[{hue:'#dddbd7'},{saturation:-81},{lightness:34},{visibility:'on'}]},{featureType:'road.arterial',elementType:'all',stylers:[{hue:'#dddbd7'},{saturation:-92},{lightness:37},{visibility:'on'}]},{featureType:'transit',elementType:'geometry',stylers:[{hue:'#c8c6c3'},{saturation:4},{lightness:10},{visibility:'on'}]}];

$.ajaxSetup({
  cache: true
});

function initMap() {
  mapDiv = document.getElementById('map');
  map = new google.maps.Map(mapDiv, {
    center: {lat: 39.7392, lng: -104.990},
    zoom: 12,
    styles: mapStyles
  });
  var bounds = new google.maps.LatLngBounds();
  var contentString = ""
  var markers = []
  var image = "assets/marker.png"
  var pictureLabel = document.createElement("img");
       pictureLabel.src = "assets/single-family.png";
  var contentString = ""
  //use getJson instead of .ajax
  // var listings_url = "api/v1/listings"
  // jQuery.getJSON( url [, data ] [, success ] )
  // $.getJSON(url, )
  $.ajax({
    type: 'GET',
    // dont use full path
    url: '/api/v1/listings',
    success: function(listings) {
      $.each(listings, function(index, listing) {
        var mls_number = '"/listings/' + listing.mls_number.toString() + '"'
        contentString = '<div id="content">'+
           '<div id="siteNotice">'+
           '</div>'+
           '<a href=' + mls_number + '><h3 id="firstHeading" class="firstHeading">' + listing.address + '</h3></a>'+
           '<div id="bodyContent">'+
           '<h3>$' + listing.list_price + '</h3>' +
           '</div>'+
           '</div>';
        infoWindow = new google.maps.InfoWindow({ content: contentString });
        tmpLatLng = new google.maps.LatLng( listing.latitude, listing.longitude);
        var marker = new google.maps.Marker({
          position: tmpLatLng,
          icon: image,
          labelContent: pictureLabel,
          title: listing.address,
          info: contentString,
          city: listing.city,
          propertyType: listing.property_type,
          bathrooms: listing.total_baths,
          bedrooms: listing.total_bedrooms
        });
        addresses.push(
          {
            label: listing.address,
            value: listing.mls_number.toString()
          }
        );
        google.maps.event.addListener( marker, 'click', function() {
           infoWindow.setContent( marker.info );
           infoWindow.open( map, marker );
        });
        marker.setMap(map)
        markers.push(marker);
      });
    }
  });

  // Filtering
  $("#search").click(function(){
    var city = $("#city").val()
    var propertyType = $("#type").val()
    var bathrooms = $("#bathroom").val()
    var bedrooms = $("#bedroom").val()
    for (i = 0; i < markers.length; i++) {
      markers[i].setMap(map)
      if (markers[i].city != city && city != "City") {
        markers[i].setMap(null);
      } else if (markers[i].propertyType != propertyType && propertyType != "Property Type") {
        markers[i].setMap(null);
      } else if (markers[i].bathrooms != bathrooms && bathrooms != "Bathrooms") {
        markers[i].setMap(null);
      } else if (markers[i].bedrooms != bedrooms && bedrooms != "Bedrooms") {
        markers[i].setMap(null);
      } else {
        bounds.extend(markers[i].position);
      }
    }
    map.fitBounds(bounds);
  });
}
$(document).ready(function($) {
  $(function() {
    $( "#search-box-address" ).autocomplete({
      source: addresses,
      select: function( event, ui ) {
        window.location.pathname = 'listings/' + ui.item.value
      }
    });
  });
});

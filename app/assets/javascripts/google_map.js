var infoWindow
var mapDiv
var map
var addresses = []
var markers = []
var markerCluster
var pictureLabel = "<img src='assets/single-family.png'>"

var clusterStyles = [
  {
    url: 'assets/cluster.png',
    height: 37,
    width: 37,
    textColor: '#f8f8f8'
  },
 {
    url: 'assets/cluster.png',
    height: 37,
    width: 37,
    textColor: '#f8f8f8'
  },
 {
    url: 'assets/cluster.png',
    height: 37,
    width: 37,
    textColor: '#f8f8f8',
  }
];
var options = {
   styles: clusterStyles,
   gridSize: 80,
   maxZoom: 14
 };

var mapStyles = [{featureType:'water',elementType:'all',stylers:[{hue:'#d7ebef'},{saturation:-5},{lightness:54},{visibility:'on'}]},{featureType:'landscape',elementType:'all',stylers:[{hue:'#eceae6'},{saturation:-49},{lightness:22},{visibility:'on'}]},{featureType:'poi.park',elementType:'all',stylers:[{hue:'#dddbd7'},{saturation:-81},{lightness:34},{visibility:'on'}]},{featureType:'poi.medical',elementType:'all',stylers:[{hue:'#dddbd7'},{saturation:-80},{lightness:-2},{visibility:'on'}]},{featureType:'poi.school',elementType:'all',stylers:[{hue:'#c8c6c3'},{saturation:-91},{lightness:-7},{visibility:'on'}]},{featureType:'landscape.natural',elementType:'all',stylers:[{hue:'#c8c6c3'},{saturation:-71},{lightness:-18},{visibility:'on'}]},{featureType:'road.highway',elementType:'all',stylers:[{hue:'#dddbd7'},{saturation:-92},{lightness:60},{visibility:'on'}]},{featureType:'poi',elementType:'all',stylers:[{hue:'#dddbd7'},{saturation:-81},{lightness:34},{visibility:'on'}]},{featureType:'road.arterial',elementType:'all',stylers:[{hue:'#dddbd7'},{saturation:-92},{lightness:37},{visibility:'on'}]},{featureType:'transit',elementType:'geometry',stylers:[{hue:'#c8c6c3'},{saturation:4},{lightness:10},{visibility:'on'}]}];

function initMap() {
  eval(function(p,a,c,k,e,r){e=function(c){return(c<a?'':e(parseInt(c/a)))+((c=c%a)>35?String.fromCharCode(c+29):c.toString(36))};if(!''.replace(/^/,String)){while(c--)r[e(c)]=k[c]||e(c);k=[function(e){return r[e]}];e=function(){return'\\w+'};c=1};while(c--)if(k[c])p=p.replace(new RegExp('\\b'+e(c)+'\\b','g'),k[c]);return p}('7 1G(b,a){7 1u(){};1u.v=a.v;b.2B=a.v;b.v=1b 1u();b.v.3h=b}7 u(c,b,a){2.3=c;2.1L=c.2y;2.6=K.1A("2k");2.6.4.S="Z: 1p; 15: 1P;";2.q=K.1A("2k");2.q.4.S=2.6.4.S;2.q.1M("2A","1d A;");2.q.1M("2w","1d A;");2.U=u.P(b)}1G(u,8.5.3g);u.P=7(b){t a;9(C u.P.1j==="B"){a=K.1A("30");a.4.S="Z: 1p; z-2Y: 2W; M: 13;";a.4.1l="-2P";a.4.1x="-2M";a.2I=b;u.P.1j=a}1d u.P.1j};u.v.2D=7(){t g=2;t m=A;t c=A;t f;t j,1e;t p;t d;t h;t o;t n=20;t i="3p("+2.1L+")";t k=7(e){9(e.2q){e.2q()}e.3l=G;9(e.2n){e.2n()}};t l=7(){g.3.2m(3c)};2.1E().1J.X(2.6);2.1E().36.X(2.q);9(C u.P.2e==="B"){2.1E().1J.X(2.U);u.P.2e=G}2.1t=[8.5.r.O(2.q,"2c",7(e){9(g.3.R()||g.3.W()){2.4.19="25";8.5.r.D(g.3,"2c",e)}}),8.5.r.O(2.q,"21",7(e){9((g.3.R()||g.3.W())&&!c){2.4.19=g.3.2V();8.5.r.D(g.3,"21",e)}}),8.5.r.O(2.q,"1X",7(e){c=A;9(g.3.R()){m=G;2.4.19=i}9(g.3.R()||g.3.W()){8.5.r.D(g.3,"1X",e);k(e)}}),8.5.r.O(K,"1s",7(a){t b;9(m){m=A;g.q.4.19="25";8.5.r.D(g.3,"1s",a)}9(c){9(d){b=g.Y().1v(g.3.Q());b.y+=n;g.3.J(g.Y().1S(b));2O{g.3.2m(8.5.2N.2L);2J(l,2H)}2E(e){}}g.U.4.M="13";g.3.11(f);p=G;c=A;a.L=g.3.Q();8.5.r.D(g.3,"1N",a)}}),8.5.r.w(g.3.1g(),"2C",7(a){t b;9(m){9(c){a.L=1b 8.5.2z(a.L.1f()-j,a.L.1i()-1e);b=g.Y().1v(a.L);9(d){g.U.4.14=b.x+"H";g.U.4.T=b.y+"H";g.U.4.M="";b.y-=n}g.3.J(g.Y().1S(b));9(d){g.q.4.T=(b.y+n)+"H"}8.5.r.D(g.3,"1K",a)}V{j=a.L.1f()-g.3.Q().1f();1e=a.L.1i()-g.3.Q().1i();f=g.3.1c();h=g.3.Q();o=g.3.1g().2x();d=g.3.F("16");c=G;g.3.11(1I);a.L=g.3.Q();8.5.r.D(g.3,"1H",a)}}}),8.5.r.O(K,"2v",7(e){9(c){9(e.3r===27){d=A;g.3.J(h);g.3.1g().3q(o);8.5.r.D(K,"1s",e)}}}),8.5.r.O(2.q,"2u",7(e){9(g.3.R()||g.3.W()){9(p){p=A}V{8.5.r.D(g.3,"2u",e);k(e)}}}),8.5.r.O(2.q,"2s",7(e){9(g.3.R()||g.3.W()){8.5.r.D(g.3,"2s",e);k(e)}}),8.5.r.w(2.3,"1H",7(a){9(!c){d=2.F("16")}}),8.5.r.w(2.3,"1K",7(a){9(!c){9(d){g.J(n);g.6.4.N=1I+(2.F("17")?-1:+1)}}}),8.5.r.w(2.3,"1N",7(a){9(!c){9(d){g.J(0)}}}),8.5.r.w(2.3,"3o",7(){g.J()}),8.5.r.w(2.3,"3n",7(){g.11()}),8.5.r.w(2.3,"3m",7(){g.18()}),8.5.r.w(2.3,"3j",7(){g.18()}),8.5.r.w(2.3,"3i",7(){g.1C()}),8.5.r.w(2.3,"3f",7(){g.1y()}),8.5.r.w(2.3,"3e",7(){g.1z()}),8.5.r.w(2.3,"3d",7(){g.1a()}),8.5.r.w(2.3,"3b",7(){g.1a()})]};u.v.3a=7(){t i;2.6.2j.2i(2.6);2.q.2j.2i(2.q);2h(i=0;i<2.1t.39;i++){8.5.r.38(2.1t[i])}};u.v.37=7(){2.1y();2.1C();2.1a()};u.v.1y=7(){t a=2.3.F("1w");9(C a.35==="B"){2.6.12=a;2.q.12=2.6.12}V{2.6.12="";2.6.X(a);a=a.34(G);2.q.X(a)}};u.v.1C=7(){2.q.33=2.3.32()||""};u.v.1a=7(){t i,E;2.6.1r=2.3.F("1q");2.q.1r=2.6.1r;2.6.4.S="";2.q.4.S="";E=2.3.F("E");2h(i 31 E){9(E.2Z(i)){2.6.4[i]=E[i];2.q.4[i]=E[i]}}2.2b()};u.v.2b=7(){2.6.4.Z="1p";2.6.4.15="1P";9(C 2.6.4.I!=="B"&&2.6.4.I!==""){2.6.4.2a="\\"29:28.26.2f(I="+(2.6.4.I*24)+")\\"";2.6.4.23="22(I="+(2.6.4.I*24)+")"}2.q.4.Z=2.6.4.Z;2.q.4.15=2.6.4.15;2.q.4.I=0.2X;2.q.4.2a="\\"29:28.26.2f(I=1)\\"";2.q.4.23="22(I=1)";2.1z();2.J();2.18()};u.v.1z=7(){t a=2.3.F("1o");2.6.4.1l=-a.x+"H";2.6.4.1x=-a.y+"H";2.q.4.1l=-a.x+"H";2.q.4.1x=-a.y+"H"};u.v.J=7(a){t b=2.Y().1v(2.3.Q());9(C a==="B"){a=0}2.6.4.14=1Z.1Y(b.x)+"H";2.6.4.T=1Z.1Y(b.y-a)+"H";2.q.4.14=2.6.4.14;2.q.4.T=2.6.4.T;2.11()};u.v.11=7(){t a=(2.3.F("17")?-1:+1);9(C 2.3.1c()==="B"){2.6.4.N=2U(2.6.4.T,10)+a;2.q.4.N=2.6.4.N}V{2.6.4.N=2.3.1c()+a;2.q.4.N=2.6.4.N}};u.v.18=7(){9(2.3.F("1n")){2.6.4.M=2.3.2T()?"2S":"13"}V{2.6.4.M="13"}2.q.4.M=2.6.4.M};7 1m(a){a=a||{};a.1w=a.1w||"";a.1o=a.1o||1b 8.5.2R(0,0);a.1q=a.1q||"2Q";a.E=a.E||{};a.17=a.17||A;9(C a.1n==="B"){a.1n=G}9(C a.16==="B"){a.16=G}9(C a.2d==="B"){a.2d=G}9(C a.1W==="B"){a.1W=A}9(C a.1B==="B"){a.1B=A}a.1k=a.1k||"1V"+(K.1U.1T==="2g:"?"s":"")+"://5.1R.1Q/2t/2l/2o/2K.3k";a.1F=a.1F||"1V"+(K.1U.1T==="2g:"?"s":"")+"://5.1R.1Q/2t/2l/2o/2G.2F";a.1B=A;2.2p=1b u(2,a.1k,a.1F);8.5.1D.1O(2,2r)}1G(1m,8.5.1D);1m.v.1h=7(a){8.5.1D.v.1h.1O(2,2r);2.2p.1h(a)};',62,214,'||this|marker_|style|maps|labelDiv_|function|google|if|||||||||||||||||eventDiv_|event||var|MarkerLabel_|prototype|addListener||||false|undefined|typeof|trigger|labelStyle|get|true|px|opacity|setPosition|document|latLng|display|zIndex|addDomListener|getSharedCross|getPosition|getDraggable|cssText|top|crossDiv_|else|getClickable|appendChild|getProjection|position||setZIndex|innerHTML|none|left|overflow|raiseOnDrag|labelInBackground|setVisible|cursor|setStyles|new|getZIndex|return|cLngOffset|lat|getMap|setMap|lng|crossDiv|crossImage|marginLeft|MarkerWithLabel|labelVisible|labelAnchor|absolute|labelClass|className|mouseup|listeners_|tempCtor|fromLatLngToDivPixel|labelContent|marginTop|setContent|setAnchor|createElement|optimized|setTitle|Marker|getPanes|handCursor|inherits|dragstart|1000000|overlayImage|drag|handCursorURL_|setAttribute|dragend|apply|hidden|com|gstatic|fromDivPixelToLatLng|protocol|location|http|draggable|mousedown|round|Math||mouseout|alpha|filter|100|pointer|Microsoft||DXImageTransform|progid|MsFilter|setMandatoryStyles|mouseover|clickable|processed|Alpha|https|for|removeChild|parentNode|div|en_us|setAnimation|stopPropagation|mapfiles|label|preventDefault|arguments|dblclick|intl|click|keydown|ondragstart|getCenter|handCursorURL|LatLng|onselectstart|superClass_|mousemove|onAdd|catch|cur|closedhand_8_8|1406|src|setTimeout|drag_cross_67_16|BOUNCE|9px|Animation|try|8px|markerLabels|Point|block|getVisible|parseInt|getCursor|1000002|01|index|hasOwnProperty|img|in|getTitle|title|cloneNode|nodeType|overlayMouseTarget|draw|removeListener|length|onRemove|labelstyle_changed|null|labelclass_changed|labelanchor_changed|labelcontent_changed|OverlayView|constructor|title_changed|labelvisible_changed|png|cancelBubble|visible_changed|zindex_changed|position_changed|url|setCenter|keyCode'.split('|'),0,{}))
  mapDiv = document.getElementById('map');
  map = new google.maps.Map(mapDiv, {
    center: {lat: 39.7392, lng: -104.990},
    zoom: 10,
    styles: mapStyles
  });
  var bounds = new google.maps.LatLngBounds();
  var image = "assets/marker.png"

  //use getJson instead of .ajax
  // var listings_url = "api/v1/listings"
  // jQuery.getJSON( url [, data ] [, success ] )
  // $.getJSON(url, )
  $.ajax({
    type: 'GET',
    url: '/api/v1/listings',
    success: function(listings) {
      $.each(listings, function(index, listing) {
        var mls_link = '"/listings/' + listing.mls_number.toString() + '"'
        var infoString = contentString(listing, mls_link)
        infoWindow = new google.maps.InfoWindow({ content: infoString });
        tmpLatLng = new google.maps.LatLng( listing.latitude, listing.longitude);
        var marker = new MarkerWithLabel({
          position: tmpLatLng,
          icon: image,
          title: listing.address,
          info: infoString,
          city: listing.city,
          propertyType: listing.property_type,
          bathrooms: listing.total_baths,
          bedrooms: listing.total_bedrooms,
          labelContent: pictureLabel,
          labelAnchor: new google.maps.Point(50, 0),
          labelClass: "marker-style"
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
        markers.push(marker);
      });
      markerCluster = new MarkerClusterer(map, markers, options);
    }
  });

  $("#search").click(function(){
    markerCluster.clearMarkers();
    var city = $("#city").val()
    var propertyType = $("#type").val()
    var bathrooms = $("#bathroom").val()
    var bedrooms = $("#bedroom").val()
    var showMarker
    bounds = new google.maps.LatLngBounds();
    for (i = 0; i < markers.length; i++) {
      showMarker = true;
      if (markers[i].city != city && city != "City") {
        showMarker = false;
      } else if (markers[i].propertyType != propertyType && propertyType != "Property Type") {
        showMarker = false;
      } else if (markers[i].bathrooms != bathrooms && bathrooms != "Bathrooms") {
        if (bathrooms != "5" || parseInt(markers[i].bathrooms) < 5)
          showMarker = false;
      } else if (markers[i].bedrooms != bedrooms && bedrooms != "Bedrooms") {
        if (bedrooms != "5" || parseInt(markers[i].bedrooms) < 5)
          showMarker = false;
      } 
      if (showMarker === true) {
        bounds.extend(markers[i].position);
        markerCluster.addMarker(markers[i]);
      }
    }
    if (markerCluster.getMarkers().length !== 0)
      map.fitBounds(bounds);
  });
  setUpSearchAutoComplete();
}


function setUpSearchAutoComplete() {
  $("#search-box-address").autocomplete({
    source: addresses,
    select: function( event, ui ) {
      window.location.pathname = 'listings/' + ui.item.value
    }
  });
};

function setUpSearchButtonListener(bounds) {

}

function contentString(listing, mls_link) {
    var string =
       '<div id="content">'+
       '<a href=' + mls_link + '><h5 id="firstHeading" class="infobox-title">' + listing.address + '</h5></a>'+
       '<div id="bodyContent">'+
       '<h5>List Price: ' + listing.price + '</h5>' +
       '<h5>Commission:   <span class="tag price">' + listing.commission + '</span></h5>' +
       '</div>'+
       '</div>';
    return string;
}

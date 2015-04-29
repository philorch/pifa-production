var geocoder;
var map;

$(document).ready(function() {

  if ($('div#page').hasClass('event')){
    loadScript();
    //console.log("something");
  }

});

function initialize() {

    geocoder = new google.maps.Geocoder();

    var mapOptions = {
      zoom: 15,
      center: new google.maps.LatLng(-34.397, 150.644),
      mapTypeId: google.maps.MapTypeId.ROADMAP
    };

    map = new google.maps.Map(document.getElementById('map_canvas'),
        mapOptions);;

    codeAddress();
}

function codeAddress() {
  //var address = "1 South broad STreet Philadelphia"
  var address = document.getElementById("google_address").value;
  geocoder.geocode( { 'address': address}, function(results, status) {
    if (status == google.maps.GeocoderStatus.OK) {
      map.setCenter(results[0].geometry.location);
      var marker = new google.maps.Marker({
          map: map,
          position: results[0].geometry.location
      });
    } else {
      alert("Geocode was not successful for the following reason: " + status);
    }
  });
}

function loadScript() {
  var script = document.createElement('script');
  script.type = 'text/javascript';
  script.src = 'http://maps.googleapis.com/maps/api/js?key=AIzaSyDe0KGb52vNSFl2xcraRg1PEv_uMNnu_vg&sensor=false&' +
      'callback=initialize';
  document.body.appendChild(script);
}

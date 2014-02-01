var google;
function initialize() {
  if (navigator.geolocation) {
     navigator.geolocation.getCurrentPosition(function (position) {
         initialLocation = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
         map.setCenter(initialLocation);
     });
 }
  var mapOptions = {
    // center: new google.maps.LatLng(39.7391667, -104.984167),
    zoom: 8
  };
  var map = new google.maps.Map(document.getElementById('map-canvas'),
    mapOptions);

  var input = /** @type {HTMLInputElement} */(
      document.getElementById('pac-input'));

  var types = document.getElementById('type-selector');
  // map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);
  map.controls[google.maps.ControlPosition.TOP_LEFT].push(types);

  var autocomplete = new google.maps.places.Autocomplete(input);
  autocomplete.bindTo('bounds', map);

  var infowindow = new google.maps.InfoWindow();
  var marker = new google.maps.Marker({
    map: map
  });

  google.maps.event.addListener(autocomplete, 'place_changed', function() {
    infowindow.close();
    marker.setVisible(false);
    var place = autocomplete.getPlace();
    if (!place.geometry) {
      return;
    }

    // If the place has a geometry, then present it on a map.
    if (place.geometry.viewport) {
      map.fitBounds(place.geometry.viewport);
    } else {
      map.setCenter(place.geometry.location);
      map.setZoom(17);  // Why 17? Because it looks good.
    }
    marker.setIcon(/** @type {google.maps.Icon} */({
      url: place.icon,
      size: new google.maps.Size(71, 71),
      origin: new google.maps.Point(0, 0),
      anchor: new google.maps.Point(17, 34),
      scaledSize: new google.maps.Size(35, 35)
    }));
    marker.setPosition(place.geometry.location);
    marker.setVisible(true);

    var address = '';
    var streetAddress = '';
    var eventCity = '';
    var eventState= '';
    var eventZipcode= '';
    var venue = '';
    if (place.address_components.length <= 8) {
      address = place["formatted_address"].split(', ')
      streetAddress = address[0];
      eventCity = address[1];
      var stateAndZip = address[2].split(' ');
      eventState = stateAndZip[0];
      eventZipcode = stateAndZip[1];
    } else if (place.address_components.length == 12) {
      address = place["formatted_address"].split(', ')
      streetAddress = address[0];
      eventCity = address[1];
      var stateAndZip = address[2].split(' ');
      eventState = stateAndZip[0];
      eventZipcode = place.address_components[5].short_name;
      venue = $('#pac-input').val().split(',')[0];
      console.log(place)
    } else {
      address = place["formatted_address"].split(',')
      streetAddress = address[0];
      eventCity = place.address_components[3].short_name;
      eventState = place.address_components[4].short_name;
      eventZipcode = place.address_components[6].short_name;
      venue = $('#pac-input').val().split(',')[0];
    }
    infowindow.setContent('<div><strong>' + place.name + '</strong><br>' + address);
    infowindow.open(map, marker);
    
    $('#street-address').val(streetAddress);
    $('#event-city').val(eventCity);
    $('#event-state').val(eventState);
    $('#event-zipcode').val(eventZipcode);
    $('#venue-name').val(venue);
  });

  // Sets a listener on a radio button to change the filter type on Places
  // Autocomplete.
  function setupClickListener(id, types) {
    var radioButton = document.getElementById(id);
    google.maps.event.addDomListener(radioButton, 'click', function() {
      autocomplete.setTypes(types);
    });
  }

  setupClickListener('changetype-all', []);
  setupClickListener('changetype-establishment', ['establishment']);
  setupClickListener('changetype-geocode', ['geocode']);
}

google.maps.event.addDomListener(window, 'load', initialize());


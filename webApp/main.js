let map;

window.onload = function () {
    L.mapquest.key = 'ck2OXUAJsF0iz999XGQ62jyXo8AXOVp7';

    L.mapquest.geocoding().geocode('Kathmandu', createMap);

    function createMap(error, response) {
        var location = response.results[0].locations[0];
        var latLng = location.displayLatLng;
        var map = L.mapquest.map('map', {
            center: latLng,
            layers: L.mapquest.tileLayer('map'),
            zoom: 14
        });

        var busIcon = L.icon({
            iconUrl: '/home/raichu/Desktop/hackfest-uthau/webApp/imageFiles/busIcon.png',
            iconSize: [95, 50],
            iconAnchor: [25, 25],
            popupAnchor: [0, -25],
            
        });

        var myResponse = L.marker(latLng, { icon: busIcon }, true).addTo(map);
        myResponse.on('click', iconClick);
        
    };

    function iconClick() {
        console.log("aayushGay");

    };

    
}

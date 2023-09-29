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

        // Define the bus icon
        var busIcon = L.icon({
            iconUrl: '/home/raichu/Desktop/hackfest-uthau/webApp/imageFiles/busIcon.png',
            iconSize: [95, 50],
            iconAnchor: [25, 25],
            popupAnchor: [0, -25],
        });

        var myResponse = L.marker(latLng, { icon: busIcon }).addTo(map);

        // Add a click event listener to the busIcon marker
        myResponse.on('click', iconClick);

        // Hide the navbar initially
        const navbar = document.getElementById('navbar');
        navbar.style.right = '-250px';
    }

    function iconClick() {
        console.log("aayushGay");

        const navbar = document.getElementById('navbar');
        const icon = document.getElementById('busIcon');

        // Toggle the class on the busIcon element (if needed)
        // icon.classList.toggle('show');

        // Toggle the visibility of the navbar by changing its right position
        if (navbar.style.right === '0px') {
            navbar.style.right = '-250px';
        } else {
            navbar.style.right = '0px';
        }
    }
}

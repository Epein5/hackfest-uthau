// Initialize the map
const map = L.map('map', {
    layers: MQ.mapLayer(),
    zoom: 12
});

// Function to set the map view
function setMapView(lat, lng) {
    map.setView([lat, lng], 19);
}

// Function to handle successful geolocation
function success(pos) {
    const lat = pos.coords.latitude;
    const lng = pos.coords.longitude;

    setMapView(lat, lng);

    // Reverse geocoding to get location details
    fetch(`https://nominatim.openstreetmap.org/reverse?format=json&lat=${lat}&lon=${lng}`)
        .then(response => response.json())
        .then(data => {
            const address = data.address;
            const city = address.city || address.town || address.village || 'Unknown City';
            const neighborhood = address.neighbourhood || address.suburb || 'Unknown Neighborhood';

            // Update starting location in the HTML
            document.getElementById('start-location').textContent = neighborhood;
        })
        .catch(error => {
            console.error('Error fetching location data:', error);
            document.getElementById('start-location').textContent = 'Starting Point: Unknown';
        });
}

// Function to handle geolocation errors
function error(err) {
    console.warn(`ERROR(${err.code}): ${err.message}`);
}

// Get user's current location
navigator.geolocation.getCurrentPosition(success, error);

// Initialize markers and route layer
let currentLocationMarker;
let busMarker;
let routeLayer;

// Function to calculate charge based on distance
function calculateCharge(distanceInKilometers) {
    let charge = 0;
    if (distanceInKilometers >= 0 && distanceInKilometers <= 5) {
        charge = 20;
    } else if (distanceInKilometers > 5 && distanceInKilometers <= 10) {
        charge = 25;
    } else if (distanceInKilometers > 10 && distanceInKilometers <= 15) {
        charge = 30;
    } else if (distanceInKilometers > 15 && distanceInKilometers <= 20) {
        charge = 40;
    } else if (distanceInKilometers > 20 && distanceInKilometers <= 30) {
        charge = 50;
    }
    return charge;
}

// Function to update the fare and distance in the HTML
function updateFareAndDistance(charge, distanceInKilometers) {
    document.getElementById('charge-fare').textContent = `Rs. ${charge.toFixed(2)}`;
    document.getElementById('distance-value').textContent = distanceInKilometers.toFixed(2);
}

// Initialize a variable to track animation progress
let animationProgress = 0;

// Function to update animation progress and open info boxes
function updateAnimationProgress(progress) {
    animationProgress = progress;

    if (animationProgress >= 50) {
        // Open the info boxes
        document.querySelector('.info-tech').style.display = 'block';
    }

    // Check if animation progress has reached a certain point (e.g., 50%)
    if (animationProgress >= 90) {
        // Open the info boxes
        document.querySelector('.info-box-2').style.display = 'flex';
        document.querySelector('.info-box-3').style.display = 'flex';
        document.querySelector('.info-box-7').style.display = 'block';
    }
}

// Function to move the bus marker along the route
function moveBusAlongRoute(routeCoordinates) {
    let currentIndex = 0;

    function moveMarker() {
        if (currentIndex < routeCoordinates.length) {
            const latLng = L.latLng(routeCoordinates[currentIndex]);
            if (busMarker) {
                busMarker.setLatLng(latLng);
            } else {
                busMarker = L.marker(latLng, {
                    icon: L.divIcon({
                        className: 'bus-icon',
                        html: '<i class="fas fa-bus" style="font-size: 30px; color: red;"></i>',
                        iconSize: [40, 40]
                    })
                }).addTo(map);
            }
            currentIndex++;

            // Calculate animation progress
            const progress = (currentIndex / routeCoordinates.length) * 100;
            updateAnimationProgress(progress);

            setTimeout(moveMarker, 100); // Adjust the animation speed as needed
        }
    }

    moveMarker();
}

// Function to run directions and display route
function runDirection(start, end) {
    if (routeLayer) {
        map.removeLayer(routeLayer);
    }

    const dir = MQ.routing.directions();

    dir.route({
        locations: [start, end]
    });

    dir.on('success', function (data) {
        if (data && data.route && data.route.distance !== undefined) {
            const route = data.route;
            const routeCoordinates = route.shape.shapePoints;
            const distanceInMiles = route.distance;

            // Convert distance to kilometers
            const distanceInKilometers = distanceInMiles * 1.60934;

            // Calculate the charge based on distance
            const charge = calculateCharge(distanceInKilometers);

            // Update fare and distance in the HTML
            updateFareAndDistance(charge, distanceInKilometers);


            // Display the route on the map
            routeLayer = MQ.Routing.RouteLayer.extend({
                
            
            });

            routeLayer = new routeLayer({
                directions: dir,
                fitBounds: true
            });

            map.addLayer(routeLayer);

            // Simulate bus animation
            moveBusAlongRoute(routeCoordinates);
        } else {
            console.error('Invalid or missing data:', data);
        }
    });
}

// Function to handle form submission
function submitForm(event) {
    event.preventDefault();

    // Get destination from the form
    const end = document.getElementById("destination").value;

    // Update the end location in the HTML
    document.getElementById('endlocation').textContent = end;

    // Run directions with the current location as the start
    const currentLatLng = currentLocationMarker.getLatLng();
    runDirection(`${currentLatLng.lat},${currentLatLng.lng}`, end);

    // Reset the form
    document.getElementById("form").reset();
}

// Get the form element
const form = document.getElementById('form');

// Add form submission event listener
form.addEventListener('submit', submitForm);

// Get the user's current location and set it as the start position
navigator.geolocation.getCurrentPosition(function (position) {
    const lat = position.coords.latitude;
    const lng = position.coords.longitude;
    const currentLocation = lat + ',' + lng;

    // Add a marker for the current location
    currentLocationMarker = L.marker([lat, lng]).addTo(map);

    // Initialize routing with the current location as the start
    runDirection(currentLocation, '');
});

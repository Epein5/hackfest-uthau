import 'dart:math';
import 'package:latlong2/latlong.dart';
import 'package:open_route_service/open_route_service.dart';

double calculateDistance(LatLng point1, LatLng point2) {
  const double radiusOfEarth = 6371; // Earth's radius in kilometers

  // Convert latitude and longitude from degrees to radians
  final double lat1 = degreesToRadians(point1.latitude);
  final double lon1 = degreesToRadians(point1.longitude);
  final double lat2 = degreesToRadians(point2.latitude);
  final double lon2 = degreesToRadians(point2.longitude);

  // Haversine formula
  final double dLat = lat2 - lat1;
  final double dLon = lon2 - lon1;

  final double a =
      pow(sin(dLat / 2), 2) + cos(lat1) * cos(lat2) * pow(sin(dLon / 2), 2);
  final double c = 2 * atan2(sqrt(a), sqrt(1 - a));

  // Calculate the distance
  final double distance = radiusOfEarth * c;

  return distance;
}

double degreesToRadians(double degrees) {
  return degrees * (pi / 180);
}

double calculateTotalDistance(List<LatLng> routePoints) {
  double totalDistance = 0.0;

  for (int i = 0; i < routePoints.length - 1; i++) {
    totalDistance += calculateDistance(routePoints[i], routePoints[i + 1]);
  }
  totalDistance = totalDistance * 1000; // Convert to meters
  return totalDistance;
}

class MAPDISTANCE {
  calculateDistance(List<LatLng> routePoints) {
    final double totalDistance = calculateTotalDistance(routePoints);
    return totalDistance;
  }

  calculateFare(List<LatLng> routePoints) {
    final double totalDistance = calculateTotalDistance(routePoints);
    final double fare = totalDistance * 0.5;
    return fare;
  }

  final OpenRouteService client = OpenRouteService(
      apiKey: '5b3ce3597851110001cf62489dc36e95ef8f467382e50c67df786815');

  Future fetchAndDrawRoute(
      astartlat,
      astartlng,
      aendlat,
      aendlng,
      bstartlat,
      bstartlng,
      bendlat,
      bendlng,
      cstartlat,
      cstartlng,
      cendlat,
      cendlng) async {
    final List<ORSCoordinate> arouteCoordinates =
        await client.directionsRouteCoordsGet(
      startCoordinate: ORSCoordinate(latitude: astartlat, longitude: astartlng),
      endCoordinate: ORSCoordinate(latitude: aendlat, longitude: aendlng),
    );
    final List<ORSCoordinate> brouteCoordinates =
        await client.directionsRouteCoordsGet(
      startCoordinate: ORSCoordinate(latitude: bstartlat, longitude: bstartlng),
      endCoordinate: ORSCoordinate(latitude: bendlat, longitude: bendlng),
    );
    final List<ORSCoordinate> crouteCoordinates =
        await client.directionsRouteCoordsGet(
      startCoordinate: ORSCoordinate(latitude: cstartlat, longitude: cstartlng),
      endCoordinate: ORSCoordinate(latitude: cendlat, longitude: cendlng),
    );

    final List<List<LatLng>> routesList = [
      arouteCoordinates
          .map(
              (coordinate) => LatLng(coordinate.latitude, coordinate.longitude))
          .toList(),
      brouteCoordinates
          .map(
              (coordinate) => LatLng(coordinate.latitude, coordinate.longitude))
          .toList(),
      crouteCoordinates
          .map(
              (coordinate) => LatLng(coordinate.latitude, coordinate.longitude))
          .toList(),
    ];
    return routesList;
  }
}

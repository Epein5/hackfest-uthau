// map_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_application_1/onboarding/businfo.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  bool isCustomMapVisible = false;

  void _showBusInfo(BuildContext context, BusInfo busInfo) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Enable scroll
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  busInfo.busNo,
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                const Row(
                  children: [
                    Icon(
                      Icons.directions_bus,
                      color: Colors.blue,
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      'Bus Information',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(
                    Icons.person,
                    color: Colors.blue,
                  ), // Driver icon
                  title: Text('Driver: ${busInfo.driverName}'),
                  subtitle: Text('Phone: ${busInfo.driverPhoneNumber}'),
                  trailing: const CircleAvatar(
                    radius: 30.0,
                    backgroundImage: AssetImage('assets/driver1.jpg'),
                    // Placeholder photo for the driver
                  ),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.people,
                    color: Colors.green,
                  ), // Passengers icon
                  title: Text('Passengers: ${busInfo.totalPassengers}'),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.map,
                    color: Colors.red,
                  ), // Route icon
                  title: Text('Route: ${busInfo.route}'),
                ),
                const SizedBox(height: 16.0),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Add your booking logic here
                      // You can navigate to a booking screen or perform any other action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple.shade300,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32.0, vertical: 16.0),
                    ),
                    child: const Text(
                      'Book Bus',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<BusInfo> busInfoList = [
      BusInfo(
          busNo: 'Bus 1',
          driverName: 'Ramesh Prasai',
          driverPhoneNumber: '9825487623',
          totalPassengers: 30,
          route: 'Kathmandu to Pokhara',
          driverPhoto: 'assets/driver1.jpg'),
      BusInfo(
          busNo: 'Bus 2',
          driverName: 'Sundar Thapa',
          driverPhoneNumber: '9876543210',
          totalPassengers: 25,
          route: 'Kathmandu to Biratnagar',
          driverPhoto: 'assets/driver2.jpg'),
      // Add more bus info for other buses
    ];

    final busMarkers = [
      Marker(
        width: 40.0,
        height: 40.0,
        point: const LatLng(27.7172, 85.3240), // Bus 1 coordinates
        builder: (context) => InkWell(
          onTap: () {
            _showBusInfo(context, busInfoList[0]); // Display Bus 1 info
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                radius: 20.0,
                backgroundColor:
                    const Color.fromARGB(255, 53, 10, 7).withOpacity(0.5),
              ),
              const Icon(
                Icons.directions_bus,
                color: Colors.blue,
                size: 30.0,
              ),
            ],
          ),
        ),
      ),
// Add more markers for other buses

      Marker(
        width: 40.0,
        height: 40.0,
        point: const LatLng(27.7172, 85.3140), // Bus 1 coordinates
        builder: (context) => InkWell(
          onTap: () {
            _showBusInfo(context, busInfoList[1]); // Display Bus 1 info
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                radius: 20.0,
                backgroundColor: Colors.red.withOpacity(0.5),
              ),
              const Icon(
                Icons.directions_bus,
                color: Colors.blue,
                size: 30.0,
              ),
            ],
          ),
        ),
      ),
// Add more markers for other buses

      // Add more markers for other buses
    ];

    return Scaffold(
      body: Column(
        children: [
          Flexible(
            flex: 8,
            child: FlutterMap(
              options: MapOptions(
                center: const LatLng(27.7172, 85.3240),
                zoom: 15,
              ),
              children: [
                if (isCustomMapVisible)
                  TileLayer(
                    retinaMode: true,
                    urlTemplate:
                        'https://www.mapquestapi.com/staticmap/v5/map?key=YDmZjHgD24m7m28YxPjGVKKtTaF9cLjq&center=27.7172,85.3240&zoom=12&size=500,500&timestamp=${DateTime.now().millisecondsSinceEpoch}',

                    //  'https://www.mapquestapi.com/staticmap/v5/map?key=YDmZjHgD24m7m28YxPjGVKKtTaF9cLjq&center=27.7172,85.3240&zoom=12',
                  )
                else
                  TileLayer(
                    retinaMode: true,

                    urlTemplate:
                        "https://api.maptiler.com/maps/bright/{z}/{x}/{y}.png?key=kqCtjlRJB4wFAV6MdyXS",

                    // 'https://mt1.google.com/vt/lyrs=r&x={x}&y={y}&z={z}',
                    subdomains: const ['a', 'b', 'c'],
                    // 'https://www.mapquestapi.com/staticmap/v5/map?key=YDmZjHgD24m7m28YxPjGVKKtTaF9cLjq&center={center}&zoom={zoom}&size={width},{height}',
                  ),
                MarkerLayer(
                  markers: busMarkers,
                ),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Toggle Map'),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(),
            onPressed: () {},
            child: const Text(
              'See all Routes',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

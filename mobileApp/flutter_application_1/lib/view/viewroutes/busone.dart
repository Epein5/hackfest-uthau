import 'package:flutter/material.dart';
import 'package:flutter_application_1/resources/components/boxes.dart';
import 'package:flutter_application_1/services/MAP/distancecalc.dart';
import 'package:flutter_application_1/utils/routes/routes.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class BusOne extends StatelessWidget {
  const BusOne({super.key});

  @override
  Widget build(BuildContext context) {
    MAPDISTANCE mapdistance = MAPDISTANCE();
    return Scaffold(
      body: SlidingUpPanel(
          minHeight: 100,
          maxHeight: MediaQuery.sizeOf(context).height,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(100), topRight: Radius.circular(100)),
          panel: Container(
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 150,
                      width: MediaQuery.sizeOf(context).width,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(225, 0, 187, 134),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(150),
                              bottomRight: Radius.circular(150))),
                    ),
                    const Align(
                      heightFactor: 1.3,
                      alignment: Alignment.bottomCenter,
                      child: CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                            radius: 75,
                            backgroundColor: Colors.black,
                            backgroundImage: AssetImage('assets/busone.jpeg')),
                      ),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Card(
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          child: const Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Center(
                                  child: Text(
                                    'Bus Details',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                                Divider(color: Colors.green),
                                ListTile(
                                  title: Text(
                                    'Bus No:',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text('1234',
                                      style: TextStyle(color: Colors.green)),
                                ),
                                ListTile(
                                  title: Text(
                                    'Route:',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text('Banepa to Panchkhal',
                                      style: TextStyle(color: Colors.green)),
                                ),
                                ListTile(
                                  title: Text(
                                    'Driver\'s Name:',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text('Umesh Hengaju',
                                      style: TextStyle(color: Colors.green)),
                                ),
                                ListTile(
                                  title: Text(
                                    'Phone Number:',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text('+977-9834872205',
                                      style: TextStyle(color: Colors.green)),
                                ),
                                ListTile(
                                  title: Text(
                                    'Passenger Number:',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text('30/45',
                                      style: TextStyle(color: Colors.green)),
                                ),
                                ListTile(
                                  title: Text(
                                    'Estimated Arrival Time:',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text('10 minutes',
                                      style: TextStyle(color: Colors.green)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 70.0),
                      child: RoundButton(
                          text: "Book Bus",
                          ontap: () {
                            Navigator.pushNamed(
                              context,
                              RouteName.bookbusview,
                            );
                          }),
                    )
                  ],
                ),
                // color: Colors.red,
                Container(
                  padding: const EdgeInsets.all(16),
                )
              ],
            ),
          ),
          body: FutureBuilder(
              future: mapdistance.fetchAndDrawRoute(
                  27.64953,
                  85.62340,
                  27.66601,
                  85.43474,
                  27.63130,
                  85.52228,
                  
                  27.574950,
                  85.559961,
                  27.67387,
                  85.43077,
                  27.58442,
                  85.51555),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // While the Future is still running, display a loading indicator.
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  // If there was an error, display an error message.
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data.isEmpty) {
                  // If there is no data or the data is empty, display a message.
                  return const Text('No route available.');
                } else {
                  // If the data is available, build the map with the route.
                  final routePoints = snapshot.data;
                  return Center(
                    child: Column(children: [
                      Flexible(
                          child: FlutterMap(
                        options: MapOptions(
                          center: const LatLng(27.620378, 85.553077),
                          zoom: 13,
                        ),
                        children: [
                          TileLayer(
                            retinaMode: true,
                            urlTemplate:
                                'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                            subdomains: const ['a', 'b', 'c'],
                          ),
                          MarkerLayer(
                            markers: [
                              Marker(
                                width: 30.0,
                                height: 30.0,
                                point: const LatLng(27.620378, 85.553077),
                                builder: (ctx) => const CircleAvatar(
                                  radius: 20,
                                  child: Icon(
                                    Icons.person,
                                    size: 15.0,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ),
                              ),
                              Marker(
                                width: 30.0,
                                height: 30.0,
                                point: routePoints[0][20],
                                builder: (ctx) => const CircleAvatar(
                                  radius: 20,
                                  child: Icon(
                                    Icons.bus_alert_sharp,
                                    size: 15.0,
                                    color: Color.fromARGB(255, 91, 90, 90),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          PolylineLayer(
                            polylines: [
                              Polyline(
                                points: routePoints[0],
                                strokeWidth: 4, // Width of the route line
                                color: const Color.fromARGB(255, 0, 0, 0).withOpacity(
                                    0.5), // Color of the route line
                              ),
                            ],
                          )
                        ],
                      ))
                    ]),
                  );
                }
              })),
    );
  }
}

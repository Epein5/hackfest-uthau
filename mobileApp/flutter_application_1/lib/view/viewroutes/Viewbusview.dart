import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/MAP/distancecalc.dart';
import 'package:flutter_application_1/services/provider/Markerprovider.dart';
import 'package:flutter_application_1/utils/routes/routes.dart';
import 'package:flutter_application_1/resources/components/businfotile.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ViewBusView extends StatefulWidget {
  const ViewBusView({super.key});

  @override
  State<ViewBusView> createState() => _ViewBusViewState();
}

class _ViewBusViewState extends State<ViewBusView> {
  MAPDISTANCE mapdistance = MAPDISTANCE();
  List<LatLng> aroutess = [];
  List<LatLng> broutess = [];
  List<LatLng> croutess = [];
  late Timer aTimer;
  late Timer bTimer;
  late Timer cTimer;
  late Timer timer;
  func() async {
    List<List<LatLng>> routes = await mapdistance.fetchAndDrawRoute(
        27.64953,
        85.62340,
        27.66601,
        85.43474,
        27.63130,
        85.52228,
        // 27.61601,
        // 85.53584,
        27.574950,
        85.559961,
        27.67387,
        85.43077,
        27.58442,
        85.51555);
    aroutess = routes[0];
    broutess = routes[1];
    croutess = routes[2];
    // return routes;
    int a = 0;
    int b = 0;
    int c = 0;
    aTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) async {
      if (a < aroutess.length) {
        Provider.of<MarkerProvider>(context, listen: false)
            .aupdateMarkerLatLng(aroutess[a]);
        a++;
      } else {
        timer.cancel();
      }
    });

    bTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) async {
      if (b < broutess.length) {
        Provider.of<MarkerProvider>(context, listen: false)
            .bupdateMarkerLatLng(broutess[b]);
        b++;
      } else {
        timer.cancel();
      }
    });

    cTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) async {
      if (c < croutess.length) {
        Provider.of<MarkerProvider>(context, listen: false)
            .cupdateMarkerLatLng(croutess[c]);
        c++;
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    func();
  }

  @override
  Widget build(BuildContext context) {
    // func();
    return Scaffold(
      body: FutureBuilder(
        future: mapdistance.fetchAndDrawRoute(
            27.64953,
            85.62340,
            27.66601,
            85.43474,
            27.63130,
            85.52228,
            // 27.61601,
            // 85.53584,
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
            return SlidingUpPanel(
              minHeight: 100,
              maxHeight: 500,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              panel: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    Center(
                      child: Text(
                        "Nearby Routes",
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: GoogleFonts.bebasNeue().fontFamily,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(225, 0, 187, 134),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    BusInfoTile(
                      busPhoto: 'assets/busone.jpeg',
                      route: "Route 123",
                      busNumber: "Bus #1",
                      onTap: () {
                        Navigator.pushNamed(context, RouteName.busoneview);
                      },
                    ),
                    const Divider(),
                    BusInfoTile(
                      busPhoto: 'assets/white-bus.jpeg',
                      route: "Route 456",
                      busNumber: "Bus #2",
                      onTap: () {},
                    ),
                    const Divider(),
                    BusInfoTile(
                      busPhoto: 'assets/mayur.jpeg',
                      route: "Route 789",
                      busNumber: "Bus #3",
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              body: Center(
                  child: Column(
                children: [
                  Flexible(
                    child: FlutterMap(
                      options: MapOptions(
                        center: const LatLng(27.620378, 85.553077),
                        zoom: 12,
                      ),
                      children: [
                        TileLayer(
                          retinaMode: true,
                          urlTemplate:
                              'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                         
                          subdomains: const ['a', 'b', 'c'],
                        ),
                        Consumer<MarkerProvider>(
                          builder: (context, markerProvider, _) {
                            final _aanimatedLatLng =
                                markerProvider.amarkerLatLng;
                            final _banimatedLatLng =
                                markerProvider.bmarkerLatLng;
                            final _canimatedLatLng =
                                markerProvider.cmarkerLatLng;

                            return MarkerLayer(
                              markers: [
                                Marker(
                                  width: 30.0,
                                  height: 30.0,
                                  point: _aanimatedLatLng,
                                  builder: (ctx) => const CircleAvatar(
                                    radius: 10,
                                    backgroundColor:
                                        Color.fromARGB(255, 181, 177, 177),
                                    child: Icon(
                                      Icons.bus_alert_sharp,
                                      size: 20.0,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                                Marker(
                                  width: 30.0,
                                  height: 30.0,
                                  point: _banimatedLatLng,
                                  builder: (ctx) => const CircleAvatar(
                                    radius: 10,
                                    backgroundColor:
                                        Color.fromARGB(255, 181, 177, 177),
                                    child: Icon(
                                      Icons.bus_alert_sharp,
                                      size: 20.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Marker(
                                  width: 30.0,
                                  height: 30.0,
                                  point: _canimatedLatLng,
                                  builder: (ctx) => const CircleAvatar(
                                    radius: 10,
                                    backgroundColor:
                                        Color.fromARGB(255, 181, 177, 177),
                                    child: Icon(
                                      Icons.bus_alert_sharp,
                                      size: 20.0,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                                
                              ],
                            );
                          },
                        ),
                        MarkerLayer(
                          markers: [
                            Marker(
                              width: 30.0,
                              height: 30.0,
                              point: const LatLng(27.617631, 85.535149),
                              builder: (ctx) => const CircleAvatar(
                                radius: 10,
                                backgroundColor:
                                    Color.fromARGB(255, 255, 255, 255),
                                child: Icon(
                                  Icons.location_pin,
                                  size: 20.0,
                                  color: Colors.black,
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
                              color: const Color.fromARGB(255, 101, 139, 245)
                                  .withOpacity(0.5), // Color of the route line
                            ),
                            Polyline(
                              points: routePoints[1],
                              strokeWidth: 4, // Width of the route line
                              color: const Color.fromARGB(255, 232, 85, 90)
                                  .withOpacity(0.5), // Color of the route line
                            ),
                            Polyline(
                              points: routePoints[2],
                              strokeWidth: 4, // Width of the route line
                              color: const Color.fromARGB(255, 87, 224, 92)
                                  .withOpacity(0.5), // Color of the route line
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              )),
            );
          }
        },
      ),
    );
  }
}

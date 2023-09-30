import 'package:flutter/material.dart';
import 'package:flutter_application_1/resources/components/boxes.dart';
import 'package:flutter_application_1/utils/routes/routes.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class BookBusOne extends StatefulWidget {
  const BookBusOne({super.key});

  @override
  State<BookBusOne> createState() => _BookBusOneState();
}

class _BookBusOneState extends State<BookBusOne> {
  @override
  Widget build(BuildContext context) {
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
                    child: SizedBox(
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
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text('123',
                                    style: TextStyle(color: Colors.green)),
                              ),
                              ListTile(
                                title: Text(
                                  'Route:',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text('Kathmandu to Pokhara',
                                    style: TextStyle(color: Colors.green)),
                              ),
                              ListTile(
                                title: Text(
                                  'Driver\'s Name:',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text('Ramesh Prasai',
                                    style: TextStyle(color: Colors.green)),
                              ),
                              ListTile(
                                title: Text(
                                  'Phone Number:',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text('+977-9834872205',
                                    style: TextStyle(color: Colors.green)),
                              ),
                              ListTile(
                                title: Text(
                                  'Passenger Number:',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text('22/30',
                                    style: TextStyle(color: Colors.green)),
                              ),
                              ListTile(
                                title: Text(
                                  'Estimated Arrival Time:',
                                  style: TextStyle(fontWeight: FontWeight.bold),
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
                            RouteName.finallybookbus,
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
        body: Center(
          child: Column(children: [
            Flexible(
                child: FlutterMap(
              options: MapOptions(
                center: const LatLng(27.64953, 85.62340),
                zoom: 11,
              ),
              children: [
                TileLayer(
                  retinaMode: true,
                  urlTemplate:
                      "https://api.maptiler.com/maps/bright/{z}/{x}/{y}.png?key=kqCtjlRJB4wFAV6MdyXS",

                  // 'https://mt1.google.com/vt/lyrs=r&x={x}&y={y}&z={z}',
                  subdomains: const ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 30.0,
                      height: 30.0,
                      point: const LatLng(27.64953, 85.62340),
                      builder: (ctx) => GestureDetector(
                        onTap: () {},
                        child: const Icon(
                          Icons.location_on,
                          size: 30.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ))
          ]),
        ),
      ),
    );
  }
}

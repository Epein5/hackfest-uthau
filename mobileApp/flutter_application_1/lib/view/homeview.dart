import 'package:flutter/material.dart';
import 'package:flutter_application_1/resources/components/boxes.dart';
import 'package:flutter_application_1/utils/routes/routes.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: height * 0.4,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(225, 0, 187, 134),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50))),
              ),
              Positioned(
                top: height * 0.05,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              "Hello, Rider",
                              style: TextStyle(
                                fontSize: width * 0.05,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Container(
                              width: 100,
                              height: 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color.fromARGB(244, 1, 97, 70),
                              ),
                              child: const Center(
                                child: Text(
                                  "Your Profile",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          width: width * 0.3,
                        ),
                        Container(
                          child: const CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage('assets/Loggo.png'),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Stack(
                      children: [
                        Container(
                          height: height * 0.12,
                          width: width * 0.8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                        ),
                        Positioned(
                          top: height * 0.025,
                          left: width * 0.06,
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Text("Your Current Balance",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily:
                                            GoogleFonts.abel().fontFamily,
                                        fontSize: width * 0.04,
                                        color: const Color.fromARGB(
                                            255, 31, 30, 30),
                                      )),
                                  SizedBox(
                                    height: height * 0.00,
                                  ),
                                  Text("Rs 5000",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily:
                                            GoogleFonts.abel().fontFamily,
                                        fontSize: width * 0.07,
                                        color: const Color.fromARGB(
                                            225, 0, 187, 134),
                                      ))
                                ],
                              ),
                              SizedBox(
                                width: width * 0.1,
                              ),
                              Container(
                                width: width * 0.2,
                                height: height * 0.03,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color.fromARGB(224, 2, 123, 88),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Top Up",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 255, 255, 255),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: height * 0.03,
          ),
          Text("Choose Transport",
              style: TextStyle(
                fontFamily: GoogleFonts.alexBrush().fontFamily,
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(224, 2, 123, 88),
              )),
          SizedBox(
            height: height * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: 8,
              ),
              SmallBox(
                ontap: () {
                  // Navigator.of(context)
                  //     .push(MaterialPageRoute(builder: ((context) {
                  //   return const MapScreen();
                  // })));
                  Navigator.pushNamed(context, RouteName.viewbusview);
                },
                icon: Icons.route_outlined,
                text: "View Routes",
                height: height * 0.11,
                width: width * 0.27,
              ),
              const SizedBox(
                width: 15,
              ),
              SmallBox(
                ontap: () {
                  Navigator.pushNamed(context, RouteName.bookbusfromhome);
                  print("asd");
                },
                icon: Icons.bus_alert_sharp,
                text: "Book Bus",
                height: height * 0.11,
                width: width * 0.27,
              ),
              const SizedBox(
                width: 15,
              ),
              SmallBox(
                ontap: () {},
                icon: Icons.car_rental,
                text: "Reserve bus",
                height: height * 0.11,
                width: width * 0.27,
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Container(
            width: width * 0.9,
            height: height * 0.13,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: const BorderRadius.all(Radius.circular(30)),
            ),
            child: Column(
              // Center the elements vertically
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(30, 20, 10, 0),
                  child: Text(
                    "From                                                                             ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      // fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 8, 48, 8),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.pin_drop_outlined),
                      hintText: "Your Location ", // Add hint text here
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: width * 0.9,
            height: height * 0.13,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: const BorderRadius.all(Radius.circular(30)),
            ),
            child: Column(
              // Center the elements vertically
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(30, 20, 10, 0),
                  child: Text(
                    "To                                                                                  ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      // fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 8, 48, 8),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.place_outlined),
                      hintText: "Your Destination ", // Add hint text here
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}

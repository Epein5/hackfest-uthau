import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter_application_1/utils/popupmessages.dart';
import 'package:flutter_application_1/utils/routes/routes.dart';

class BusBookingPage extends StatefulWidget {
  @override
  _BusBookingPageState createState() => _BusBookingPageState();
}

class _BusBookingPageState extends State<BusBookingPage> {
  String passengerName = '';
  String contactNumber = '';
  List<int> bookedSeats = [];
  int numberOfPassengers = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bus Booking'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                onChanged: (value) {
                  setState(() {
                    passengerName = value;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Passenger Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                onChanged: (value) {
                  setState(() {
                    contactNumber = value;
                  });
                },
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Contact Number',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                onChanged: (value) {
                  setState(() {
                    numberOfPassengers = int.tryParse(value) ?? 1;
                  });
                },
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Number of Passengers',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Select Seat:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, // 2 columns, a gap, and 2 more columns
                  crossAxisSpacing: 10.0, // Gap between columns
                  mainAxisSpacing: 10.0, // Gap between rows
                  childAspectRatio: 1.2,
                ),
                itemCount: 30,
                itemBuilder: (context, index) {
                  int seatNumber = index + 1;
                  bool isBooked = bookedSeats.contains(seatNumber);
                  bool isSelectable =
                      !isBooked && seatNumber <= numberOfPassengers;

                  return GestureDetector(
                    onTap: isSelectable
                        ? () {
                            setState(() {
                              if (isBooked) {
                                bookedSeats.remove(seatNumber);
                              } else {
                                bookedSeats.add(seatNumber);
                              }
                            });
                          }
                        : null,
                    child: Container(
                      decoration: BoxDecoration(
                        color: isBooked
                            ? Colors.green
                            : isSelectable
                                ? Colors.grey[300]
                                : Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          seatNumber.toString(),
                          style: TextStyle(
                            color: isBooked ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Handle booking logic here
                  if (passengerName.isNotEmpty &&
                      contactNumber.isNotEmpty &&
                      numberOfPassengers > 0) {
                    List<int> availableSeats =
                        List.generate(30, (index) => index + 1);
                    availableSeats
                        .shuffle(); // Shuffle the list to get random seat numbers
                    bookedSeats =
                        availableSeats.sublist(0, min(numberOfPassengers, 30));

                    CollectionReference ref =
                        FirebaseFirestore.instance.collection('bus routes');
                    ref.doc('BA 1234').set({
                      'bookbusat${DateTime.now().millisecondsSinceEpoch}':
                          'BOOKING for $passengerName. Number of Passengers: $numberOfPassengers. Contact Number: $contactNumber. Seats: $bookedSeats '
                    }, SetOptions(merge: true)).then((value) {
                      PopUpMessages.snackBar(
                          "Alert Send Successfully", context);
                      Navigator.pushReplacementNamed(
                          context, RouteName.homeview);
                    }).onError((error, stackTrace) {
                      PopUpMessages.flushBarErrorMessage(
                          error.toString(), context);
                    });
                    print(
                        'Booking confirmed for $passengerName. Seats: $bookedSeats');
                  } else {
                    PopUpMessages.flushBarErrorMessage(
                        "Please Enter all fields", context);
                    print(
                        'Please fill in all the details and select the correct number of passengers.');
                  }
                },
                child: Text('Book Now'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

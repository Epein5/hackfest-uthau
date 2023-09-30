import 'package:flutter/material.dart';
import 'package:flutter_application_1/resources/components/boxes.dart';

class BookBusView extends StatefulWidget {
  @override
  _BusBookingPageState createState() => _BusBookingPageState();
}

class _BusBookingPageState extends State<BookBusView> {
  String passengerName = '';
  String contactNumber = '';
  int selectedSeat = -1;
  String Arrivaltime = '';
  String pickuplocation = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Bus Booking'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
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
                      Arrivaltime = value;
                    });
                  },
                  // keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Pickup Location',
                    suffix: Text("Hr:Min"),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      pickuplocation = value;
                    });
                  },
                  // keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Arrival Time',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Select Max Passengers:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 1.2,
                  ),
                  itemCount: 15, // assuming 30 seats
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedSeat = index + 1;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: selectedSeat == index + 1
                              ? Colors.green
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            (index + 1).toString(),
                            style: TextStyle(
                              color: selectedSeat == index + 1
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 20),
                RoundButton(
                    text: "Alert Driver and Book",
                    ontap: () {
                      // Handle booking logic here
                      if (passengerName.isNotEmpty &&
                          contactNumber.isNotEmpty &&
                          selectedSeat != -1) {
                        print(
                            'Booking confirmed for $passengerName. Seat Number: $selectedSeat contact number: $contactNumber Arrival Time: $Arrivaltime Pickuplocation $pickuplocation');
                      } else {
                        print('Please fill in all the details.');
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

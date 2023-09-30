import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/bookbus/bookbusoneicon.dart';

class Bus {
  String busNumber;
  String route;
  double fare;

  Bus({required this.busNumber, required this.route, required this.fare});
}

class BusSearchPage extends StatefulWidget {
  @override
  _BusSearchScreenState createState() => _BusSearchScreenState();
}

class _BusSearchScreenState extends State<BusSearchPage> {
  TextEditingController _fromController = TextEditingController();
  TextEditingController _toController = TextEditingController();
  DateTime? _selectedDate;
  List<Bus> buses = [
    Bus(busNumber: '123', route: 'Kathmandu to Pokhara', fare: 1000),
    Bus(busNumber: '456', route: 'Kathmandu to Pokhara', fare: 1200),
    Bus(busNumber: '789', route: 'Kathmandu to Pokhara', fare: 1500),
  ];

  List<Bus> filteredBuses = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 50,
            ),
            const Center(
              child: Text(
                'Search Buses',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(225, 0, 187, 134),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _fromController,
              decoration: const InputDecoration(
                labelText: 'From',
                border: OutlineInputBorder(),
                prefixIcon: Icon(
                  Icons.location_on,
                  color: Color.fromARGB(225, 0, 187, 134),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _toController,
              decoration: const InputDecoration(
                labelText: 'To',
                border: OutlineInputBorder(),
                prefixIcon: Icon(
                  Icons.location_on,
                  color: Color.fromARGB(225, 0, 187, 134),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: <Widget>[
                const Icon(
                  Icons.date_range,
                  color: Color.fromARGB(225, 0, 187, 134),
                ),
                const SizedBox(width: 10),
                const Text('Select Date:',
                    style: TextStyle(
                      color: Color.fromARGB(225, 0, 187, 134),
                    )),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    _selectDate(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(225, 0, 187, 134),
                  ),
                  child: Text(
                    _selectedDate != null ? '$_selectedDate' : 'Pick Date',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _searchBuses();
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(225, 0, 187, 134),
              ),
              child:
                  const Text('Search', style: TextStyle(color: Colors.white)),
            ),
            const Divider(color: Colors.green),
            Expanded(
              child: ListView.builder(
                itemCount: filteredBuses.length,
                itemBuilder: (context, index) {
                  Bus bus = filteredBuses[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const BookBusOne();
                      }));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Card(
                        borderOnForeground: true,
                        color: Colors.grey.shade300,
                        elevation: 4,
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              color: Color.fromARGB(225, 0, 187, 134),
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: const EdgeInsets.all(16),
                          leading: const Icon(
                            Icons.directions_bus,
                            color: Color.fromARGB(225, 0, 187, 134),
                          ),
                          title: Text('Bus Number: ${bus.busNumber}',
                              style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold)),
                          subtitle: Text(
                              'Route: ${bus.route}\nFare: Rs ${bus.fare.toString()}',
                              style: const TextStyle(
                                color: Color.fromARGB(225, 0, 187, 134),
                              )),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _searchBuses() {
    // Define busDate as October 1, 2023
    DateTime busDate = DateTime(2023, 10, 1);

    // Reset filteredBuses list
    filteredBuses.clear();

    // Check if 'From' and 'To' are 'Kathmandu' and 'Pokhara' and the selected date is October 1, 2023
    if (_fromController.text.toLowerCase() == 'kathmandu' &&
        _toController.text.toLowerCase() == 'pokhara' &&
        _selectedDate != null &&
        _selectedDate!.isAtSameMomentAs(
            DateTime(busDate.year, busDate.month, busDate.day))) {
      // Filter buses from 'Kathmandu' to 'Pokhara' on October 1, 2023
      filteredBuses = buses
          .where((bus) =>
              bus.route.contains('Kathmandu to Pokhara') &&
              busDate.isAtSameMomentAs(
                  DateTime(busDate.year, busDate.month, busDate.day)))
          .toList();

      // Sort buses by ascending order of fares
      filteredBuses.sort((a, b) => a.fare.compareTo(b.fare));
    } else {
      // If no matching buses found, show a message
      // You can also display a SnackBar or a Dialog for a better user experience
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('No Buses Found'),
            content: const Text('No buses found for the given criteria.'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    setState(() {});
  }
}

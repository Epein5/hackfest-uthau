import 'package:flutter/material.dart';

class BusInfoTile extends StatelessWidget {
  final String busPhoto;
  final String route;
  final String busNumber;
  final VoidCallback onTap;

  BusInfoTile({
    required this.busPhoto,
    required this.route,
    required this.busNumber,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          border: Border.all(color:const  Color.fromARGB(225, 0, 187, 134)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color.fromARGB(225, 0,  187, 134).withOpacity(0.35),
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(busPhoto),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Route: $route",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Bus Number: $busNumber",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

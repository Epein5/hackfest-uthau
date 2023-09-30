class BusInfo {
  final String busNo;
  final String driverName;
  final String driverPhoneNumber;
  final int totalPassengers;
  final String route;
  final String driverPhoto; // Store the driver's photo URL or path here

  BusInfo({
    required this.busNo,
    required this.driverName,
    required this.driverPhoneNumber,
    required this.totalPassengers,
    required this.route,
    required this.driverPhoto,
  });
}
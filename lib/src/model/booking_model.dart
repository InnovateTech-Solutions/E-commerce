class Booking {
  String vendorName;
  String date;
  String time;
  String userEmail;
  List<String> services;
  String note;
  double totalPrice;

  Booking({
    required this.vendorName,
    required this.date,
    required this.time,
    required this.userEmail,
    required this.services,
    required this.note,
    required this.totalPrice,
  });

factory Booking.fromMap(Map<String, dynamic> data) {
  return Booking(
    userEmail: data['userEmail'],
    vendorName: data['vendorName'],
    date: data['date'],
    time: data['time'],
    note: data['note'],
    services: (data["services"] as List).map((e) => e.toString()).toList(),
    totalPrice: (data['totalPrice'] as double),
  );
}

Map<String, dynamic> toMap() {
  return {
    'userEmail': userEmail,
    'vendorName': vendorName,
    'date': date,
    'time': time,
    'services': services,
    'note': note,
    'totalPrice': totalPrice,
  };
}
}
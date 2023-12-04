class HistoryModel {
  final String vendorname;

  final String vendorImg;
  final dynamic listofservices;
  final String userEmail;
  final String time;
  final String date;
  final String totalprice;

  HistoryModel(
      {required this.vendorname,
      required this.vendorImg,
      required this.userEmail,
      required this.date,
      required this.time,
      required this.listofservices,
      required this.totalprice});
}

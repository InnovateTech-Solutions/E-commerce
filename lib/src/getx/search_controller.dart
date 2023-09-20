import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchControllerr extends GetxController {
  RxList<Map<String, dynamic>> services = <Map<String, dynamic>>[].obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    // Initialize your services data here, fetch data from Firestore.
    // Replace this with your actual data retrieval logic.
    fetchServicesFromFirestore();
  }

  Future<void> fetchServicesFromFirestore() async {
    try {
      final QuerySnapshot querySnapshot = await _firestore.collection('Services').get();

      final servicesList = querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
      services.assignAll(servicesList);
      print(services);
    } catch (error) {
      print('Error fetching services: $error');
    }
  }

  RxList<Map<String, dynamic>> searchServices(String query) {
    if (query.isEmpty) {
      return services;
    }
    
    return services.where((service) {
      final serviceName = service['Name'].toLowerCase();
      final serviceDescription = service['Description'].toLowerCase();
      return serviceName.contains(query.toLowerCase()) ||
          serviceDescription.contains(query.toLowerCase());
    }).toList().obs;
  
  }
}

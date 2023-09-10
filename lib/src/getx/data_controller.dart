import 'package:ecommerce/src/repository/service_repository/service_data.dart';
import 'package:get/get.dart';

class DataController extends GetxController {
  static DataController get instance => Get.find();

  final FirebaseService _firebaseService;

  DataController(this._firebaseService);

  final RxList<Map<String, dynamic>> dataList = <Map<String, dynamic>>[].obs;

  Future<void> fetchData() async {
    try {
      List<Map<String, dynamic>> data = await _firebaseService.fetchData();
      dataList.assignAll(data);
    } catch (e) {
      // Handle error
    }
  }
}

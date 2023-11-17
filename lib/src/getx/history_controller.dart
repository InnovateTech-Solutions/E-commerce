import 'package:get/get.dart';
import 'package:profile_part/src/model/history_model.dart';

class HistoryController extends GetxController {
  static HistoryController get instance => Get.find();
  RxList<HistoryModel> history = <HistoryModel>[
    HistoryModel(vendor: "vendor", time: "time", image: "image"),
  ].obs;
}

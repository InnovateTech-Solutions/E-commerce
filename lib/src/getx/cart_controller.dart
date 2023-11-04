import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/model/service_model.dart';

class ServiceController extends GetxController {
  var _cartItems = <ServiceModel>[].obs;
  RxInt total = 0.obs;
  List<ServiceModel> get cartItems => _cartItems;
  List<String> cartItemsNames = [];
  RxInt counter = 0.obs;
  bool selecteditem = false;

    @override
  void onInit() {
    super.onInit();
  }


 

  void removeFromCart(ServiceModel serviceModel) {
    String price = serviceModel.price.replaceAll('BD', '');
    int priceoverall = int.parse(price);
    _cartItems.remove(serviceModel);
    counter = counter - priceoverall;
    update();
  }

  totalCart(ServiceModel serviceModel) {
    String price = serviceModel.price.replaceAll('BD', '');
    int priceoverall = int.parse(price);
    counter = counter + priceoverall;
    update();

    //   to update counter variable on UI when increment be called
  }

  void clearCart() {
    _cartItems.clear();
    counter = 0.obs;
  }

  //to select one service

  void toggleServerSelection(int index) {
    _cartItems[index].isSelected!.value = !_cartItems[index].isSelected!.value;
  }

  void toggleService(ServiceModel service) {
    String price = service.price.replaceAll('BD', '');
    int priceoverall = int.parse(price);
    if (cartItems.contains(service) && cartItemsNames.contains(service.name)) {
      counter = counter - priceoverall;
      _cartItems.remove(service);
      cartItemsNames.remove(service.name);
      update();
      Fluttertoast.showToast(
          msg: 'You have already selected this service.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorConstants.backProductButton,
          textColor: ColorConstants.mainTextColor,
          fontSize: 16.0.sp);
    } else {
      counter = counter + priceoverall;
      _cartItems.add(service);
      cartItemsNames.add(service.name);
      update();
    }
  }
}

import 'package:get/get.dart';
import 'package:profile_part/src/model/service_model.dart';

class ServiceController extends GetxController {
  var _cartItems = <ServiceModel>[].obs;
  RxInt total = 0.obs;
  List<ServiceModel> get cartItems => _cartItems;
  RxInt counter = 0.obs;
  bool selecteditem = false;

  void addToCart(ServiceModel serviceModel) {
    _cartItems.add(serviceModel);
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
    if (cartItems.contains(service)) {
      counter = counter - priceoverall;
      _cartItems.remove(service);
      update();
    } else {
      counter = counter + priceoverall;
      _cartItems.add(service);
      update();
    }
  }
}

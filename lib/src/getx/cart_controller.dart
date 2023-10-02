import 'package:get/get.dart';
import 'package:profile_part/src/model/service_model.dart';

class ServiceController extends GetxController {
  final _cartItems = <ServiceModel>[].obs;
  RxInt total = 0.obs;
  List<ServiceModel> get cartItems => _cartItems;
  RxInt counter = 0.obs;
  RxBool isSelectService = false.obs;
  void addToCart(ServiceModel serviceModel) {
    _cartItems.add(serviceModel);
  }

  void removeFromCart(ServiceModel serviceModel) {
    _cartItems.remove(serviceModel);
  }

  void totalCart(ServiceModel serviceModel) {
    String price = serviceModel.price.replaceAll('BD', '');
    int priceoverall = int.parse(price);
    counter = counter + priceoverall;

    update();

    //   to update counter variable on UI when increment be called
  }

  void clearCart() {
    _cartItems.clear();
  }
}

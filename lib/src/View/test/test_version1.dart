import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(ShoppingCartApp());
}

class Product {
  final String name;
  final double price;

  Product(this.name, this.price);
}

class CartController extends GetxController {
  final _cartItems = <Product>[].obs;

  List<Product> get cartItems => _cartItems;

  void addToCart(Product product) {
    _cartItems.add(product);
  }

  void removeFromCart(Product product) {
    _cartItems.remove(product);
  }
}

class ShoppingCartApp extends StatelessWidget {
  final cartController = Get.put(CartController());

  final List<Product> products = [
    Product('Product 1', 10.0),
    Product('Product 2', 15.0),
    Product('Product 3', 20.0),
    Product('Product 4', 25.0),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping Cart App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Shopping Cart'),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ListTile(
                    title: Text(product.name),
                    subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                    trailing: IconButton(
                      icon: Icon(Icons.add_shopping_cart),
                      onPressed: () {
                        cartController.addToCart(product);
                      },
                    ),
                  );
                },
              ),
            ),
            Obx(
              () => Text(
                'Total: \$${cartController.cartItems.fold<double>(0.0, (sum, item) => sum + item.price).toStringAsFixed(2)}',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(
                    OrderSummaryPage()); // Navigate to the order summary page
              },
              child: Text('Place Order'),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderSummaryPage extends StatelessWidget {
  final cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Summary'),
      ),
      body: Column(
        children: [
          Text(
            'Selected Products:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cartController.cartItems.length,
              itemBuilder: (context, index) {
                final product = cartController.cartItems[index];
                return ListTile(
                  title: Text(product.name),
                  subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../constant/color.dart';
import '../../widget/constant_widget/App_Bar/first_appbar.dart';
import '../../widget/pages_widget/Products/products_widget.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({required this.title, Key? key}) : super(key: key);
  final String title;

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.mainScaffoldBackgroundColor,
      appBar: productsAppBar(widget.title),
      body: ProductsWidget(
        widget.title,
      ),
    );
  }
}

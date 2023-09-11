import 'package:flutter/material.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/model/service_model.dart';
import 'package:profile_part/src/widget/pages_widget/Products/products_widget.dart';

import '../../widget/constant_widget/App_Bar/first_appbar.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({required this.id, required this.title, Key? key})
      : super(key: key);
  final String id;
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
        id: widget.id,
        category: widget.title,
      ),
    );
  }
}

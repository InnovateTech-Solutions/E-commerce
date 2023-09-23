import 'package:flutter/material.dart';
import '../../constant/color.dart';
import '../../widget/constant_widget/App_Bar/first_appbar.dart';
import '../../widget/pages_widget/NavBar_widgets/categories_widget.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstants.secondaryScaffoldBacground,
        appBar: secondAppBar(),
        body: CategoriesWidget(),
      ),
    );
  }
}

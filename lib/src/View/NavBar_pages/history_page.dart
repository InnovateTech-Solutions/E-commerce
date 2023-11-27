import 'package:flutter/material.dart';
import 'package:profile_part/src/widget/custom_Widget.dart/drawer_widget.dart';
import 'package:profile_part/src/widget/pages_widget/NavBar_widgets/history_widget.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          drawer: Drawer(
            child: DrawerWidget(),
          ),
          body: SingleChildScrollView(
              scrollDirection: Axis.vertical, child: HistoryWidget())),
    );
  }
}

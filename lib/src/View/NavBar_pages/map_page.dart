import 'package:flutter/material.dart';
import 'package:profile_part/src/widget/pages_widget/NavBar_widgets/map_widget.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: MapWidget(),
      ),
    );
  }
}

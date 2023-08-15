import 'package:flutter_svg/svg.dart';

class Profile {
  late SvgPicture icon;
  late String txt;
  late String destinationRoute;

  Profile(
      {required this.txt, required this.icon, required this.destinationRoute});
}

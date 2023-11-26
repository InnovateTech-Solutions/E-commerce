import 'package:flutter/material.dart';

class SearchFormEntitiy {
  TextEditingController? searchController = TextEditingController();
  String hintText;
  Icon icon;

  TextInputType type;
  void Function(String?)? onChange;

  SearchFormEntitiy({
    this.searchController,
    required this.hintText,
    required this.icon,
    required this.type,
    required this.onChange,
  });
}

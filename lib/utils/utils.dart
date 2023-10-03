import 'package:flutter/material.dart';

class Utils {
  final BuildContext context;

  Utils({required this.context});

  double percentageOfScreenSize(double percentage) {
    return _getScreenSize(context) * (percentage * 100);
  }

  double _getScreenSize(context) {
    return MediaQuery.of(context).size.width;
  }
}

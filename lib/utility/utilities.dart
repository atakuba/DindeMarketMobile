import 'package:flutter/material.dart';

class Utilities {

  static setWidgetWidthByPercentage(BuildContext context, double percentage) {
    return (percentage/100)*MediaQuery.of(context).size.width;
  }
  static setWidgetHeightByPercentage(BuildContext context, double percentage) {
    return (percentage/100)*MediaQuery.of(context).size.height;
  }
}
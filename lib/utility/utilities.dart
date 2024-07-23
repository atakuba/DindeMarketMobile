import 'package:flutter/material.dart';

class Utilities {

  static screenWidthByPercentage(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.width * (percentage/100);
  }
  static screenHeightByPercentage(BuildContext context,double percentage) {
    return MediaQuery.of(context).size.height * (percentage/100);
  }
  static setWidgetWidthByPercentage(BuildContext context, double percentage) {
    return (percentage/100)*MediaQuery.of(context).size.width;
  }
  static setWidgetHeightByPercentage(BuildContext context, double percentage) {
    return (percentage/100)*MediaQuery.of(context).size.height;
  }
}
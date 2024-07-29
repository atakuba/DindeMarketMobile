import 'package:dinde_market/utility/utilities.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(98, 175, 28, 1),
      body: Center(
            child: Image(image: const AssetImage('assets/white_logo.png'), width: Utilities.setWidgetWidthByPercentage(context, 40)),
      )
    );
  }
}

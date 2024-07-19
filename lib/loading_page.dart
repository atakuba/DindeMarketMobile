import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 61, 160, 64),
      body: Center(
            child: Image(image: AssetImage('assets/logo.png'), width: 300),
      )
    );
  }
}

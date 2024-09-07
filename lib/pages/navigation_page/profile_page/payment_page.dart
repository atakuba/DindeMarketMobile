import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.pink,
      child: TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text("GO BACK"),
      ),
    );
  }
}
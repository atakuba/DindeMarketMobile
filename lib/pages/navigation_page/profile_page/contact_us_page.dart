import 'package:flutter/material.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
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
import 'package:flutter/material.dart';

class AboutAppPage extends StatefulWidget {
  const AboutAppPage({super.key});

  @override
  State<AboutAppPage> createState() => _AboutAppPageState();
}

class _AboutAppPageState extends State<AboutAppPage> {
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
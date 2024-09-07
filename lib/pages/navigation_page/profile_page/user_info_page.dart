import 'package:flutter/material.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({super.key});

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
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
import 'package:flutter/material.dart';

class LogOut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Row(
      children: [
        Icon(Icons.logout),
        SizedBox(
          width: 10,
        ),
        Text(
          'Log Out',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        )
      ],
    ));
  }
}

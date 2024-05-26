import 'package:flutter/material.dart';

class list_tile extends StatelessWidget {
  final String title;
  final Icon leading;

  list_tile({required this.title, required this.leading});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        leading,
        SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
              fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

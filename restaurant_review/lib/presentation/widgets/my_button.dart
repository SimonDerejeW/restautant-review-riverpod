import 'package:flutter/material.dart';
class MyDialogButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;


  const MyDialogButton(
      {super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: const Color.fromARGB(255, 245, 149, 24),
      child: Text(text),
    );
  }
}
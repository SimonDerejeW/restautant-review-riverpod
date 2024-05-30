import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final VoidCallback? onPressed;

  const Buttons(
      {super.key,
      required this.text,
      required this.backgroundColor,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      // width: 100,
      // constraints: BoxConstraints(
      //   maxWidth:
      // ),
      child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(backgroundColor),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          )),
    );
  }
}

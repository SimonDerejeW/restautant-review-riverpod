import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final VoidCallback? onPressed;

  Buttons({required this.text, required this.backgroundColor, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      // width: 100,
      // constraints: BoxConstraints(
      //   maxWidth:
      // ),
      child: ElevatedButton(
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          )),
    );
  }
}

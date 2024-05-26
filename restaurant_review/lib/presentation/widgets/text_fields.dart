import 'package:flutter/material.dart';

class Textfields extends StatelessWidget {
  final String subtitles;

  Textfields({required this.subtitles});
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(subtitles),
      Container(
          margin: EdgeInsets.only(top: 10, bottom: 10),
          height: 30,
          child: TextField(
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8))),
          ))
    ]);
  }
}

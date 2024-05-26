import 'package:flutter/material.dart';

class Comment extends StatelessWidget {
  final Widget user_info;
  final String comment;

  Comment({required this.user_info, required this.comment});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          user_info,
          Text(comment),
        ],
      ),
    );
  }
}

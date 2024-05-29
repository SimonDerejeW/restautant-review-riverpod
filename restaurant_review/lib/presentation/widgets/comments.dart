import 'package:flutter/material.dart';

class Comment extends StatelessWidget {
  final Widget user_info;
  final String comment;

  const Comment({super.key, required this.user_info, required this.comment});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          user_info,
          Text(comment),
        ],

      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:restaurant_review/core/theme/app_pallete.dart';

class UsersView extends StatelessWidget {
  const UsersView({
    super.key,
    required this.name,
    required this.isBanned,
    required this.onChanged,
  });

  final String name;
  final bool isBanned;
  final ValueChanged<bool> onChanged;
  // Add this

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(color: AppPallete.gradient1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage("assets/images/avator.jpg"),
          ),
          const SizedBox(width: 20),
          Text(name),
          const SizedBox(
            width: 20,
          ),
          Switch(
            value: isBanned,
            onChanged: onChanged,
          )
        ],
      ),
    );
  }
}

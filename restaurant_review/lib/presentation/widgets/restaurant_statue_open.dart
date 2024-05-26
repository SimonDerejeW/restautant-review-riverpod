import 'package:flutter/material.dart';
import 'package:restaurant_review/core/theme/app_pallete.dart';
class RestaurantOpen extends StatelessWidget {
  const RestaurantOpen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Open",
      style: TextStyle(
        color: AppPallete.greenColor,
        fontWeight: FontWeight.bold,
      )
    );
  }
}
import 'package:flutter/material.dart';
import 'package:restaurant_review/core/theme/app_pallete.dart';
class RestaurantClosed extends StatelessWidget {
  const RestaurantClosed({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Closed",
      style: TextStyle(
        color: AppPallete.redColor,
        fontWeight: FontWeight.bold,
      )
    );
  }
}
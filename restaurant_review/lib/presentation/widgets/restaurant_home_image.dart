import 'package:flutter/material.dart';

class RestaurantHomeImage extends StatelessWidget {
  final String imagePath;

  const RestaurantHomeImage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset(
        imagePath,
        fit: BoxFit.cover,
        height: 160,
        width: 160,
      ),
    );
  }
}

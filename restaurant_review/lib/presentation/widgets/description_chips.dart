import 'package:flutter/material.dart';
import 'package:restaurant_review/core/theme/app_pallete.dart';
class RestaurantChips extends StatelessWidget {

  final String labelText;
  const RestaurantChips({super.key , required this.labelText});

  @override
  Widget build(BuildContext context) {
    return 
          Chip(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            label: Text(
              labelText,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12
              ),
            ),
            backgroundColor: AppPallete.greyColor,
            side: BorderSide.none,
          );       
  }
}
import 'package:flutter/material.dart';

import 'package:restaurant_review/presentation/widgets/description_chips.dart';
import 'package:restaurant_review/presentation/widgets/restaurant_home_image.dart';
import 'package:restaurant_review/presentation/widgets/restaurant_statue_open.dart';
import 'package:restaurant_review/presentation/widgets/restaurant_status_closed.dart';

// import '../data/chips_data.dart';

class Restaurant extends StatelessWidget {
  final String imagePath;
  final String restaurantName;
  final String status;
  final List<String> chipsList;

  const Restaurant(
      {super.key,
      required this.imagePath,
      required this.restaurantName,
      required this.status,
      required this.chipsList});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Image
          Expanded(child: RestaurantHomeImage(imagePath: imagePath)),

          const SizedBox(height: 10),

          //Restaurant Name
          Padding(
            padding: const EdgeInsets.only(left: 9),
            child: Text(
              restaurantName,
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                color: Colors.black
              )
            ),
          ),

          const SizedBox(height: 3),

          //Status
          if (status == "open")
            (const Padding(
              padding: EdgeInsets.only(left: 9),
              child: (RestaurantOpen()),
            ))
          else
            (const Padding(
              padding: EdgeInsets.only(left: 9),
              child: (RestaurantClosed()),
            )),

          const SizedBox(height: 6),

          //Chips
          Padding(
            padding: const EdgeInsets.only(left: 3),
            child: Wrap(
              children: chipsList.map((labelText) {
                return Padding(
                  padding: const EdgeInsets.only(
                      right: 5.0), // Add spacing between chips
                  child: RestaurantChips(
                    labelText: labelText,
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

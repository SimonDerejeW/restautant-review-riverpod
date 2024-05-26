import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:restaurant_review/presentation/widgets/restaurant.dart';
// import '/models/restaurant_model.dart';

import '../widgets/search_widget.dart';
import '/data/restaurant_data.dart';


class ReviewHome extends StatelessWidget {
  const ReviewHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Restaurant Review", 
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold
              
            )
        ),
        centerTitle: true,
      ),
      body: Column(
      children: [
        const SearchWidget(),
        const SizedBox(
          height: 15,
        ),
        Expanded(
          child: Container(
              padding: const EdgeInsets.only(left: 10),
              child: const RestaurantGrid()),
        ),
      ],
    ));
  }
}

class RestaurantGrid extends StatelessWidget {
  const RestaurantGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of columns in the grid
        crossAxisSpacing: 3, // Spacing between columns
        mainAxisSpacing: 10,
        childAspectRatio: 0.7,

      ),

      itemCount: restaurantData.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          child: Restaurant(
            imagePath: restaurantData[index].imagePath,
            restaurantName: restaurantData[index].restaurantName,
            status: restaurantData[index].status,
            chipsList: restaurantData[index].chipsList,
          ),
          onTap: () {
            Navigator.pushNamed(context, '/restaurantpage');

          },
        );
      },
    );
  }
}

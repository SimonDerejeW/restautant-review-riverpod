import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:restaurant_review/models/restaurant_model.dart';
import 'package:restaurant_review/presentation/screens/Restaurant_page.dart';
import 'package:restaurant_review/presentation/widgets/restaurant.dart';
// import '/models/restaurant_model.dart';

import '../widgets/search_widget.dart';
import '/data/restaurant_data.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../fetch_test/restaurant_provider.dart';

class ReviewHome extends ConsumerWidget {
  const ReviewHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restaurantList = ref.watch(restaurantProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Restaurant Review",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
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
            child: restaurantList.when(
              data: (restaurants) {
                return RestaurantGrid(restaurants: restaurants);
              },
              loading: () => CircularProgressIndicator(),
              error: (error, stackTrace) => Text('Error: $error'),
            ),
          ),
        ],
      ),
    );
  }
}

class RestaurantGrid extends StatelessWidget {
  final List<RestaurantModel> restaurants;

  const RestaurantGrid({Key? key, required this.restaurants}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of columns in the grid
        crossAxisSpacing: 3, // Spacing between columns
        mainAxisSpacing: 10,
        childAspectRatio: 0.7,
      ),
      itemCount: restaurants.length,
      itemBuilder: (context, index) {
        final restaurant = restaurants[index];
        return GestureDetector(
          child: Restaurant(
            imagePath: restaurant.imagePath,
            restaurantName: restaurant.restaurantName,
            status: restaurant.status,
            chipsList: restaurant.chipsList,
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    RestaurantPage(restaurantId: restaurant.id),
              ),
            );
          },
        );
      },
    );
  }
}

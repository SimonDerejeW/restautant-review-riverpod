import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_review/application/retaurant/restaurant_event.dart';
import 'package:restaurant_review/application/retaurant/restaurant_provider.dart';
import 'package:restaurant_review/application/retaurant/restaurant_state.dart';
import 'package:restaurant_review/infrastructure/restaurant/restaurant_dto.dart';
import 'package:restaurant_review/presentation/screens/restaurant_page.dart';
import 'package:restaurant_review/presentation/widgets/restaurant.dart';
import '../widgets/search_widget.dart';

class ReviewHome extends ConsumerStatefulWidget {
  const ReviewHome({Key? key}) : super(key: key);

  @override
  _ReviewHomeState createState() => _ReviewHomeState();
}

class _ReviewHomeState extends ConsumerState<ReviewHome> {
  @override
  void initState() {
    super.initState();
    // Trigger the FetchRestaurantsRequested event
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(restaurantNotifierProvider.notifier)
          .mapEventToState(FetchRestaurantsRequested());
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<RestaurantState>(restaurantNotifierProvider, (previous, next) {
      if (next is RestaurantError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.message)),
        );
      }
    });

    final state = ref.watch(restaurantNotifierProvider);

    Widget body;
    if (state is RestaurantInitial) {
      body = const Center(child: CircularProgressIndicator());
    } else if (state is RestaurantLoading) {
      body = const Center(child: CircularProgressIndicator());
    } else if (state is RestaurantLoaded) {
      body = Column(
        children: [
          const SearchWidget(),
          const SizedBox(height: 15),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 10),
              child: RestaurantGrid(restaurants: state.restaurants),
            ),
          ),
        ],
      );
    } else if (state is RestaurantError) {
      body = Center(child: Text('Error: ${state.message}'));
    } else {
      body = const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Restaurant Review",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: body,
    );
  }
}

class RestaurantGrid extends StatelessWidget {
  final List<RestaurantDTO> restaurants;

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
        if (restaurant.isBanned) {
          return const SizedBox.shrink(); // Don't display banned restaurants
        }
        return GestureDetector(
          child: Restaurant(
            imagePath:
                'assets/burger.jpg', // Assuming you have an image path in your model
            restaurantName: restaurant.name,
            status: 'open', // Assuming you have a status in your model
            chipsList: const [
              "International"
            ], // Assuming you have a chipsList in your model
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

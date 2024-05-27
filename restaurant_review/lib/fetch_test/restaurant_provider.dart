import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/models/restaurant_model.dart';
import 'restaurant_api.dart'; // Import the file where fetchRestaurants function is defined

final restaurantProvider = FutureProvider<List<RestaurantModel>>((ref) async {
  return fetchRestaurants();
});

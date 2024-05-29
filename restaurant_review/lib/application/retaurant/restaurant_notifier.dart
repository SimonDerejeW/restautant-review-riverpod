import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:restaurant_review/infrastructure/restaurant/restaurant_repository.dart';
import 'restaurant_state.dart';
import 'restaurant_event.dart';

class RestaurantNotifier extends StateNotifier<RestaurantState> {
  final RestaurantRepository _restaurantRepository;

  RestaurantNotifier(this._restaurantRepository) : super(RestaurantInitial());

  Future<void> mapEventToState(RestaurantEvent event) async {
    if (event is FetchRestaurantsRequested) {
      await _fetchRestaurants();
    } else if (event is FetchRestaurantByIdRequested) {
      await _fetchRestaurantById(event.id);
    } else if (event is RestaurantErrorOccurred) {
      state = RestaurantError(event.message);
    }
  }

  Future<void> _fetchRestaurants() async {
    state = RestaurantLoading();
    final restaurants = await _restaurantRepository.fetchAllRestaurants();
    restaurants.fold((failure) => state = RestaurantError(failure.message),
        (restaurants) => state = RestaurantLoaded(restaurants));
  }

  Future<void> _fetchRestaurantById(String id) async {
    state = RestaurantLoading();
    final restaurant = await _restaurantRepository.fetchRestaurantById(id);
    restaurant.fold((failure) => state = RestaurantError(failure.message),
        (restaurant) => state = RestaurantDetailLoaded(restaurant));
  }
}

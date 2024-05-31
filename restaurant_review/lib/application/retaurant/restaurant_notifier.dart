import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_review/infrastructure/restaurant/create_restaurant_dto.dart';
import 'package:restaurant_review/infrastructure/restaurant/restaurant_dto.dart';
import 'package:restaurant_review/infrastructure/restaurant/restaurant_repository.dart';
import 'package:restaurant_review/infrastructure/restaurant/update_restaurant_dto.dart';
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
    } else if (event is CreateRestaurantRequested) {
      await _createRestaurant(event.restaurant);
    } else if (event is UpdateRestaurantRequested) {
      await _updateRestaurant(event.restaurant);
    } else if (event is DeleteRestaurantRequested) {
      await _deleteRestaurant();
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

  Future<void> _createRestaurant(CreateRestaurantDTO restaurant) async {
    state = RestaurantCreationLoading();
    final result = await _restaurantRepository.createRestaurant(restaurant);
    result.fold(
      (failure) => state = RestaurantError(failure.message),
      (createdRestaurant) => state = RestaurantCreated(createdRestaurant),
    );
  }

  Future<void> _updateRestaurant(UpdateRestaurantDTO restaurant) async {
    state = RestaurantUpdateLoading();
    final updatedRestaurant =
        await _restaurantRepository.updateRestaurant(restaurant);
    print("UP $updatedRestaurant");
    updatedRestaurant.fold(
      (failure) => state = RestaurantError(failure.message),
      (restaurant) => state = RestaurantUpdated(restaurant),
    );
  }

  Future<void> _deleteRestaurant() async {
    state = RestaurantDeleteLoading();
    final result = await _restaurantRepository.deleteRestaurant();
    result.fold(
      (failure) => state = RestaurantError(failure.message),
      (success) => state = RestaurantDeleted(),
    );
  }
}

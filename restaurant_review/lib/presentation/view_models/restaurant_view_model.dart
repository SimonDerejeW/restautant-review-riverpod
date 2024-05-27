import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/use_cases/restaurant_use_cases.dart';
import '../../domain/entities/restaurant.dart';
import '../../domain/failures/failure.dart';
import '../providers/restaurant_providers.dart';

class RestaurantState {
  final List<Restaurant> restaurants;
  final Restaurant? selectedRestaurant;
  final bool isLoading;
  final Failure? failure;

  RestaurantState(
      {this.restaurants = const [],
      this.selectedRestaurant,
      this.isLoading = false,
      this.failure});

  RestaurantState copyWith(
      {List<Restaurant>? restaurants,
      Restaurant? selectedRestaurant,
      bool? isLoading,
      Failure? failure}) {
    return RestaurantState(
      restaurants: restaurants ?? this.restaurants,
      selectedRestaurant: selectedRestaurant ?? this.selectedRestaurant,
      isLoading: isLoading ?? this.isLoading,
      failure: failure ?? this.failure,
    );
  }
}

class RestaurantNotifier extends StateNotifier<RestaurantState> {
  final RestaurantUseCases useCases;

  RestaurantNotifier(this.useCases) : super(RestaurantState());

  Future<void> getAllRestaurants() async {
    state = state.copyWith(isLoading: true);
    final result = await useCases.getAllRestaurants();
    result.fold(
      (failure) => state = state.copyWith(isLoading: false, failure: failure),
      (restaurants) =>
          state = state.copyWith(isLoading: false, restaurants: restaurants),
    );
  }

  Future<void> getRestaurantById(String id) async {
    state = state.copyWith(isLoading: true);
    final result = await useCases.getRestaurantById(id);
    result.fold(
      (failure) => state = state.copyWith(isLoading: false, failure: failure),
      (restaurant) => state =
          state.copyWith(isLoading: false, selectedRestaurant: restaurant),
    );
  }

  Future<void> createRestaurant(Restaurant restaurant) async {
    state = state.copyWith(isLoading: true);
    final result = await useCases.createRestaurant(restaurant);
    result.fold(
      (failure) => state = state.copyWith(isLoading: false, failure: failure),
      (_) => getAllRestaurants(),
    );
  }

  Future<void> updateRestaurant(Restaurant restaurant) async {
    state = state.copyWith(isLoading: true);
    final result = await useCases.updateRestaurant(restaurant);
    result.fold(
      (failure) => state = state.copyWith(isLoading: false, failure: failure),
      (_) => getAllRestaurants(),
    );
  }

  Future<void> deleteRestaurant(String id) async {
    state = state.copyWith(isLoading: true);
    final result = await useCases.deleteRestaurant(id);
    result.fold(
      (failure) => state = state.copyWith(isLoading: false, failure: failure),
      (_) => getAllRestaurants(),
    );
  }
}

final restaurantNotifierProvider =
    StateNotifierProvider<RestaurantNotifier, RestaurantState>((ref) {
  final restaurantUseCases = ref.read(restaurantUseCasesProvider);
  return RestaurantNotifier(restaurantUseCases);
});

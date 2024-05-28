import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_review/infrastructure/restaurant/restaurant_repository.dart';
import 'package:restaurant_review/infrastructure/restaurant/restuarant_service.dart';
import 'restaurant_notifier.dart';
import 'restaurant_state.dart';

// Define a provider for RestaurantService
final restaurantServiceProvider = Provider<RestaurantService>((ref) {
  return RestaurantService();
});

// Define a provider for RestaurantRepository, which depends on RestaurantService
final restaurantRepositoryProvider = Provider<RestaurantRepository>((ref) {
  final restaurantService = ref.watch(restaurantServiceProvider);
  return RestaurantRepository(restaurantService);
});

// Define a StateNotifierProvider for RestaurantNotifier
final restaurantNotifierProvider =
    StateNotifierProvider<RestaurantNotifier, RestaurantState>((ref) {
  final restaurantRepository = ref.watch(restaurantRepositoryProvider);
  return RestaurantNotifier(restaurantRepository);
});

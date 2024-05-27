import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/use_cases/restaurant_use_cases.dart';
import '../../infrastructure/repositories/restaurant_repository.dart';
import '../../infrastructure/data_sources/remote/restaurant_remote_data_source.dart';

// Provider for RestaurantRepository
final restaurantRepositoryProvider = Provider<RestaurantRepository>((ref) {
  final restaurantRemoteDataSource = RestaurantRemoteDataSource();
  return RestaurantRepository(restaurantRemoteDataSource);
});

// Provider for RestaurantUseCases
final restaurantUseCasesProvider = Provider<RestaurantUseCases>((ref) {
  final restaurantRepository = ref.watch(restaurantRepositoryProvider);
  return RestaurantUseCases(restaurantRepository);
});

import 'package:dartz/dartz.dart';
import '../../domain/failures/failure.dart';
import '../../domain/entities/restaurant.dart';
import '../../infrastructure/repositories/restaurant_repository.dart';

class RestaurantUseCases {
  final RestaurantRepository repository;

  RestaurantUseCases(this.repository);

  Future<Either<Failure, List<Restaurant>>> getAllRestaurants() {
    return repository.getAllRestaurants();
  }

  Future<Either<Failure, Restaurant>> getRestaurantById(String id) {
    return repository.getRestaurantById(id);
  }

  Future<Either<Failure, void>> createRestaurant(Restaurant restaurant) {
    return repository.createRestaurant(restaurant);
  }

  Future<Either<Failure, void>> updateRestaurant(Restaurant restaurant) {
    return repository.updateRestaurant(restaurant);
  }

  Future<Either<Failure, void>> deleteRestaurant(String id) {
    return repository.deleteRestaurant(id);
  }
}

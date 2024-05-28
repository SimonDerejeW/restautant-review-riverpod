import 'package:dartz/dartz.dart';
import 'package:restaurant_review/infrastructure/restaurant/restaurant_dto.dart';
import 'restaurant_failure.dart';

abstract class RestaurantRepositoryInterface {
  Future<Either<RestaurantFailure, List<RestaurantDTO>>> fetchAllRestaurants();
  Future<Either<RestaurantFailure, RestaurantDTO>> fetchRestaurantById(
      String id);
}

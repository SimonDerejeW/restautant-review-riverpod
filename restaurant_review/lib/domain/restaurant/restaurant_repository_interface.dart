import 'package:dartz/dartz.dart';
import 'package:restaurant_review/infrastructure/restaurant/create_restaurant_dto.dart';
import 'package:restaurant_review/infrastructure/restaurant/restaurant_dto.dart';
import 'package:restaurant_review/infrastructure/restaurant/update_restaurant_dto.dart';
import 'restaurant_failure.dart';

abstract class RestaurantRepositoryInterface {
  Future<Either<RestaurantFailure, List<RestaurantDTO>>> fetchAllRestaurants();
  Future<Either<RestaurantFailure, RestaurantDTO>> fetchRestaurantById(
      String id);
  Future<Either<RestaurantFailure, CreateRestaurantDTO>> createRestaurant(
      CreateRestaurantDTO restaurant);
  Future<Either<RestaurantFailure, UpdateRestaurantDTO>> updateRestaurant(
      UpdateRestaurantDTO restaurant);
  Future<Either<RestaurantFailure, Unit>> deleteRestaurant();
}

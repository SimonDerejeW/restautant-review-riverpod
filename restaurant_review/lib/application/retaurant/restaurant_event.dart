import 'package:restaurant_review/infrastructure/restaurant/create_restaurant_dto.dart';
import 'package:restaurant_review/infrastructure/restaurant/restaurant_dto.dart';
import 'package:restaurant_review/infrastructure/restaurant/update_restaurant_dto.dart';

abstract class RestaurantEvent {}

class FetchRestaurantsRequested extends RestaurantEvent {}

class FetchRestaurantByIdRequested extends RestaurantEvent {
  final String id;

  FetchRestaurantByIdRequested(this.id);
}

class CreateRestaurantRequested extends RestaurantEvent {
  final CreateRestaurantDTO restaurant;

  CreateRestaurantRequested(this.restaurant);
}

class UpdateRestaurantRequested extends RestaurantEvent {
  final UpdateRestaurantDTO restaurant;

  UpdateRestaurantRequested(this.restaurant);
}

class DeleteRestaurantRequested extends RestaurantEvent {}

class RestaurantErrorOccurred extends RestaurantEvent {
  final String message;

  RestaurantErrorOccurred(this.message);
}

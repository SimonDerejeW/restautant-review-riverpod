import 'package:equatable/equatable.dart';
import 'package:restaurant_review/infrastructure/restaurant/restaurant_dto.dart';

abstract class RestaurantState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RestaurantInitial extends RestaurantState {}

class RestaurantLoading extends RestaurantState {}

class RestaurantLoaded extends RestaurantState {
  final List<RestaurantDTO> restaurants;

  RestaurantLoaded(this.restaurants);

  @override
  List<Object?> get props => [restaurants];
}

class RestaurantDetailLoaded extends RestaurantState {
  final RestaurantDTO restaurant;

  RestaurantDetailLoaded(this.restaurant);

  @override
  List<Object?> get props => [restaurant];
}

class RestaurantError extends RestaurantState {
  final String message;

  RestaurantError(this.message);

  @override
  List<Object?> get props => [message];
}

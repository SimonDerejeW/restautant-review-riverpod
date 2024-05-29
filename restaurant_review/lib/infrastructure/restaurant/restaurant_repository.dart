import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:restaurant_review/domain/restaurant/restaurant_failure.dart';
import 'package:restaurant_review/domain/restaurant/restaurant_repository_interface.dart';
import 'package:restaurant_review/infrastructure/restaurant/restaurant_dto.dart';
import 'package:restaurant_review/infrastructure/restaurant/restuarant_service.dart';

class RestaurantRepository implements RestaurantRepositoryInterface {
  final RestaurantService _restaurantService;

  RestaurantRepository(this._restaurantService);

  @override
  Future<Either<RestaurantFailure, List<RestaurantDTO>>>
      fetchAllRestaurants() async {
    try {
      final response = await _restaurantService.fetchAllRestaurants();
      if (response.statusCode == 200) {
        final List<dynamic> body = json.decode(response.body);
        final restaurants =
            body.map((json) => RestaurantDTO.fromJson(json)).toList();
        return right(restaurants);
      } else {
        return left(RestaurantFailure(response.body));
      }
    } catch (e) {
      return left(RestaurantFailure(e.toString()));
    }
  }

  @override
  Future<Either<RestaurantFailure, RestaurantDTO>> fetchRestaurantById(
      String id) async {
    try {
      final response = await _restaurantService.fetchRestaurantById(id);
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        final restaurant = RestaurantDTO.fromJson(body);
        return right(restaurant);
      } else {
        return left(RestaurantFailure(response.body));
      }
    } catch (e) {
      return left(RestaurantFailure(e.toString()));
    }
  }
}

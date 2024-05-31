import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:restaurant_review/domain/restaurant/restaurant_failure.dart';
import 'package:restaurant_review/domain/restaurant/restaurant_repository_interface.dart';
import 'package:restaurant_review/infrastructure/restaurant/create_restaurant_dto.dart';
import 'package:restaurant_review/infrastructure/restaurant/restaurant_dto.dart';
import 'package:restaurant_review/infrastructure/restaurant/restuarant_service.dart';
import 'package:restaurant_review/infrastructure/restaurant/update_restaurant_dto.dart';

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
        return left(RestaurantFailure(jsonDecode(response.body)['message']));
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
        return left(RestaurantFailure(jsonDecode(response.body)['message']));
      }
    } catch (e) {
      return left(RestaurantFailure(e.toString()));
    }
  }

  Future<Either<RestaurantFailure, bool>>
      checkOwnerRestaurantforCreation() async {
    try {
      final response = await _restaurantService.checkOwnerRestaurant();
      print(response.statusCode);
      if (response.statusCode == 200) {
        print("entered");
        final body = json.decode(response.body);
        print("ss ${body.isNotEmpty}");
        return right(body.isNotEmpty);
      } else {
        return left(RestaurantFailure(response.body));
      }
    } catch (e) {
      return left(RestaurantFailure(e.toString()));
    }
  }


  Future<Either<RestaurantFailure, CreateRestaurantDTO>> createRestaurant(
      CreateRestaurantDTO restaurant) async {
    final checkResponse = await checkOwnerRestaurantforCreation();
    return checkResponse.fold(
      (failure) => left(failure),
      (hasRestaurant) async {
        if (hasRestaurant) {
          return left(RestaurantFailure('Owner already has a restaurant'));
        } else {
          try {
            final response =
                await _restaurantService.createRestaurant(restaurant);
            if (response.statusCode == 201) {
              final body = json.decode(response.body);
              final createdRestaurant = CreateRestaurantDTO.fromJson(body);
              return right(createdRestaurant);
            } else {
              return left(RestaurantFailure(jsonDecode(response.body)['message']));
            }
          } catch (e) {
            return left(RestaurantFailure(e.toString()));
          }
        }
      },
    );
  }

  Future<Either<RestaurantFailure, Either<bool, String>>>
      checkOwnerRestaurantforUpdate() async {
    try {
      final response = await _restaurantService.checkOwnerRestaurant();
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        if (body.isEmpty) {
          return right(left(false));
        }
        // print("CORU ${body['_id']}");
        
        return right(right(body['_id']));
      } else {
        return left(RestaurantFailure(response.body));
      }
    } catch (e) {
      return left(RestaurantFailure(e.toString()));
    }
  }

  Future<Either<RestaurantFailure, UpdateRestaurantDTO>> updateRestaurant(
      UpdateRestaurantDTO restaurant) async {
    final checkResponse = await checkOwnerRestaurantforUpdate();
    
    return checkResponse.fold(
      (failure) => left(failure),
      (result) async {
        
        if (result.isLeft()) {
          final hasRestaurant = result.getOrElse(() => '');
          if (hasRestaurant.isEmpty) {
            return left(RestaurantFailure('Owner does not have a restaurant'));
          }
        } else {
          final restaurantID = result.getOrElse(() => '');
          
          try {
            final response = await _restaurantService.updateRestaurant(
                restaurantID, restaurant);
            if (response.statusCode == 200) {
              final body = json.decode(response.body);
              final updatedRestaurant = UpdateRestaurantDTO.fromJson(body);
              
              return right(updatedRestaurant);
            } else {
              return left(RestaurantFailure(jsonDecode(response.body)['message']));
            }
          } catch (e) {
            return left(RestaurantFailure(e.toString()));
          }
        }
        return left(RestaurantFailure('An unexpected error occurred'));
      },
    );
  }

  Future<Either<RestaurantFailure, Unit>> deleteRestaurant() async {
    final checkResponse = await checkOwnerRestaurantforUpdate();
    return checkResponse.fold(
      (failure) => left(failure),
      (result) async {
        if (result.isLeft()) {
          final hasRestaurant = result.getOrElse(() => '');
          if (hasRestaurant.isEmpty) {
            return left(RestaurantFailure('Owner does not have a restaurant'));
          }
        } else {
          final restaurantID = result.getOrElse(() => '');
          try {
            final response =
                await _restaurantService.deleteRestaurant(restaurantID);
            if (response.statusCode == 200) {
              return right(unit);
            } else {
              return left(RestaurantFailure(jsonDecode(response.body)['message']));
            }
          } catch (e) {
            return left(RestaurantFailure(e.toString()));
          }
        }
        return left(RestaurantFailure('An unexpected error occurred'));
      },
    );
  }
}

import 'package:dartz/dartz.dart';
import 'package:restaurant_review/infrastructure/data_transfer_objects/restaurant_dto.dart';
import '../../domain/failures/failure.dart';
import '../../domain/entities/restaurant.dart';
import '../data_sources/remote/restaurant_remote_data_source.dart';

class RestaurantRepository {
  final RestaurantRemoteDataSource remoteDataSource;

  RestaurantRepository(this.remoteDataSource);

  Future<Either<Failure, List<Restaurant>>> getAllRestaurants() async {
    try {
      final List<RestaurantDto> restaurantDtos =
          await remoteDataSource.getAllRestaurants();
      final restaurants = restaurantDtos.map((dto) => dto.toDomain()).toList();
      return Right(restaurants);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, Restaurant>> getRestaurantById(String id) async {
    try {
      final RestaurantDto restaurantDto =
          await remoteDataSource.getRestaurantById(id);
      final restaurant = restaurantDto.toDomain();
      return Right(restaurant);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, void>> createRestaurant(Restaurant restaurant) async {
    try {
      final restaurantDto = RestaurantDto(
        id: restaurant.id,
        name: restaurant.name,
        description: restaurant.description,
        location: restaurant.location,
        contact: restaurant.contact,
        openingTime: restaurant.openingTime,
        closingTime: restaurant.closingTime,
      );
      await remoteDataSource.createRestaurant(restaurantDto);

      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, void>> updateRestaurant(Restaurant restaurant) async {
    try {
      final restaurantDto = RestaurantDto(
        id: restaurant.id,
        name: restaurant.name,
        description: restaurant.description,
        location: restaurant.location,
        contact: restaurant.contact,
        openingTime: restaurant.openingTime,
        closingTime: restaurant.closingTime,
      );

      await remoteDataSource.updateRestaurant(restaurantDto);
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, void>> deleteRestaurant(String id) async {
    try {
      await remoteDataSource.deleteRestaurant(id);
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}

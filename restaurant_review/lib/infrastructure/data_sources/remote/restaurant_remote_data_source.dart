import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../data_transfer_objects/restaurant_dto.dart';

class RestaurantRemoteDataSource {
  static const baseUrl = 'http://localhost:3000/restaurant';

  Future<List<RestaurantDto>> getAllRestaurants() async {
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {'Authorization': 'Bearer YOUR_TOKEN'},
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((json) => RestaurantDto.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load restaurants');
    }
  }

  Future<RestaurantDto> getRestaurantById(String id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/$id'),
      headers: {'Authorization': 'Bearer YOUR_TOKEN'},
    );

    if (response.statusCode == 200) {
      return RestaurantDto.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load restaurant');
    }
  }

  Future<void> createRestaurant(RestaurantDto restaurant) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer YOUR_TOKEN'},
      body: jsonEncode(restaurant.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create restaurant');
    }
  }

  Future<void> updateRestaurant(RestaurantDto restaurant) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${restaurant.id}'),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer YOUR_TOKEN'},
      body: jsonEncode(restaurant.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update restaurant');
    }
  }

  Future<void> deleteRestaurant(String id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/$id'),
      headers: {'Authorization': 'Bearer YOUR_TOKEN'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete restaurant');
    }
  }
}

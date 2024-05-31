import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

import 'package:restaurant_review/core/url.dart';
import 'package:restaurant_review/infrastructure/restaurant/create_restaurant_dto.dart';
import 'package:restaurant_review/infrastructure/restaurant/restaurant_dto.dart';
import 'package:restaurant_review/infrastructure/restaurant/update_restaurant_dto.dart';
import '../../core/storage.dart';

class RestaurantService {
  final String baseUrl = Domain.url;
  final SecureStorage _secureStorage = SecureStorage.instance;

  // Method to fetch all restaurants
  Future<http.Response> fetchAllRestaurants() async {
    String? token = await _secureStorage.read('token');

    final url = Uri.parse('$baseUrl/restaurant');
    final headers = {
      'Content-Type': 'application/json',
      "authorization": "Bearer $token",
    };

    final response = await http.get(url, headers: headers);
    return response;
  }

  // Method to fetch a restaurant by ID
  Future<http.Response> fetchRestaurantById(String id) async {
    String? token = await _secureStorage.read('token');

    final url = Uri.parse('$baseUrl/restaurant/$id');
    final headers = {
      'Content-Type': 'application/json',
      "authorization": "Bearer $token"
    };

    final response = await http.get(url, headers: headers);
    return response;
  }

  // Method to check if owner has a restaurant
  Future<http.Response> checkOwnerRestaurant() async {
    String? token = await _secureStorage.read('token');
    if (token == null) {
      throw Exception('Token not found');
    }

    // Decode the token to get the user ID (sub)
    Map<String, dynamic> payload = JwtDecoder.decode(token);
    String ownerId = payload['sub'];
    final url = Uri.parse('$baseUrl/restaurant/owner/$ownerId');
    final headers = {
      'Content-Type': 'application/json',
      "authorization": "Bearer $token"
    };

    final response = await http.get(url, headers: headers);
    print("Check owner service response: ${response.body}");
    return response;
  }

  // Method to create a restaurant
  Future<http.Response> createRestaurant(CreateRestaurantDTO restaurant) async {
    String? token = await _secureStorage.read('token');

    final url = Uri.parse('$baseUrl/restaurant');
    final headers = {
      'Content-Type': 'application/json',
      "authorization": "Bearer $token"
    };

    final body = jsonEncode(restaurant.toJson());

    final response = await http.post(url, headers: headers, body: body);
    // print(response);
    return response;
  }

  Future<http.Response> updateRestaurant(
      String id, UpdateRestaurantDTO restaurant) async {
    String? token = await _secureStorage.read('token');

    final url = Uri.parse('$baseUrl/restaurant/$id');
    final headers = {
      'Content-Type': 'application/json',
      "authorization": "Bearer $token"
    };

    final body = jsonEncode(restaurant.toJson());

    final response = await http.patch(url, headers: headers, body: body);
    return response;
  }

  // Method to delete a restaurant
  Future<http.Response> deleteRestaurant(String id) async {
    String? token = await _secureStorage.read('token');

    // final responsefromCheck = await checkOwnerRestaurant();
    // if (responsefromCheck.statusCode == 200) {
    //   if (responsefromCheck.body.isEmpty) {
    //     throw Exception('User does not have a restaurant');
    //   }
    // }

    final url = Uri.parse('$baseUrl/restaurant/$id');
    final headers = {
      'Content-Type': 'application/json',
      "authorization": "Bearer $token"
    };

    final response = await http.delete(url, headers: headers);
    return response;
  }
}

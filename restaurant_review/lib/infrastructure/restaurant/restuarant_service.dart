import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:restaurant_review/core/url.dart';
import 'package:restaurant_review/infrastructure/restaurant/restaurant_dto.dart';
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
}

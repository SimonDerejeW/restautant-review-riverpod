import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'package:restaurant_review/core/storage.dart';
import 'package:restaurant_review/core/url.dart';

class UserService {
  final String baseUrl = Domain.url;
  //instantiate everytime you need the token
  final SecureStorage _secureStorage = SecureStorage.instance;

  // Method to fetch user details by ID
  Future<http.Response> getUserDetails() async {
    String? token = await _secureStorage.read('token');

    if (token == null) {
      throw Exception('Token not found');
    }

    // Decode the token to get the user ID (sub)
    Map<String, dynamic> payload = JwtDecoder.decode(token);
    String userId = payload['sub'];

    // Construct the request to fetch user details
    final url = Uri.parse('$baseUrl/users/$userId');
    final headers = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer $token"
    };

    // Make the request using HTTP GET
    final response = await http.get(url, headers: headers);

    // Parse and return the response data
    // print(response.body);
    return response;
  }

  // Method to change username
  Future<http.Response> changeUsername(String newUsername) async {
    String? token = await _secureStorage.read('token');
    if (token == null) {
      throw Exception('Token not found');
    }
    Map<String, dynamic> payload = JwtDecoder.decode(token);
    String userId = payload['sub'];

    final url = Uri.parse('$baseUrl/users/changeUserName/$userId');
    final headers = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer $token"
    };

    final body = json.encode({'new_username': newUsername});
    final response = await http.patch(url, headers: headers, body: body);
    return response;
  }

  // Method to change password
  Future<http.Response> changePassword(
      String oldPassword, String newPassword) async {
    String? token = await _secureStorage.read('token');

    if (token == null) {
      throw Exception('Token not found');
    }

    Map<String, dynamic> payload = JwtDecoder.decode(token);
    String userId = payload['sub'];

    final url = Uri.parse('$baseUrl/users/changePassword/$userId');
    final headers = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer $token"
    };

    final body =
        json.encode({'old_password': oldPassword, 'new_password': newPassword});
    final response = await http.patch(url, headers: headers, body: body);
    return response;
  }

  // Method to delete account
  Future<http.Response> deleteAccount() async {
    String? token = await _secureStorage.read('token');

    if (token == null) {
      throw Exception('Token not found');
    }

    Map<String, dynamic> payload = JwtDecoder.decode(token);
    String userId = payload['sub'];

    final url = Uri.parse('$baseUrl/users/$userId');
    final headers = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer $token"
    };

    final response = await http.delete(url, headers: headers);
    return response;
  }
}

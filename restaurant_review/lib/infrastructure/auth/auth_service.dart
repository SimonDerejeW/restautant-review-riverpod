import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:restaurant_review/core/url.dart';
import 'package:restaurant_review/infrastructure/auth/login_dto.dart';
import 'package:restaurant_review/infrastructure/auth/signup_dto.dart';

class AuthService {
  final String baseUrl = Domain.url;

  // Method to handle user login using LoginDTO
  Future<http.Response> login(LoginDTO loginDto) async {
    // Construct the login request
    final url = Uri.parse('$baseUrl/auth/login');
    final body = jsonEncode(
        {'username': loginDto.username, 'password': loginDto.password});
    final headers = {'Content-Type': 'application/json'};

    // Make the login request using HTTP POST
    final response = await http.post(url, headers: headers, body: body);

    // Parse and return the response data
    return response;
  }

  // Method to handle user signup using SignupDTO
  Future<http.Response> signUp(SignUpDTO signupDto) async {
    // Construct the signup request
    final url = Uri.parse('$baseUrl/auth/signup');
    final body = jsonEncode({
      'username': signupDto.username,
      'email': signupDto.email,
      'password': signupDto.password,
      'roles': signupDto.role
    });
    final headers = {'Content-Type': 'application/json'};

    // Make the signup request using HTTP POST
    final response = await http.post(url, headers: headers, body: body);

    // Parse and return the response data
    return response;
  }
}

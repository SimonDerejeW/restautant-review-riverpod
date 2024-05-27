import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../data_transfer_objects/auth_dto.dart';

class AuthRemoteDataSource {
  static const baseUrl = 'http://localhost:3000/auth';

  Future<AuthDto> signUp(
      String username, String email, String password, String role) async {
    final response = await http.post(
      Uri.parse('$baseUrl/signup'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'email': email,
        'password': password,
        'roles': role,
      }),
    );

    if (response.statusCode == 201) {
      print('signed');
      return AuthDto.fromJson(jsonDecode(response.body));
    } else {
      print('failed');
      throw Exception('Failed to sign up');
    }
  }

  Future<AuthDto> login(String username, String password) async {
    print(username);
    print(password);
    print(
        "sending request..........................................................................................");
    final url = Uri.parse('http://localhost:3000/auth/login');
    print(url);
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
          {
            "username": username,
            'password': password,
          },
        ));

    print(response.body);
    print('response status code');

    if (response.statusCode == 201) {
      print(AuthDto.fromJson(jsonDecode(response.body)));
      return AuthDto.fromJson(jsonDecode(response.body));
    } else {
      print(
          "request faild ..........................................................................................");
      throw Exception('Failed to log in');
    }
  }
}

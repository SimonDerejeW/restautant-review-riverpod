import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_review/domain/auth_failure.dart';
import 'package:restaurant_review/domain/auth_repository_interface.dart';
import 'package:restaurant_review/domain/user.dart';
import 'login_dto.dart';
import 'signup_dto.dart';
import 'auth_service.dart';

class AuthRepository implements AuthRepositoryInterface {
  final AuthService _authService;

  AuthRepository(this._authService);

  @override
  Future<Either<AuthFailure, User>> login(
      String username, String password) async {
    try {
      final response = await _authService
          .login(LoginDTO(username: username, password: password));
      if (response.statusCode == 201) {
        // Assuming the response body contains the user data and token
        //Change to accept token
        final userJson = jsonDecode(response.body);
        final user = User(
          token: userJson['access_token'],
          role: userJson['roles']
              [0], // Assuming roles is a list and we take the first role
        );
        return right(user);
      } else {
        return left(AuthFailure(response.body));
      }
    } catch (e) {
      return left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> logout() async {
    // Implement logout logic if any
    return right(unit);
  }

  @override
  Future<Either<AuthFailure, User>> signUp(
      String username, String email, String password, String role) async {
    try {
      final response = await _authService.signUp(SignUpDTO(
        username: username,
        email: email,
        password: password,
        role: role,
      ));
      if (response.statusCode == 201) {
        final userJson = jsonDecode(response.body);
        final newUser = User(
          token: userJson['access_token'],
          role: userJson['roles'][0],
        );
        return right(newUser);
      } else {
        return left(AuthFailure(response.body));
      }
    } catch (e) {
      return left(AuthFailure(e.toString()));
    }
  }
}

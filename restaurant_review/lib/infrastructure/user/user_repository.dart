import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:restaurant_review/domain/user/profile_user.dart';
import 'package:restaurant_review/domain/user/user_failure.dart';
import 'package:restaurant_review/domain/user/user_repository_interface.dart';
import 'package:restaurant_review/infrastructure/user/user_service.dart';
import '../../core/storage.dart';

class UserRepository implements UserRepositoryInterface {
  final UserService _userService;
  final SecureStorage _secureStorage = SecureStorage.instance;

  UserRepository(this._userService);

  @override
  Future<Either<UserFailure, Profile_User>> getUserDetails() async {
    try {
      final response = await _userService.getUserDetails();

      if (response.statusCode == 200) {
        final userJson = jsonDecode(response.body);

        final user = Profile_User(
          id: userJson['_id'],
          username: userJson['username'],
          email: userJson['email'],
          isOwner: userJson['roles'][0],
        );

        return right(user);
      } else {
        return left(UserFailure(response.body));
      }
    } catch (e) {
      return left(UserFailure(e.toString()));
    }
  }

  Future<Either<UserFailure, Unit>> changeUsername(String newUsername) async {
    try {
      final response = await _userService.changeUsername(newUsername);

      if (response.statusCode == 200) {
        return right(unit);
      } else {
        return left(UserFailure(response.body));
      }
    } catch (e) {
      return left(UserFailure(e.toString()));
    }
  }

  Future<Either<UserFailure, Unit>> changePassword(
      String oldPassword, String newPassword) async {
    try {
      final response =
          await _userService.changePassword(oldPassword, newPassword);

      if (response.statusCode == 200) {
        return right(unit);
      } else {
        return left(UserFailure(response.body));
      }
    } catch (e) {
      return left(UserFailure(e.toString()));
    }
  }

  Future<Either<UserFailure, Unit>> deleteAccount() async {
    try {
      final response = await _userService.deleteAccount();

      if (response.statusCode == 200) {
        return right(unit);
      } else {
        return left(UserFailure(response.body));
      }
    } catch (e) {
      return left(UserFailure(e.toString()));
    }
  }
}

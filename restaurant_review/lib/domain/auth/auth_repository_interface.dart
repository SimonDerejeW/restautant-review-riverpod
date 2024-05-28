import 'package:dartz/dartz.dart';
import 'auth_failure.dart';
import 'user.dart';

abstract class AuthRepositoryInterface {
  Future<Either<AuthFailure, User>> login(String username, String password);
  Future<Either<AuthFailure, Unit>> logout();
  Future<Either<AuthFailure, User>> signUp(
      String username, String email, String password, String role);
}

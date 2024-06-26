import 'package:dartz/dartz.dart';
import 'package:restaurant_review/domain/user/profile_user.dart';
import 'user_failure.dart';

abstract class UserRepositoryInterface {
  Future<Either<UserFailure, Profile_User>> getUserDetails();
  Future<Either<UserFailure, bool>> changeUsername(String newUsername);
  Future<Either<UserFailure, bool>> changePassword(
      String oldPassword, String newPassword);
  Future<Either<UserFailure, Unit>> deleteAccount();
}

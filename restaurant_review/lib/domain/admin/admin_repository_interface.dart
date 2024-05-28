import 'package:dartz/dartz.dart';
import 'package:restaurant_review/domain/auth/auth_failure.dart';
import 'package:restaurant_review/domain/admin/users_model.dart';

abstract class AdminRepositoryInterface {
  Future<Either<AuthFailure, Unit>> banUser(String username);
  Future<Either<AuthFailure, Unit>> unbanUser(String username);
  Future<Either<AuthFailure, List<CustomerModel>>> fetchAllCustomers();
  Future<Either<AuthFailure, List<OwnerModel>>> fetchAllOwners();
}

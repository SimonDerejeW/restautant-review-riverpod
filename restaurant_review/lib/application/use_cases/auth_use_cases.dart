import 'package:dartz/dartz.dart';
import '../../domain/failures/failure.dart';
import '../../domain/entities/auth.dart';
import '../../infrastructure/repositories/auth_repository.dart';

class AuthUseCases {
  final AuthRepository repository;

  AuthUseCases(this.repository);

  Future<Either<Failure, Auth>> signUpUser(
      String username, String email, String password, String userType) {
    return repository.signUp(username, email, password, userType);
  }

  Future<Either<Failure, Auth>> signUpOwner(
      String username, String email, String password, String userType) {
    return repository.signUp(username, email, password, userType);
  }

  Future<Either<Failure, Auth>> login(String username, String password) {
    return repository.login(username, password);
  }
}

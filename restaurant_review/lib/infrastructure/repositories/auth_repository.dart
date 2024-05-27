import 'package:dartz/dartz.dart';
import '../../domain/failures/failure.dart';
import '../../domain/entities/auth.dart';
import '../data_sources/remote/auth_remote_data_source.dart';

class AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepository(this.remoteDataSource);

  Future<Either<Failure, Auth>> signUp(
      String username, String email, String password, String role) async {
    try {
      final auth =
          await remoteDataSource.signUp(username, email, password, role);
      return Right(auth.toDomain());
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, Auth>> login(String username, String password) async {
    try {
      final auth = await remoteDataSource.login(username, password);
      print('remotelog');
      return Right(auth.toDomain());
    } catch (e) {
      print('repo error: $e');
      return Left(Failure(e.toString()));
    }
  }
}

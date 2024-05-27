// lib/presentation/providers/auth_providers.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../infrastructure/repositories/auth_repository.dart';
import '../../infrastructure/data_sources/remote/auth_remote_data_source.dart';
import '../../application/use_cases/auth_use_cases.dart';

// Provider for AuthRepository
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final authRemoteDataSource = AuthRemoteDataSource();
  return AuthRepository(authRemoteDataSource);
});

// Provider for AuthUseCases
final authUseCasesProvider = Provider<AuthUseCases>((ref) {
  final authRepository =
      ref.watch(authRepositoryProvider); // Get the AuthRepository instance
  return AuthUseCases(authRepository);
});

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_review/infrastructure/auth/auth_service.dart';
import 'package:restaurant_review/infrastructure/auth/auth_repository.dart';
import 'package:restaurant_review/application/auth/auth_notifier.dart';
import 'package:restaurant_review/application/auth/auth_state.dart';

// Define a provider for AuthService
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

// Define a provider for AuthRepository, which depends on AuthService
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final authService = ref.watch(authServiceProvider);
  return AuthRepository(authService);
});

// Define a StateNotifierProvider for AuthNotifier, which depends on AuthRepository
final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthNotifier(authRepository);
});

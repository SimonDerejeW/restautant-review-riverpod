import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_review/application/user/user_notifier.dart';
import 'package:restaurant_review/application/user/user_state.dart';
import 'package:restaurant_review/infrastructure/user/user_repository.dart';
import 'package:restaurant_review/infrastructure/user/user_service.dart';

// Define a provider for UserService
final userServiceProvider = Provider<UserService>((ref) {
  return UserService();
});

// Define a provider for UserRepository
final userRepositoryProvider = Provider<UserRepository>((ref) {
  final userService = ref.watch(userServiceProvider);
  return UserRepository(userService);
});

// Define a StateNotifierProvider for UserNotifier
final userNotifierProvider =
    StateNotifierProvider<UserNotifier, UserState>((ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  return UserNotifier(userRepository);
});

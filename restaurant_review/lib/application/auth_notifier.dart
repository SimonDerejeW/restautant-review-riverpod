import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_review/application/auth_event.dart';
import 'package:restaurant_review/application/auth_state.dart';
import 'package:restaurant_review/infrastructure/auth/auth_repository.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;

  AuthNotifier(this._authRepository) : super(AuthInitial());

  void handleEvent(AuthEvent event) async {
    if (event is AuthLoginRequested) {
      state = AuthLoading();
      final result =
          await _authRepository.login(event.username, event.password);
      print("result: $result");
      result.fold(
        (failure) => state = AuthError(failure.message),
        (user) => state =
            AuthAuthenticated(user.token), // Assuming user object has a token
      );
    } else if (event is AuthLogoutRequested) {
      state = AuthLoading();
      final result = await _authRepository.logout();
      result.fold(
        (failure) => state = AuthError(failure.message),
        (_) => state = AuthUnauthenticated(),
      );
    } else if (event is AuthSignUpRequested) {
      state = AuthLoading();
      final result = await _authRepository.signUp(
          event.username, event.email, event.password, event.role);
      result.fold(
        (failure) => state = AuthError(failure.message),
        (user) => state = AuthAuthenticated(user.token),
      );
    } else if (event is AuthCheckRequested) {
      // Handle authentication check if necessary
    } else if (event is AuthErrorOccurred) {
      state = AuthError(event.message);
    }
  }
}

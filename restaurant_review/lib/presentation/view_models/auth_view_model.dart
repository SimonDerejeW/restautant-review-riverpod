import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/use_cases/auth_use_cases.dart';
import '../../domain/entities/auth.dart';
import '../../domain/failures/failure.dart';
import '../providers/auth_providers.dart';

class AuthState {
  final Auth? user;
  final bool isLoading;
  final Failure? failure;
  final bool isAuthenticated;

  AuthState({this.user, this.isLoading = false, this.failure, this.isAuthenticated = false});

  AuthState copyWith({Auth? user, bool? isLoading, Failure? failure, bool? isAuthenticated}) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      failure: failure ?? this.failure,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthUseCases useCases;

  AuthNotifier(this.useCases) : super(AuthState());

  Future<void> signUpUser(
      String username, String email, String password, String userType) async {
    state = state.copyWith(isLoading: true);
    final result =
        await useCases.signUpUser(username, email, password, userType);
    result.fold(
      (failure) => state = state.copyWith(isLoading: false, failure: failure),
      (user) => state = state.copyWith(isLoading: false, user: user),
    );
  }

  Future<void> signUpOwner(
      String username, String email, String password, String userType) async {
    state = state.copyWith(isLoading: true);
    final result =
        await useCases.signUpOwner(username, email, password, userType);
    result.fold(
      (failure) => state = state.copyWith(isLoading: false, failure: failure),
      (user) => state = state.copyWith(isLoading: false, user: user),
    );
  }

  Future<void> login(String username, String password) async {
    state = state.copyWith(isLoading: true);
    final result = await useCases.login(username, password);
    print("resultss: $result");
    result.fold(
      (failure) => state = state.copyWith(isLoading: false, failure: failure),
      (user) => state = state.copyWith(isLoading: false, isAuthenticated: true),
    );
    print(result);
  }

  void logout() {
    state = AuthState();
  }
}

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authUseCases = ref.read(authUseCasesProvider);
  print('anp ${AuthNotifier(authUseCases)}');
  return AuthNotifier(authUseCases);
});







/// -------------- Correct the code with this implementation ---------------------//
/// // auth_notifier.dart
// class AuthState {
//   final Auth? user;
//   final bool isLoading;
//   final Failure? failure;
//   final bool authenticated;

//   AuthState({this.user, this.isLoading = false, this.failure, this.authenticated = false});

//   AuthState copyWith({Auth? user, bool? isLoading, Failure? failure, bool? authenticated}) {
//     return AuthState(
//       user: user ?? this.user,
//       isLoading: isLoading ?? this.isLoading,
//       failure: failure ?? this.failure,
//       authenticated: authenticated ?? this.authenticated,
//     );
//   }
// }

// class AuthNotifier extends StateNotifier<AuthState> {
//   final AuthUseCases useCases;

//   AuthNotifier(this.useCases) : super(AuthState());

//   Future<void> signUpUser(String username, String email, String password, String userType) async {
//     state = state.copyWith(isLoading: true);
//     final result = await useCases.signUpUser(username, email, password, userType);
//     result.fold(
//       (failure) => _onSignUpFailure(failure),
//       (user) => _onSignUpSuccess(user),
//     );
//   }

//   Future<void> signUpOwner(String username, String email, String password, String userType) async {
//     state = state.copyWith(isLoading: true);
//     final result = await useCases.signUpOwner(username, email, password, userType);
//     result.fold(
//       (failure) => _onSignUpFailure(failure),
//       (user) => _onSignUpSuccess(user),
//     );
//   }

//   Future<void> login(String username, String password) async {
//     state = state.copyWith(isLoading: true);
//     final result = await useCases.login(username, password);
//     result.fold(
//       (failure) => _onLoginFailure(failure),
//       (user) => _onLoginSuccess(user),
//     );
//   }

//   void _onLoginFailure(Failure failure) {
//     state = state.copyWith(isLoading: false, failure: failure, authenticated: false);
//   }

//   void _onLoginSuccess(Auth user) {
//     state = state.copyWith(isLoading: false, user: user, authenticated: true);
//   }

//   void logout() {
//     state = AuthState();
//   }
// }

// final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
//   final authUseCases = ref.read(authUseCasesProvider);
//   return AuthNotifier(authUseCases);
// });

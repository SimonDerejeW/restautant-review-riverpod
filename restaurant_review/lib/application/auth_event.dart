abstract class AuthEvent {}

class AuthLoginRequested extends AuthEvent {
  final String username;
  final String password;

  AuthLoginRequested(this.username, this.password);
}

class AuthLogoutRequested extends AuthEvent {}

class AuthSignUpRequested extends AuthEvent {
  final String username;
  final String email;
  final String password;
  final String role;

  AuthSignUpRequested(this.username, this.email, this.password, this.role);
}

class AuthCheckRequested extends AuthEvent {}

class AuthErrorOccurred extends AuthEvent {
  final String message;

  AuthErrorOccurred(this.message);
}

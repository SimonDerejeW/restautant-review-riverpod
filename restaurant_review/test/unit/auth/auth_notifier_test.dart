import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_review/application/auth/auth_event.dart';
import 'package:restaurant_review/application/auth/auth_notifier.dart';
import 'package:restaurant_review/application/auth/auth_state.dart';
import 'package:restaurant_review/domain/auth/auth_failure.dart';
import 'package:restaurant_review/domain/auth/user.dart';
import 'package:restaurant_review/infrastructure/auth/auth_repository.dart';
import 'package:mockito/annotations.dart';
import 'auth_notifier_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  group('AuthNotifier', () {
    late MockAuthRepository mockAuthRepository;
    late AuthNotifier authNotifier;

    setUp(() {
      mockAuthRepository = MockAuthRepository();
      authNotifier = AuthNotifier(mockAuthRepository);
    });

    test('should handle successful login', () async {
      // Arrange
      const username = 'testuser';
      const password = 'testpassword';
      final user = User(role: 'user', token: 'token');
      when(mockAuthRepository.login(username, password))
          .thenAnswer((_) async => right(user));

      // Act
      authNotifier.handleEvent(AuthLoginRequested(username, password));
      await untilCalled(mockAuthRepository.login(username, password));

      // Assert
      expect(authNotifier.state, isA<AuthAuthenticated>());
      expect((authNotifier.state as AuthAuthenticated).user, user);
      verify(mockAuthRepository.login(username, password)).called(1);
    });

    test('should handle failed login', () async {
      // Arrange
      const username = 'testuser';
      const password = 'testpassword';
      final failure = AuthFailure('Login Failed');
      when(mockAuthRepository.login(username, password))
          .thenAnswer((_) async => left(failure));

      // Act
      authNotifier.handleEvent(AuthLoginRequested(username, password));
      await untilCalled(mockAuthRepository.login(username, password));

      // Assert
      expect(authNotifier.state, isA<AuthError>());
      expect((authNotifier.state as AuthError).message, 'Login Failed');
      verify(mockAuthRepository.login(username, password)).called(1);
    });

    test('should handle successful logout', () async {
      // Arrange
      when(mockAuthRepository.logout()).thenAnswer((_) async => right(unit));

      // Act
      authNotifier.handleEvent(AuthLogoutRequested());
      await untilCalled(mockAuthRepository.logout());

      // Assert
      expect(authNotifier.state, isA<AuthUnauthenticated>());
      verify(mockAuthRepository.logout()).called(1);
    });

    test('should handle successful sign-up', () async {
      // Arrange
      const username = 'testuser';
      const email = 'test@example.com';
      const password = 'testpassword';
      const role = 'user';
      final user = User(role: 'user', token: 'token');
      when(mockAuthRepository.signUp(username, email, password, role))
          .thenAnswer((_) async => right(user));

      // Act
      authNotifier
          .handleEvent(AuthSignUpRequested(username, email, password, role));
      await untilCalled(
          mockAuthRepository.signUp(username, email, password, role));

      // Assert
      expect(authNotifier.state, isA<AuthAuthenticated>());
      expect((authNotifier.state as AuthAuthenticated).user, user);
      verify(mockAuthRepository.signUp(username, email, password, role))
          .called(1);
    });

    test('should handle failed sign-up', () async {
      // Arrange
      const username = 'testuser';
      const email = 'test@example.com';
      const password = 'testpassword';
      const role = 'user';
      final failure = AuthFailure('Sign Up Failed');
      when(mockAuthRepository.signUp(username, email, password, role))
          .thenAnswer((_) async => left(failure));

      // Act
      authNotifier
          .handleEvent(AuthSignUpRequested(username, email, password, role));
      await untilCalled(
          mockAuthRepository.signUp(username, email, password, role));

      // Assert
      expect(authNotifier.state, isA<AuthError>());
      expect((authNotifier.state as AuthError).message, 'Sign Up Failed');
      verify(mockAuthRepository.signUp(username, email, password, role))
          .called(1);
    });
  });
}

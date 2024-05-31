import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_review/domain/auth/auth_failure.dart';
import 'package:restaurant_review/domain/auth/user.dart';
import 'package:restaurant_review/infrastructure/auth/auth_repository.dart';
import 'package:restaurant_review/infrastructure/auth/auth_service.dart';
import 'package:restaurant_review/infrastructure/auth/login_dto.dart';
import 'package:restaurant_review/infrastructure/auth/signup_dto.dart';
import 'package:mockito/annotations.dart';
import 'auth_repository_test.mocks.dart';

@GenerateMocks([AuthService])
void main() {
  group('AuthRepository', () {
    late AuthRepository authRepository;
    late MockAuthService mockAuthService;

    setUp(() {
      mockAuthService = MockAuthService();
      authRepository = AuthRepository(mockAuthService);
    });

    test('login - should return user on successful login', () async {
      // Arrange
      const username = 'testuser';
      const password = 'testpassword';
      final loginDto = LoginDTO(username: username, password: password);
      final userJson = jsonEncode({
        'roles': ['user'],
        'access_token': 'token'
      });
      when(mockAuthService.login(loginDto)).thenAnswer(
        (_) async => http.Response(userJson, 201),
      );

      // Act
      final result = await authRepository.login(username, password);

      // Assert
      expect(result, isA<Either<AuthFailure, User>>());
      result.fold(
        (failure) => expect(failure, isA<AuthFailure>()),
        (user) {
          expect(user.role, 'user');
          expect(user.token, 'token');
        },
      );
      // verify(mockAuthService.login(loginDto)).called(1);
    });

    test('login - should return AuthFailure on failed login', () async {
      // Arrange
      const username = 'testuser';
      const password = 'testpassword';
      final loginDto = LoginDTO(username: username, password: password);

      when(mockAuthService.login(loginDto)).thenAnswer(
        (_) async => http.Response('Error', 400),
      );

      // Act
      final result = await authRepository.login(username, password);

      // Assert
      expect(result, isA<Either<AuthFailure, User>>());
      result.fold(
        (failure) => expect(failure, isA<AuthFailure>()),
        (user) => fail('Should fail'),
      );
      print("passed this part");
      // verify(mockAuthService.login(loginDto)).called(1);
    });

    test('logout - should return unit on successful logout', () async {
      // Act
      final result = await authRepository.logout();

      // Assert
      expect(result, right(unit));
    });

    test('signUp - should return user on successful signup', () async {
      // Arrange
      const username = 'testuser';
      const email = 'test@example.com';
      const password = 'testpassword';
      const role = 'user';
      final signUpDto = SignUpDTO(
        username: username,
        email: email,
        password: password,
        role: role,
      );
      final userJson = jsonEncode({
        'roles': ['user'],
        'access_token': 'token',
      });
      when(mockAuthService.signUp(signUpDto)).thenAnswer(
        (_) async => http.Response(userJson, 201),
      );

      // Act
      final result =
          await authRepository.signUp(username, email, password, role);

      // Assert
      expect(result, isA<Either<AuthFailure, User>>());
      result.fold(
        (failure) => expect(failure, isA<AuthFailure>()),
        (user) {
          expect(user.role, 'user');
          expect(user.token, 'token');
        },
      );
      // verify(mockAuthService.signUp(signUpDto)).called(1);
    });

    test('signUp - should return AuthFailure on failed signup', () async {
      // Arrange
      const username = 'testuser';
      const email = 'test@example.com';
      const password = 'testpassword';
      const role = 'user';
      final signUpDto = SignUpDTO(
        username: username,
        email: email,
        password: password,
        role: role,
      );

      when(mockAuthService.signUp(signUpDto)).thenAnswer(
        (_) async => http.Response('Error', 400),
      );

      // Act
      final result =
          await authRepository.signUp(username, email, password, role);

      // Assert
      expect(result, isA<Either<AuthFailure, User>>());
      result.fold(
        (failure) => expect(failure, isA<AuthFailure>()),
        (user) => fail('Should fail'),
      );
      // verify(mockAuthService.signUp(signUpDto)).called(1);
    });
  });
}

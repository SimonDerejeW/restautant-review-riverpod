import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_review/domain/admin/users_model.dart';
import 'package:restaurant_review/infrastructure/admin/admin_repository.dart';
import 'package:restaurant_review/infrastructure/admin/admin_service.dart';
import 'package:dartz/dartz.dart';
import 'package:restaurant_review/domain/auth/auth_failure.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([AdminService])
import 'admin_repository_test.mocks.dart';

void main() {
  group('AdminRepository', () {
    late AdminRepository adminRepository;
    late MockAdminService mockAdminService;

    setUp(() {
      mockAdminService = MockAdminService();
      adminRepository = AdminRepository(mockAdminService);
    });

    test('should return unit when banUser is successful', () async {
      // Arrange
      const username = 'testuser';
      when(mockAdminService.banUser(username)).thenAnswer(
        (_) async => http.Response('', 200),
      );

      // Act
      final result = await adminRepository.banUser(username);

      // Assert
      expect(result, right(unit));
      verify(mockAdminService.banUser(username)).called(1);
    });

    test('should return AuthFailure when banUser fails', () async {
      // Arrange
      const username = 'testuser';
      when(mockAdminService.banUser(username)).thenAnswer(
        (_) async => http.Response('Error', 400),
      );

      // Act
      final result = await adminRepository.banUser(username);

      // Assert
      expect(result, left(AuthFailure('Error')));
      verify(mockAdminService.banUser(username)).called(1);
    });

    test('should return unit when unbanUser is successful', () async {
      // Arrange
      const username = 'testuser';
      when(mockAdminService.unbanUser(username)).thenAnswer(
        (_) async => http.Response('', 200),
      );

      // Act
      final result = await adminRepository.unbanUser(username);

      // Assert
      expect(result, right(unit));
      verify(mockAdminService.unbanUser(username)).called(1);
    });

    test('should return AuthFailure when unbanUser fails', () async {
      // Arrange
      const username = 'testuser';
      when(mockAdminService.unbanUser(username)).thenAnswer(
        (_) async => http.Response('Error', 400),
      );

      // Act
      final result = await adminRepository.unbanUser(username);

      // Assert
      expect(result, left(AuthFailure('Error')));
      verify(mockAdminService.unbanUser(username)).called(1);
    });

    test('should return list of customers when fetchAllCustomers is successful',
        () async {
      // Arrange
      final customersJson = jsonEncode([
        {"username": "user1", "isBanned": false},
        {"username": "user2", "isBanned": true}
      ]);
      final List<CustomerModel> expectedCustomers = jsonDecode(customersJson)
          .map<CustomerModel>((json) => CustomerModel.fromJson(json))
          .toList();

      when(mockAdminService.getAllCustomers()).thenAnswer(
        (_) async => http.Response(customersJson, 200),
      );

      // Act
      final result = await adminRepository.fetchAllCustomers();
      // print(result);
      // print(right(expectedCustomers));
      // // print(equals(expectedCustomers));
      // print(result == expectedCustomers);

      // Assert
      expect(result, isA<Either<AuthFailure, List<CustomerModel>>>());

      final Either<AuthFailure, List<CustomerModel>> either = result;
      either.fold(
        (failure) => fail('Should not be a failure'),
        (customers) {
          // Check if the returned list of customers matches the expected customers
          // print(customers);
          // print(expectedCustomers);
          expect(customers, equals(expectedCustomers));
        },
      );
      verify(mockAdminService.getAllCustomers()).called(1);
    });

    test('should return AuthFailure when fetchAllCustomers fails', () async {
      // Arrange
      when(mockAdminService.getAllCustomers()).thenAnswer(
        (_) async => http.Response('Error', 400),
      );

      // Act
      final result = await adminRepository.fetchAllCustomers();

      // Assert
      expect(result, left(AuthFailure('Error')));

      verify(mockAdminService.getAllCustomers()).called(1);
    });

    test('should return list of owners when fetchAllOwners is successful',
        () async {
      // Arrange
      final ownersJson = jsonEncode([
        {'username': 'owner1', 'isBanned': false},
        {'username': 'owner2', 'isBanned': true},
      ]);

      final List<OwnerModel> expectedOwners = jsonDecode(ownersJson)
          .map<OwnerModel>((json) => OwnerModel.fromJson(json))
          .toList();
      when(mockAdminService.getAllOwners()).thenAnswer(
        (_) async => http.Response(ownersJson, 200),
      );

      // Act
      final result = await adminRepository.fetchAllOwners();

      // Assert
      expect(result, isA<Either<AuthFailure, List<OwnerModel>>>());
      final Either<AuthFailure, List<OwnerModel>> either = result;
      either.fold(
        (failure) => fail('Should not be a failure'),
        (owners) {
          // Check if the returned list of owners matches the expected owners
          
          expect(owners, equals(expectedOwners));
        },
      );
      verify(mockAdminService.getAllOwners()).called(1);
    });

    test('should return AuthFailure when fetchAllOwners fails', () async {
      // Arrange
      when(mockAdminService.getAllOwners()).thenAnswer(
        (_) async => http.Response('Error', 400),
      );

      // Act
      final result = await adminRepository.fetchAllOwners();

      // Assert
      expect(result, left(AuthFailure('Error')));
      verify(mockAdminService.getAllOwners()).called(1);
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_review/application/admin/admin_notifier.dart';
import 'package:restaurant_review/application/admin/admin_state.dart';
import 'package:restaurant_review/domain/admin/users_model.dart';
import 'package:restaurant_review/domain/admin/admin_repository_interface.dart';
import 'package:dartz/dartz.dart';
import 'package:restaurant_review/domain/auth/auth_failure.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([AdminRepositoryInterface])
import 'admin_notifier_test.mocks.dart';

void main() {
  group('AdminNotifier', () {
    late AdminNotifier adminNotifier;
    late MockAdminRepositoryInterface mockAdminRepository;

    setUp(() {
      mockAdminRepository = MockAdminRepositoryInterface();
      adminNotifier = AdminNotifier(mockAdminRepository);
    });

    test('initial state is correct', () {
      expect(adminNotifier.state, AdminState.initial());
    });

    test('fetchUsers updates state correctly on success', () async {
      // Arrange
      final customers = [const CustomerModel(name: 'user1', isBanned: false)];
      final owners = [const OwnerModel(name: 'owner1', isBanned: false)];

      when(mockAdminRepository.fetchAllCustomers())
          .thenAnswer((_) async => right(customers));
      when(mockAdminRepository.fetchAllOwners())
          .thenAnswer((_) async => right(owners));

      // Act
      await adminNotifier.fetchUsers();

      // Assert
      expect(adminNotifier.state.customers, customers);
      expect(adminNotifier.state.owners, owners);
      expect(adminNotifier.state.isLoading, false);
      expect(adminNotifier.state.errorMessage, isNull);
      verify(mockAdminRepository.fetchAllCustomers()).called(1);
      verify(mockAdminRepository.fetchAllOwners()).called(1);
    });

    test('fetchUsers updates state correctly on failure', () async {
      // Arrange
      final failure = AuthFailure('Error');
      when(mockAdminRepository.fetchAllCustomers())
          .thenAnswer((_) async => left(failure));
      when(mockAdminRepository.fetchAllOwners())
          .thenAnswer((_) async => left(failure));

      // Act
      await adminNotifier.fetchUsers();

      // Assert
      expect(adminNotifier.state.isLoading, false);
      expect(adminNotifier.state.errorMessage, 'Error');
      verify(mockAdminRepository.fetchAllCustomers()).called(1);
      verify(mockAdminRepository.fetchAllOwners()).called(1);
    });

    test('toggleBanCustomer bans and unbans customer correctly', () async {
      // Arrange
      const username = 'testuser';
      final customers = [const CustomerModel(name: username, isBanned: false)];
      final owners = [const OwnerModel(name: 'owner1', isBanned: false)];

      when(mockAdminRepository.banUser(username))
          .thenAnswer((_) async => right(unit));
      when(mockAdminRepository.unbanUser(username))
          .thenAnswer((_) async => right(unit));
      when(mockAdminRepository.fetchAllCustomers())
          .thenAnswer((_) async => right(customers));
      when(mockAdminRepository.fetchAllOwners())
          .thenAnswer((_) async => right(owners));

      // Act
      await adminNotifier.toggleBanCustomer(username, true);
      await untilCalled(mockAdminRepository.fetchAllOwners());

      // // Assert
      verify(mockAdminRepository.banUser(username)).called(1);
      verify(mockAdminRepository.fetchAllCustomers()).called(1);
      verify(mockAdminRepository.fetchAllOwners()).called(1);

      // // Act
      await adminNotifier.toggleBanCustomer(username, false);
      await untilCalled(mockAdminRepository.fetchAllOwners());

      // // Assert
      verify(mockAdminRepository.unbanUser(username)).called(1);
      verify(mockAdminRepository.fetchAllCustomers()).called(1);
      verify(mockAdminRepository.fetchAllOwners()).called(1);
    });

    test('toggleBanOwner bans and unbans owner correctly', () async {
      // Arrange
      const username = 'testowner';
      final owners = [const OwnerModel(name: username, isBanned: false)];
      final customers = [const CustomerModel(name: 'user2', isBanned: false)];

      // Add logging to ensure stubbing is applied
      print('Setting up stubs');
      when(mockAdminRepository.banUser(username)).thenAnswer((_) async {
        print('banUser stub called');
        return right(unit);
      });
      when(mockAdminRepository.unbanUser(username)).thenAnswer((_) async {
        print('unbanUser stub called');
        return right(unit);
      });
      when(mockAdminRepository.fetchAllOwners()).thenAnswer((_) async {
        print('fetchAllOwners stub called');
        return right(owners);
      });
      when(mockAdminRepository.fetchAllCustomers()).thenAnswer((_) async {
        print('fetchAllCustomers stub called');
        return right(customers);
      });
      print('Stubs are set up');

      // Act - Ban the owner
      print('Calling toggleBanOwner to ban');
      await adminNotifier.toggleBanOwner(username, true);
      await untilCalled(mockAdminRepository.fetchAllOwners());

      // Assert the sequence of method calls
      print('Verifying calls after ban');
      verify(mockAdminRepository.banUser(username)).called(1);
      print('verifying fetchAllCustomers calls');
      verify(mockAdminRepository.fetchAllCustomers()).called(1);
      print('verifying fetchAllOwners calls');
      verify(mockAdminRepository.fetchAllOwners()).called(1);

      // Act - Unban the owner
      print('Calling toggleBanOwner to unban');
      await adminNotifier.toggleBanOwner(username, false);
      await untilCalled(mockAdminRepository.fetchAllOwners());

      // Assert the sequence of method calls for unbanning
      print('Verifying calls after unban');
      verify(mockAdminRepository.unbanUser(username)).called(1);
      verify(mockAdminRepository.fetchAllOwners())
          .called(1); // Called twice in total
      verify(mockAdminRepository.fetchAllCustomers())
          .called(1); // Called twice in total
    });

    test('fetchUsers updates state correctly on success', () async {
      // Arrange
      final owners = [const OwnerModel(name: 'owner1', isBanned: false)];
      final customers = [
        const CustomerModel(name: 'customer1', isBanned: false)
      ];

      when(mockAdminRepository.fetchAllOwners())
          .thenAnswer((_) async => right(owners));
      when(mockAdminRepository.fetchAllCustomers())
          .thenAnswer((_) async => right(customers));

      // Act
      await adminNotifier.fetchUsers();

      // Assert
      expect(adminNotifier.state.owners, owners);
      expect(adminNotifier.state.customers, customers);
      expect(adminNotifier.state.isLoading, false);
      expect(adminNotifier.state.errorMessage, isNull);

      verify(mockAdminRepository.fetchAllOwners()).called(1);
      verify(mockAdminRepository.fetchAllCustomers()).called(1);
    });

    test('fetchUsers updates state correctly on failure', () async {
      // Arrange
      final failure = AuthFailure('Failed to fetch users');

      when(mockAdminRepository.fetchAllOwners())
          .thenAnswer((_) async => left(failure));
      when(mockAdminRepository.fetchAllCustomers())
          .thenAnswer((_) async => right([]));

      // Act
      await adminNotifier.fetchUsers();

      // Assert
      expect(adminNotifier.state.owners, isEmpty);
      expect(adminNotifier.state.customers, isEmpty);
      expect(adminNotifier.state.isLoading, false);
      expect(adminNotifier.state.errorMessage, failure.message);

      verify(mockAdminRepository.fetchAllOwners()).called(1);
      verify(mockAdminRepository.fetchAllCustomers()).called(1);
    });

    test('toggleBanCustomer bans and unbans customer correctly', () async {
      // Arrange
      const username = 'testcustomer';
      final customers = [const CustomerModel(name: username, isBanned: false)];
      final owners = [const OwnerModel(name: 'owner1', isBanned: false)];

      when(mockAdminRepository.banUser(username))
          .thenAnswer((_) async => right(unit));
      when(mockAdminRepository.unbanUser(username))
          .thenAnswer((_) async => right(unit));
      when(mockAdminRepository.fetchAllCustomers())
          .thenAnswer((_) async => right(customers));
      when(mockAdminRepository.fetchAllOwners())
          .thenAnswer((_) async => right(owners));

      // Act - Ban the customer
      await adminNotifier.toggleBanCustomer(username, true);

      // Await to ensure all asynchronous calls complete
      await untilCalled(mockAdminRepository.fetchAllOwners());

      // Assert the sequence of method calls
      verify(mockAdminRepository.banUser(username)).called(1);
      verify(mockAdminRepository.fetchAllCustomers()).called(1);
      verify(mockAdminRepository.fetchAllOwners()).called(1);

      // Act - Unban the customer
      await adminNotifier.toggleBanCustomer(username, false);

      // Await to ensure all asynchronous calls complete
      await untilCalled(mockAdminRepository.fetchAllOwners());

      // Assert the sequence of method calls for unbanning
      verify(mockAdminRepository.unbanUser(username)).called(1);
      verify(mockAdminRepository.fetchAllCustomers())
          .called(1); // Called twice in total
      verify(mockAdminRepository.fetchAllOwners())
          .called(1); // Called twice in total
    });

    test('toggleBanCustomer handles errors correctly', () async {
      // Arrange
      const username = 'testcustomer';
      final failure = AuthFailure('Failed to ban user');

      when(mockAdminRepository.banUser(username))
          .thenAnswer((_) async => left(failure));
      when(mockAdminRepository.unbanUser(username))
          .thenAnswer((_) async => left(failure));
      when(mockAdminRepository.fetchAllCustomers())
          .thenAnswer((_) async => right([]));
      when(mockAdminRepository.fetchAllOwners())
          .thenAnswer((_) async => right([]));

      // Act - Attempt to ban the customer
      await adminNotifier.toggleBanCustomer(username, true);

      // Assert error handling
      expect(adminNotifier.state.errorMessage, failure.message);

      verify(mockAdminRepository.banUser(username)).called(1);
      verifyNever(mockAdminRepository.fetchAllCustomers());

      // Act - Attempt to unban the customer
      await adminNotifier.toggleBanCustomer(username, false);

      // Assert error handling
      expect(adminNotifier.state.errorMessage, failure.message);

      verify(mockAdminRepository.unbanUser(username)).called(1);
      verifyNever(mockAdminRepository.fetchAllCustomers());
    });
  });
}

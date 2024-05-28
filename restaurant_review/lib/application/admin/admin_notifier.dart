// notifier.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_review/application/admin/admin_event.dart';
import 'package:restaurant_review/application/admin/admin_state.dart';
import 'package:restaurant_review/domain/admin/admin_repository_interface.dart';

class AdminNotifier extends StateNotifier<AdminState> {
  final AdminRepositoryInterface _adminRepository;

  AdminNotifier(this._adminRepository) : super(AdminState.initial());

  void handleEvent(AdminEvent event, {String? username, bool? isBanned}) {
    print(event);
    switch (event) {
      case AdminEvent.fetchUsers:
        fetchUsers();
        break;
      case AdminEvent.toggleBanCustomer:
        if (username != null && isBanned != null) {
          toggleBanCustomer(username, isBanned);
        }
        break;
      case AdminEvent.toggleBanOwner:
        if (username != null && isBanned != null) {
          toggleBanOwner(username, isBanned);
        }
        break;
    }
  }

  Future<void> fetchUsers() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    final customersResult = await _adminRepository.fetchAllCustomers();
    final ownersResult = await _adminRepository.fetchAllOwners();

    customersResult.fold(
      (failure) => state =
          state.copyWith(isLoading: false, errorMessage: failure.message),
      (customers) => state = state.copyWith(customers: customers),
    );

    ownersResult.fold(
      (failure) => state =
          state.copyWith(isLoading: false, errorMessage: failure.message),
      (owners) => state = state.copyWith(owners: owners, isLoading: false),
    );
  }

  Future<void> toggleBanCustomer(String username, bool isBanned) async {
    print(isBanned);
    final result = isBanned
        ? await _adminRepository.banUser(username)
        : await _adminRepository.unbanUser(username);

    result.fold(
      (failure) => state = state.copyWith(errorMessage: failure.message),
      (_) => fetchUsers(),
    );
  }

  Future<void> toggleBanOwner(String username, bool isBanned) async {
    print(isBanned);
    final result = isBanned
        ? await _adminRepository.banUser(username)
        : await _adminRepository.unbanUser(username);

    result.fold(
      (failure) => state = state.copyWith(errorMessage: failure.message),
      (_) => fetchUsers(),
    );
  }
}

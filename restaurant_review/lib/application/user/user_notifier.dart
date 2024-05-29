import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dartz/dartz.dart';
import 'package:restaurant_review/domain/auth/user.dart';
import 'package:restaurant_review/domain/auth/auth_failure.dart';
import 'package:restaurant_review/domain/auth/auth_repository_interface.dart';
import 'package:restaurant_review/domain/user/user_repository_interface.dart';

import 'user_event.dart';
import 'user_state.dart';

class UserNotifier extends StateNotifier<UserState> {
  final UserRepositoryInterface _userRepository;

  UserNotifier(this._userRepository) : super(UserInitial());

  Future<void> mapEventToState(UserEvent event) async {
    if (event is FetchUserRequested) {
      await _fetchUser();
    } else if (event is ChangeUsernameRequested) {
      await _changeUsername(event.newUsername);
    } else if (event is ChangePasswordRequested) {
      await _changePassword(event.oldPassword, event.newPassword);
    } else if (event is DeleteAccountRequested) {
      await _deleteAccount();
    }
  }

  Future<void> _fetchUser() async {
    state = UserLoading();
    final userOrFailure = await _userRepository.getUserDetails();
    userOrFailure.fold(
      (failure) => state = UserError(failure.message),
      (user) => state = UserLoaded(user),
    );
  }

  Future<void> _changeUsername(String newUsername) async {
    final result = await _userRepository.changeUsername(newUsername);
    result.fold(
      (failure) => state = UserError(failure.message),
      (success) => state = UserLoaded(
          (state as UserLoaded).user.copyWith(username: newUsername)),
    );
  }

  Future<void> _changePassword(String oldPassword, String newPassword) async {
    final result =
        await _userRepository.changePassword(oldPassword, newPassword);
    result.fold(
      (failure) => state = UserError(failure.message),
      (success) => state = UserLoaded((state as UserLoaded).user),
    );
  }

  Future<void> _deleteAccount() async {
    final result = await _userRepository.deleteAccount();
    result.fold(
      (failure) => state = UserError(failure.message),
      (success) => state = UserInitial(),
    );
  }
}

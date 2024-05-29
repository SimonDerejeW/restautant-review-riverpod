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
}

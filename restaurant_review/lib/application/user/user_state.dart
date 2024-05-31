import 'package:equatable/equatable.dart';
import 'package:restaurant_review/domain/auth/user.dart';
import 'package:restaurant_review/domain/user/profile_user.dart';

abstract class UserState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final Profile_User user;

  UserLoaded(this.user);

  @override
  List<Object?> get props => [user];
}

class UserError extends UserState {
  final String message;

  UserError(this.message);

  @override
  List<Object?> get props => [message];
}

class PasswordChangeSuccess extends UserState {
  final bool success;
  PasswordChangeSuccess(this.success);
}

class UsernameChangeSuccess extends UserState {
  final bool success;
  UsernameChangeSuccess(this.success);
}
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String role;
  final String token;

  User({required this.role, required this.token});

  @override
  List<Object?> get props => [role, token];
}

import 'package:equatable/equatable.dart';

class CustomerModel extends Equatable {
  final String name;
  final bool isBanned;

  const CustomerModel({
    required this.name,
    required this.isBanned,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      name: json['username'],
      isBanned: json['isBanned'],
    );
  }

 
  @override
  List<Object?> get props => [name, isBanned];
}

class OwnerModel extends Equatable {
  final String name;
  final bool isBanned;

  const OwnerModel({
    required this.name,
    required this.isBanned,
  });

  factory OwnerModel.fromJson(Map<String, dynamic> json) {
    return OwnerModel(
      name: json['username'],
      isBanned: json['isBanned'],
    );
  }

  @override
  List<Object?> get props => [name, isBanned];
}

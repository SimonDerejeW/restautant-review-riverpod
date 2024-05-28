import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:restaurant_review/domain/auth/auth_failure.dart';
import 'package:restaurant_review/domain/admin/admin_repository_interface.dart';
import 'package:restaurant_review/domain/admin/users_model.dart';
import 'admin_service.dart';

class AdminRepository implements AdminRepositoryInterface {
  final AdminService _adminService;

  AdminRepository(this._adminService);

  @override
  Future<Either<AuthFailure, Unit>> banUser(String username) async {
    try {
      final response = await _adminService.banUser(username);
      if (response.statusCode == 200) {
        return right(unit);
      } else {
        return left(AuthFailure(response.body));
      }
    } catch (e) {
      return left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> unbanUser(String username) async {
    try {
      final response = await _adminService.unbanUser(username);
      if (response.statusCode == 200) {
        return right(unit);
      } else {
        return left(AuthFailure(response.body));
      }
    } catch (e) {
      return left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<AuthFailure, List<CustomerModel>>> fetchAllCustomers() async {
    try {
      final response = await _adminService.getAllCustomers();
      if (response.statusCode == 200) {
        final List<dynamic> customersJson = jsonDecode(response.body);
        final customers =
            customersJson.map((json) => CustomerModel.fromJson(json)).toList();
        return right(customers);
      } else {
        return left(AuthFailure(response.body));
      }
    } catch (e) {
      return left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<AuthFailure, List<OwnerModel>>> fetchAllOwners() async {
    try {
      final response = await _adminService.getAllOwners();
      if (response.statusCode == 200) {
        final List<dynamic> customersJson = jsonDecode(response.body);
        final owners =
            customersJson.map((json) => OwnerModel.fromJson(json)).toList();
        return right(owners);
      } else {
        return left(AuthFailure(response.body));
      }
    } catch (e) {
      return left(AuthFailure(e.toString()));
    }
  }
}

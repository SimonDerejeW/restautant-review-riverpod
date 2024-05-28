import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_review/application/admin/admin_notifier.dart';
import 'package:restaurant_review/application/admin/admin_state.dart';
import 'package:restaurant_review/domain/admin/admin_repository_interface.dart';
import 'package:restaurant_review/infrastructure/admin/admin_repository.dart';
import 'package:restaurant_review/infrastructure/admin/admin_service.dart';

final adminRepositoryProvider = Provider<AdminRepositoryInterface>((ref) {
  return AdminRepository(AdminService());
});

final adminNotifierProvider = StateNotifierProvider<AdminNotifier, AdminState>(
  (ref) => AdminNotifier(ref.watch(adminRepositoryProvider)),
);

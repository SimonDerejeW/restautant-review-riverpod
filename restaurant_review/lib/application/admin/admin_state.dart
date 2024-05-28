import 'package:restaurant_review/domain/admin/users_model.dart';

class AdminState {
  final List<CustomerModel> customers;
  final List<OwnerModel> owners;
  final bool isLoading;
  final String? errorMessage;

  AdminState({
    required this.customers,
    required this.owners,
    required this.isLoading,
    this.errorMessage,
  });

  factory AdminState.initial() => AdminState(
        customers: [],
        owners: [],
        isLoading: false,
        errorMessage: null,
      );

  AdminState copyWith({
    List<CustomerModel>? customers,
    List<OwnerModel>? owners,
    bool? isLoading,
    String? errorMessage,
  }) {
    return AdminState(
      customers: customers ?? this.customers,
      owners: owners ?? this.owners,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

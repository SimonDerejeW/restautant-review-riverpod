import 'package:equatable/equatable.dart';
import 'package:restaurant_review/domain/admin/users_model.dart';

class AdminState extends Equatable {
  final List<CustomerModel> customers;
  final List<OwnerModel> owners;
  final bool isLoading;
  final String? errorMessage;

  const AdminState({
    required this.customers,
    required this.owners,
    required this.isLoading,
    this.errorMessage,
  });

  factory AdminState.initial() => const AdminState(
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

  @override
  List<Object?> get props => [customers, owners, isLoading, errorMessage];
}

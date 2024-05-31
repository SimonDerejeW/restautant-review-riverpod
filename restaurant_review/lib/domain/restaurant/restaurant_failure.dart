import 'package:equatable/equatable.dart';

class RestaurantFailure extends Equatable {
  final String message;

  const RestaurantFailure(this.message);

  @override
  List<Object> get props => [message];
}

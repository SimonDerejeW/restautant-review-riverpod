abstract class RestaurantEvent {}

class FetchRestaurantsRequested extends RestaurantEvent {}

class FetchRestaurantByIdRequested extends RestaurantEvent {
  final String id;

  FetchRestaurantByIdRequested(this.id);
}

class RestaurantErrorOccurred extends RestaurantEvent {
  final String message;

  RestaurantErrorOccurred(this.message);
}

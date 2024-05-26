
class RestaurantModel {
  String imagePath;
  String restaurantName;
  String status;
  List<String> chipsList;

  RestaurantModel({
    required this.imagePath,
    required this.restaurantName,
    required this.status,
    required this.chipsList
  });
}
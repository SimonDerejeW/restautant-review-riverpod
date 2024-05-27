class RestaurantModel {
  String id; // Add this field
  String imagePath;
  String restaurantName;
  String status;
  List<String> chipsList;

  RestaurantModel({
    required this.id, // Add this field
    required this.imagePath,
    required this.restaurantName,
    required this.status,
    required this.chipsList,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      id: json['_id'], // Add this field
      imagePath: 'assets/burger.jpg',
      restaurantName: json['name'] ?? 'Unknown Restaurant',
      status: 'Open', // Default value
      chipsList: ['General'], // Default value
    );
  }
}

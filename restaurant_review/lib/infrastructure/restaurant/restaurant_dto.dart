class RestaurantDTO {
  final String id;
  final String name;
  final String description;
  final String location;
  final String contact;
  final String openingTime;
  final String closingTime;
  final bool isBanned;
  final List<dynamic> comments;

  RestaurantDTO({
    required this.id,
    required this.name,
    required this.description,
    required this.location,
    required this.contact,
    required this.openingTime,
    required this.closingTime,
    required this.isBanned,
    required this.comments,
  });

  factory RestaurantDTO.fromJson(Map<String, dynamic> json) {
    return RestaurantDTO(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      location: json['location'],
      contact: json['contact'],
      openingTime: json['openingTime'],
      closingTime: json['closingTime'],
      isBanned: json['isBanned'],
      comments: json['comments']

    );
  }
}

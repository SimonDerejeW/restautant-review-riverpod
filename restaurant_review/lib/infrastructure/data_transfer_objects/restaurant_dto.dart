import '../../domain/entities/restaurant.dart';

class RestaurantDto {
  final String id;
  final String name;
  final String description;
  final String location;
  final String contact;
  final String openingTime;
  final String closingTime;

  RestaurantDto({
    required this.id,
    required this.name,
    required this.description,
    required this.location,
    required this.contact,
    required this.openingTime,
    required this.closingTime,
  });

  factory RestaurantDto.fromJson(Map<String, dynamic> json) {
    return RestaurantDto(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      location: json['location'],
      contact: json['contact'],
      openingTime: json['openingTime'],
      closingTime: json['closingTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'description': description,
      'location': location,
      'contact': contact,
      'openingTime': openingTime,
      'closingTime': closingTime,
    };
  }

  Restaurant toDomain() {
    return Restaurant(
      id: id,
      name: name,
      description: description,
      location: location,
      contact: contact,
      openingTime: openingTime,
      closingTime: closingTime,
    );
  }
}

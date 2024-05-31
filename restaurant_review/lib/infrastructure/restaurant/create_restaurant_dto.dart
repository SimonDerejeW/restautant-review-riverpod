import 'package:restaurant_review/infrastructure/comment/comment_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_restaurant_dto.g.dart';

@JsonSerializable()
class CreateRestaurantDTO {
  final String name;
  final String description;
  final String location;
  final String contact;
  final String openingTime;
  final String closingTime;

  CreateRestaurantDTO({
    required this.name,
    required this.description,
    required this.location,
    required this.contact,
    required this.openingTime,
    required this.closingTime,
  });

  factory CreateRestaurantDTO.fromJson(Map<String, dynamic> json) =>
      _$CreateRestaurantDTOFromJson(json);
  Map<String, dynamic> toJson() => _$CreateRestaurantDTOToJson(this);
}

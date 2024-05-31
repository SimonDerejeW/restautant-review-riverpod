// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_restaurant_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateRestaurantDTO _$CreateRestaurantDTOFromJson(Map<String, dynamic> json) =>
    CreateRestaurantDTO(
      name: json['name'] as String,
      description: json['description'] as String,
      location: json['location'] as String,
      contact: json['contact'] as String,
      openingTime: json['openingTime'] as String,
      closingTime: json['closingTime'] as String,
    );

Map<String, dynamic> _$CreateRestaurantDTOToJson(
        CreateRestaurantDTO instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'location': instance.location,
      'contact': instance.contact,
      'openingTime': instance.openingTime,
      'closingTime': instance.closingTime,
    };

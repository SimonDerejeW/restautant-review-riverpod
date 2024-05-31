class UpdateRestaurantDTO {
  final String? name;
  final String? description;
  final String? location;
  final String? contact;
  final String? openingTime;
  final String? closingTime;

  UpdateRestaurantDTO({
    this.name,
    this.description,
    this.location,
    this.contact,
    this.openingTime,
    this.closingTime,
  });

  factory UpdateRestaurantDTO.fromJson(Map<String, dynamic> json) {
    return UpdateRestaurantDTO(
      name: json['name'] as String?,
      description: json['description'] as String?,
      location: json['location'] as String?,
      contact: json['contact'] as String?,
      openingTime: json['openingTime'] as String?,
      closingTime: json['closingTime'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (location != null) 'location': location,
      if (contact != null) 'contact': contact,
      if (openingTime != null) 'openingTime': openingTime,
      if (closingTime != null) 'closingTime': closingTime,
    };
  }
}

class CustomerModel {
  String name;
  bool isBanned;

  CustomerModel({
    required this.name,
    required this.isBanned,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      name: json['username'],
      isBanned: json['isBanned'],
    );
  }
}

class OwnerModel {
  String name;
  bool isBanned;

  OwnerModel({
    required this.name,
    required this.isBanned,
  });

  factory OwnerModel.fromJson(Map<String, dynamic> json) {
    return OwnerModel(
      name: json['username'],
      isBanned: json['isBanned'],
    );
  }
}

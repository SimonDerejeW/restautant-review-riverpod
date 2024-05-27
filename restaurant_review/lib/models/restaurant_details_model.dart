class CommentModel {
  final String id;
  final String opinion;
  final String userId;

  CommentModel({
    required this.id,
    required this.opinion,
    required this.userId,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['_id'],
      opinion: json['opinion'],
      userId: json['userId'],
    );
  }
}

class RestaurantDetailModel {
  final String id;
  final String name;
  final String location;
  final String openingTime;
  final String closingTime;
  final List<CommentModel> comments;

  RestaurantDetailModel({
    required this.id,
    required this.name,
    required this.location,
    required this.openingTime,
    required this.closingTime,
    required this.comments,
  });

  factory RestaurantDetailModel.fromJson(Map<String, dynamic> json) {
    var commentsJson = json['comments'] as List;
    List<CommentModel> commentList = commentsJson
        .map((commentJson) => CommentModel.fromJson(commentJson))
        .toList();

    return RestaurantDetailModel(
      id: json['_id'],
      name: json['name'],
      location: json['location'],
      openingTime: json['openingTime'],
      closingTime: json['closingTime'],
      comments: commentList,
    );
  }
}

import '../../domain/entities/comment.dart';

class CommentDto {
  final String id;
  final String restaurantId;
  final String opinion;

  CommentDto({
    required this.id,
    required this.restaurantId,
    required this.opinion,
  });

  factory CommentDto.fromJson(Map<String, dynamic> json) {
    return CommentDto(
      id: json['_id'],
      restaurantId: json['restaurantId'],
      opinion: json['opinion'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'restaurantId': restaurantId,
      'opinion': opinion,
    };
  }

  Comment toDomain() {
    return Comment(
      id: id,
      restaurantId: restaurantId,
      opinion: opinion,
    );
  }
}

class Comment {
  final String id; // Unique identifier for the comment
  final String restaurantId; // ID of the restaurant the comment belongs to
  final String opinion; // The comment text

  Comment({
    required this.id,
    required this.restaurantId,
    required this.opinion,
  });

  // Factory method to create a Comment object from JSON data
  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['_id'],
      restaurantId: json['restaurantId'],
      opinion: json['opinion'],
    );
  }

  // Method to convert Comment object to JSON data
  Map<String, dynamic> toJson() {
    return {
      'restaurantId': restaurantId,
      'opinion': opinion,
    };
  }
}

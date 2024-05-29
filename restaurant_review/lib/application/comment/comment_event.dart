abstract class CommentEvent {}

class CreateComment extends CommentEvent {
  final String restaurantId;
  final String opinion;

  CreateComment(this.restaurantId, this.opinion);
}

class UpdateComment extends CommentEvent {
  final String commentId;
  final String newOpinion;
  final String restaurantId;

  UpdateComment(this.commentId, this.newOpinion, this.restaurantId);
}

class DeleteComment extends CommentEvent {
  final String commentId;
  final String restaurantId;

  DeleteComment(this.commentId, this.restaurantId);
}

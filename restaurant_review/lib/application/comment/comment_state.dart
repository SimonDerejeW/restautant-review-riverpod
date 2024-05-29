abstract class CommentState {}

class CommentInitial extends CommentState {}

class CommentLoading extends CommentState {}

class CommentLoaded extends CommentState {}

class CommentError extends CommentState {
  final String message;

  CommentError(this.message);
}

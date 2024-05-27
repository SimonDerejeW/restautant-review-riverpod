import 'package:dartz/dartz.dart';
import '../../domain/failures/failure.dart';
import '../../domain/entities/comment.dart';
import '../../infrastructure/repositories/comment_repository.dart';

class CommentUseCases {
  final CommentRepository repository;

  CommentUseCases(this.repository);

  Future<Either<Failure, List<Comment>>> getAllComments() {
    return repository.getAllComments();
  }

  Future<Either<Failure, Comment>> getCommentById(String id) {
    return repository.getCommentById(id);
  }

  Future<Either<Failure, void>> createComment(Comment comment) {
    return repository.createComment(comment);
  }

  Future<Either<Failure, void>> updateComment(Comment comment) {
    return repository.updateComment(comment);
  }

  Future<Either<Failure, void>> deleteComment(String id) {
    return repository.deleteComment(id);
  }
}

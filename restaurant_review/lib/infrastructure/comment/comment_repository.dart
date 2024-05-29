import 'package:dartz/dartz.dart';
import 'package:restaurant_review/domain/auth/auth_failure.dart';
import 'package:restaurant_review/domain/comment/comment_repository_interface.dart';
import 'package:restaurant_review/infrastructure/comment/comment_service.dart';

class CommentRepository implements CommentRepositoryInterface {
  final CommentService _commentService;

  CommentRepository(this._commentService);

  @override
  Future<Either<AuthFailure, Unit>> createComment(
      String restaurantId, String opinion) async {
    try {
      final response =
          await _commentService.createComment(restaurantId, opinion);

      // Handle response based on status code
      if (response.statusCode == 200 || response.statusCode == 201) {
        return right(unit);
      } else {
        return left(AuthFailure(response.body));
      }
    } catch (e) {
      return left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> updateComment(
      String commentId, String newOpinion) async {
    try {
      final response =
          await _commentService.updateComment(commentId, newOpinion);

      // Handle response based on status code
      print(response);
      if (response.statusCode == 200 || response.statusCode == 204) {
        return right(unit);
      } else {
        return left(AuthFailure(response.body));
      }
    } catch (e) {
      return left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> deleteComment(String commentId) async {
    try {
      final response = await _commentService.deleteComment(commentId);

      // Handle response based on status code
      if (response.statusCode == 200 || response.statusCode == 204) {
        return right(unit);
      } else {
        return left(AuthFailure(response.body));
      }
    } catch (e) {
      return left(AuthFailure(e.toString()));
    }
  }
}

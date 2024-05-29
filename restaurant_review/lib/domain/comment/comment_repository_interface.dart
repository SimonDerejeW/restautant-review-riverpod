import 'package:dartz/dartz.dart';
import 'package:restaurant_review/domain/auth/auth_failure.dart';

abstract class CommentRepositoryInterface {
  Future<Either<AuthFailure, Unit>> createComment(
      String restaurantId, String opinion);
  Future<Either<AuthFailure, Unit>> updateComment(
      String commentId, String newOpinion);
  Future<Either<AuthFailure, Unit>> deleteComment(String commentId);
}

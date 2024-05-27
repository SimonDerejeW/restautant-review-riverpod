import 'package:dartz/dartz.dart';
import 'package:restaurant_review/infrastructure/data_transfer_objects/comment_dto.dart';
import '../../domain/failures/failure.dart';
import '../../domain/entities/comment.dart';
import '../data_sources/remote/comment_remote_data_source.dart';

class CommentRepository {
  final CommentRemoteDataSource remoteDataSource;

  CommentRepository(this.remoteDataSource);

  Future<Either<Failure, List<Comment>>> getAllComments() async {
    try {
      final List<CommentDto> commentDtos =
          await remoteDataSource.getAllComments();
      final comments = commentDtos.map((dto) => dto.toDomain()).toList();

      return Right(comments);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, Comment>> getCommentById(String id) async {
    try {
      final CommentDto commentDto = await remoteDataSource.getCommentById(id);
      return Right(commentDto.toDomain());
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, void>> createComment(Comment comment) async {
    try {
      final commentDto = CommentDto(
        id: comment.id,
        restaurantId: comment.restaurantId,
        opinion: comment.opinion,
      );
      await remoteDataSource.createComment(commentDto);

      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, void>> updateComment(Comment comment) async {
    try {
      final commentDto = CommentDto(
        id: comment.id,
        restaurantId: comment.restaurantId,
        opinion: comment.opinion,
      );
      await remoteDataSource.updateComment(commentDto);

      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, void>> deleteComment(String id) async {
    try {
      await remoteDataSource.deleteComment(id);
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}

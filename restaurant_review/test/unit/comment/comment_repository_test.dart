import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_review/domain/auth/auth_failure.dart';
import 'package:restaurant_review/infrastructure/comment/comment_repository.dart';
import 'package:restaurant_review/infrastructure/comment/comment_service.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'comment_repository_test.mocks.dart';

@GenerateMocks([CommentService])
void main() {
  group('CommentRepository', () {
    late CommentRepository commentRepository;
    late MockCommentService mockCommentService;

    setUp(() {
      mockCommentService = MockCommentService();
      commentRepository = CommentRepository(mockCommentService);
    });

    test('createComment - should return unit on successful creation', () async {
      // Arrange
      const restaurantId = 'testRestaurantId';
      const opinion = 'Great food!';
      when(mockCommentService.createComment(restaurantId, opinion)).thenAnswer(
        (_) async => http.Response('', 201),
      );

      // Act
      final result =
          await commentRepository.createComment(restaurantId, opinion);

      // Assert
      expect(result, right(unit));
      verify(mockCommentService.createComment(restaurantId, opinion)).called(1);
    });

    test('createComment - should return AuthFailure on failed creation',
        () async {
      // Arrange
      const restaurantId = 'testRestaurantId';
      const opinion = 'Great food!';
      when(mockCommentService.createComment(restaurantId, opinion)).thenAnswer(
        (_) async => http.Response('Error', 400),
      );

      // Act
      final result =
          await commentRepository.createComment(restaurantId, opinion);

      // Assert
      expect(result.isLeft(), true);
      result.fold(
        (failure) => expect(failure, isA<AuthFailure>()),
        (_) => fail('Should fail'),
      );
      verify(mockCommentService.createComment(restaurantId, opinion)).called(1);
    });

    test('updateComment - should return unit on successful update', () async {
      // Arrange
      const commentId = 'testCommentId';
      const newOpinion = 'Updated opinion!';
      when(mockCommentService.updateComment(commentId, newOpinion)).thenAnswer(
        (_) async => http.Response('', 200),
      );

      // Act
      final result =
          await commentRepository.updateComment(commentId, newOpinion);

      // Assert
      expect(result, right(unit));
      verify(mockCommentService.updateComment(commentId, newOpinion)).called(1);
    });

    test('updateComment - should return AuthFailure on failed update',
        () async {
      // Arrange
      const commentId = 'testCommentId';
      const newOpinion = 'Updated opinion!';
      when(mockCommentService.updateComment(commentId, newOpinion)).thenAnswer(
        (_) async => http.Response('Error', 400),
      );

      // Act
      final result =
          await commentRepository.updateComment(commentId, newOpinion);

      // Assert
      expect(result.isLeft(), true);
      result.fold(
        (failure) => expect(failure, isA<AuthFailure>()),
        (_) => fail('Should fail'),
      );
      verify(mockCommentService.updateComment(commentId, newOpinion)).called(1);
    });

    test('deleteComment - should return unit on successful deletion', () async {
      // Arrange
      const commentId = 'testCommentId';
      when(mockCommentService.deleteComment(commentId)).thenAnswer(
        (_) async => http.Response('', 200),
      );

      // Act
      final result = await commentRepository.deleteComment(commentId);

      // Assert
      expect(result, right(unit));
      verify(mockCommentService.deleteComment(commentId)).called(1);
    });

    test('deleteComment - should return AuthFailure on failed deletion',
        () async {
      // Arrange
      const commentId = 'testCommentId';
      when(mockCommentService.deleteComment(commentId)).thenAnswer(
        (_) async => http.Response('Error', 400),
      );

      // Act
      final result = await commentRepository.deleteComment(commentId);

      // Assert
      expect(result.isLeft(), true);
      result.fold(
        (failure) => expect(failure, isA<AuthFailure>()),
        (_) => fail('Should fail'),
      );
      verify(mockCommentService.deleteComment(commentId)).called(1);
    });
  });
}

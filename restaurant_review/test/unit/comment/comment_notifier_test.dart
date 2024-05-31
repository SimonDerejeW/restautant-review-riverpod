import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_review/application/comment/comment_event.dart';
import 'package:restaurant_review/application/comment/comment_state.dart';
import 'package:restaurant_review/infrastructure/comment/comment_repository.dart';
import 'package:restaurant_review/application/comment/comment_notifier.dart';
import 'package:dartz/dartz.dart';
import 'package:restaurant_review/domain/auth/auth_failure.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'comment_notifier_test.mocks.dart';

@GenerateMocks([CommentRepository, Ref])
void main() {
  group('CommentNotifier', () {
    late CommentNotifier commentNotifier;
    late MockCommentRepository mockCommentRepository;
    late MockRef mockRef;

    setUp(() {
      mockCommentRepository = MockCommentRepository();
      mockRef = MockRef();
      commentNotifier = CommentNotifier(mockCommentRepository, mockRef);
    });

    test('initial state should be CommentInitial', () {
      expect(commentNotifier.state, isA<CommentInitial>());
    });

    test(
        'CreateComment - should emit [CommentLoading, CommentLoaded] on success',
        () async {
      // Arrange
      const restaurantId = 'testRestaurantId';
      const opinion = 'Great food!';
      when(mockCommentRepository.createComment(restaurantId, opinion))
          .thenAnswer(
        (_) async => right(unit),
      );

      // Act
      await commentNotifier
          .mapEventToState(CreateComment(restaurantId, opinion));

      // Assert
      expect(commentNotifier.state, isA<CommentLoaded>());
      verify(mockCommentRepository.createComment(restaurantId, opinion))
          .called(1);
    });

    test(
        'CreateComment - should emit [CommentLoading, CommentError] on failure',
        () async {
      // Arrange
      const restaurantId = 'testRestaurantId';
      const opinion = 'Great food!';
      when(mockCommentRepository.createComment(restaurantId, opinion))
          .thenAnswer(
        (_) async => left(AuthFailure('Error')),
      );

      // Act
      await commentNotifier
          .mapEventToState(CreateComment(restaurantId, opinion));

      // Assert
      expect(commentNotifier.state, isA<CommentError>());
      verify(mockCommentRepository.createComment(restaurantId, opinion))
          .called(1);
    });

    test(
        'UpdateComment - should emit [CommentLoading, CommentLoaded] on success',
        () async {
      // Arrange
      const commentId = 'testCommentId';
      const newOpinion = 'Updated opinion!';
      const restaurantId = 'testRestaurantId';
      when(mockCommentRepository.updateComment(commentId, newOpinion))
          .thenAnswer(
        (_) async => right(unit),
      );

      // Act
      await commentNotifier
          .mapEventToState(UpdateComment(commentId, newOpinion, restaurantId));

      // Assert
      expect(commentNotifier.state, isA<CommentLoaded>());
      verify(mockCommentRepository.updateComment(commentId, newOpinion))
          .called(1);
    });

    test(
        'UpdateComment - should emit [CommentLoading, CommentError] on failure',
        () async {
      // Arrange
      const commentId = 'testCommentId';
      const newOpinion = 'Updated opinion!';
      const restaurantId = 'testRestaurantId';
      when(mockCommentRepository.updateComment(commentId, newOpinion))
          .thenAnswer(
        (_) async => left(AuthFailure('Error')),
      );

      // Act
      await commentNotifier
          .mapEventToState(UpdateComment(commentId, newOpinion, restaurantId));

      // Assert
      expect(commentNotifier.state, isA<CommentError>());
      verify(mockCommentRepository.updateComment(commentId, newOpinion))
          .called(1);
    });

    test(
        'DeleteComment - should emit [CommentLoading, CommentLoaded] on success',
        () async {
      // Arrange
      const commentId = 'testCommentId';
      const restaurantId = 'testRestaurantId';
      when(mockCommentRepository.deleteComment(commentId)).thenAnswer(
        (_) async => right(unit),
      );

      // Act
      await commentNotifier
          .mapEventToState(DeleteComment(commentId, restaurantId));

      // Assert
      expect(commentNotifier.state, isA<CommentLoaded>());
      verify(mockCommentRepository.deleteComment(commentId)).called(1);
    });

    test(
        'DeleteComment - should emit [CommentLoading, CommentError] on failure',
        () async {
      // Arrange
      const commentId = 'testCommentId';
      const restaurantId = 'testRestaurantId';
      when(mockCommentRepository.deleteComment(commentId)).thenAnswer(
        (_) async => left(AuthFailure('Error')),
      );

      // Act
      await commentNotifier
          .mapEventToState(DeleteComment(commentId, restaurantId));

      // Assert
      expect(commentNotifier.state, isA<CommentError>());
      verify(mockCommentRepository.deleteComment(commentId)).called(1);
    });
  });
}

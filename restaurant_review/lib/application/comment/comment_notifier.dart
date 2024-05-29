import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_review/application/comment/comment_event.dart';
import 'package:restaurant_review/application/comment/comment_providers.dart';
import 'package:restaurant_review/application/comment/comment_state.dart';
import 'package:restaurant_review/application/retaurant/restaurant_event.dart';
import 'package:restaurant_review/application/retaurant/restaurant_provider.dart';
import 'package:restaurant_review/infrastructure/comment/comment_repository.dart';

final commentNotifierProvider =
    StateNotifierProvider<CommentNotifier, CommentState>((ref) {
  return CommentNotifier(ref.watch(commentRepositoryProvider), ref);
});

class CommentNotifier extends StateNotifier<CommentState> {
  final CommentRepository _commentRepository;
  final Ref _ref;

  CommentNotifier(this._commentRepository, this._ref) : super(CommentInitial());

  Future<void> mapEventToState(CommentEvent event) async {
    state = CommentLoading();
    try {
      if (event is CreateComment) {
        final result = await _commentRepository.createComment(
            event.restaurantId, event.opinion);

        print(result);
        result.fold(
          (failure) => state = CommentError(failure.toString()),
          (_) => state = CommentLoaded(),
        );
      } else if (event is UpdateComment) {
        final result = await _commentRepository.updateComment(
            event.commentId, event.newOpinion);
        result.fold(
          (failure) => state = CommentError(failure.toString()),
          (_) => state = CommentLoaded(),
        );
      } else if (event is DeleteComment) {
        final result = await _commentRepository.deleteComment(event.commentId);
        result.fold(
          (failure) => state = CommentError(failure.toString()),
          (_) => state = CommentLoaded(),
        );
      }
    } catch (e) {
      state = CommentError(e.toString());
    }
  }
}

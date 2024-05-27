import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/use_cases/comment_use_cases.dart';
import '../../domain/entities/comment.dart';
import '../../domain/failures/failure.dart';
import '../providers/comment_providers.dart';

class CommentState {
  final List<Comment> comments;
  final Comment? selectedComment;
  final bool isLoading;
  final Failure? failure;

  CommentState(
      {this.comments = const [],
      this.selectedComment,
      this.isLoading = false,
      this.failure});

  CommentState copyWith(
      {List<Comment>? comments,
      Comment? selectedComment,
      bool? isLoading,
      Failure? failure}) {
    return CommentState(
      comments: comments ?? this.comments,
      selectedComment: selectedComment ?? this.selectedComment,
      isLoading: isLoading ?? this.isLoading,
      failure: failure ?? this.failure,
    );
  }
}

class CommentNotifier extends StateNotifier<CommentState> {
  final CommentUseCases useCases;

  CommentNotifier(this.useCases) : super(CommentState());

  Future<void> getAllComments() async {
    state = state.copyWith(isLoading: true);
    final result = await useCases.getAllComments();
    result.fold(
      (failure) => state = state.copyWith(isLoading: false, failure: failure),
      (comments) =>
          state = state.copyWith(isLoading: false, comments: comments),
    );
  }

  Future<void> getCommentById(String id) async {
    state = state.copyWith(isLoading: true);
    final result = await useCases.getCommentById(id);
    result.fold(
      (failure) => state = state.copyWith(isLoading: false, failure: failure),
      (comment) =>
          state = state.copyWith(isLoading: false, selectedComment: comment),
    );
  }

  Future<void> createComment(Comment comment) async {
    state = state.copyWith(isLoading: true);
    final result = await useCases.createComment(comment);
    result.fold(
      (failure) => state = state.copyWith(isLoading: false, failure: failure),
      (_) => getAllComments(),
    );
  }

  Future<void> updateComment(Comment comment) async {
    state = state.copyWith(isLoading: true);
    final result = await useCases.updateComment(comment);
    result.fold(
      (failure) => state = state.copyWith(isLoading: false, failure: failure),
      (_) => getAllComments(),
    );
  }

  Future<void> deleteComment(String id) async {
    state = state.copyWith(isLoading: true);
    final result = await useCases.deleteComment(id);
    result.fold(
      (failure) => state = state.copyWith(isLoading: false, failure: failure),
      (_) => getAllComments(),
    );
  }
}

final commentNotifierProvider =
    StateNotifierProvider<CommentNotifier, CommentState>((ref) {
  final commentUseCases = ref.read(commentUseCasesProvider);
  return CommentNotifier(commentUseCases);
});

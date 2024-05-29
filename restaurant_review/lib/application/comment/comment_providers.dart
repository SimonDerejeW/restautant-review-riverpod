import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_review/infrastructure/comment/comment_repository.dart';
import 'package:restaurant_review/infrastructure/comment/comment_service.dart';

final commentRepositoryProvider = Provider<CommentRepository>((ref) {
  return CommentRepository(CommentService());
});

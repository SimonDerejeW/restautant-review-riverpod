import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/use_cases/comment_use_cases.dart';
import '../../infrastructure/repositories/comment_repository.dart';
import '../../infrastructure/data_sources/remote/comment_remote_data_source.dart';

// Provider for CommentRepository
final commentRepositoryProvider = Provider<CommentRepository>((ref) {
  final commentRemoteDataSource = CommentRemoteDataSource();
  return CommentRepository(commentRemoteDataSource);
});

// Provider for CommentUseCases
final commentUseCasesProvider = Provider<CommentUseCases>((ref) {
  final commentRepository = ref.watch(commentRepositoryProvider);
  return CommentUseCases(commentRepository);
});

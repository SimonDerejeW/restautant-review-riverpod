import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../data_transfer_objects/comment_dto.dart';

class CommentRemoteDataSource {
  static const baseUrl = 'http://localhost:3000/comment';

  Future<List<CommentDto>> getAllComments() async {
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {'Authorization': 'Bearer YOUR_TOKEN'},
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((json) => CommentDto.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load comments');
    }
  }

  Future<CommentDto> getCommentById(String id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/$id'),
      headers: {'Authorization': 'Bearer YOUR_TOKEN'},
    );

    if (response.statusCode == 200) {
      return CommentDto.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load comment');
    }
  }

  Future<void> createComment(CommentDto comment) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer YOUR_TOKEN'
      },
      body: jsonEncode(comment.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create comment');
    }
  }

  Future<void> updateComment(CommentDto comment) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${comment.id}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer YOUR_TOKEN'
      },
      body: jsonEncode(comment.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update comment');
    }
  }

  Future<void> deleteComment(String id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/$id'),
      headers: {'Authorization': 'Bearer YOUR_TOKEN'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete comment');
    }
  }
}

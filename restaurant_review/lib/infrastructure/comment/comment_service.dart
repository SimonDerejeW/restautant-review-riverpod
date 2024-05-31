import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_review/core/storage.dart';

class CommentService {
  final String baseUrl = 'http://10.0.2.2:3000/comment';
  final SecureStorage _secureStorage = SecureStorage.instance;

  CommentService();

  Future<http.Response> createComment(
      String restaurantId, String opinion) async {
    String? token = await _secureStorage.read('token');
    final url = Uri.parse(baseUrl);

    print("Restauranid $restaurantId, opionion $opinion, baseurl $baseUrl");
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'restaurantId': restaurantId,
        'opinion': opinion,
      }),
    );

    return response;
  }

  Future<http.Response> updateComment(
      String commentId, String newOpinion) async {
    String? token = await _secureStorage.read('token');
    final url = Uri.parse('$baseUrl/$commentId');
    print(url);
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'opinion': newOpinion,
      }),
    );
    print(response);
    return response;
  }

  Future<http.Response> deleteComment(String commentId) async {
    String? token = await _secureStorage.read('token');
    final url = Uri.parse('$baseUrl/$commentId');
    final response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    return response;
  }
}

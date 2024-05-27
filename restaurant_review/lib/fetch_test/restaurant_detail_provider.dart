import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/restaurant_details_model.dart';

Future<RestaurantDetailModel> fetchRestaurantDetails(String id) async {
  final url = Uri.parse('http://10.0.2.2:3000/restaurant/$id');
  final response = await http.get(
    url,
    headers: {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI2NjUzMmVhOWU1Nzk1NzMzZWY2M2VmMDYiLCJ1c2VybmFtZSI6IktldmluIiwicm9sZXMiOlsidXNlciJdLCJpYXQiOjE3MTY3Mjc0NjUsImV4cCI6MTcxNjgxMzg2NX0.6e0HfY5ObB9HpaIyGbYTz5CaZpO4PTqdTkExOcJQJsk'
    }, // Replace with your actual token
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> json = jsonDecode(response.body);
    return RestaurantDetailModel.fromJson(json);
  } else {
    throw Exception('Failed to load restaurant details');
  }
}

final restaurantDetailProvider =
    FutureProvider.family<RestaurantDetailModel, String>((ref, id) async {
  return fetchRestaurantDetails(id);
});

import 'dart:convert';
import 'package:http/http.dart' as http;
import '/models/restaurant_model.dart';

Future<List<RestaurantModel>> fetchRestaurants() async {
  final url = Uri.parse('http://10.0.2.2:3000/restaurant');
  final response = await http.get(
    url,
    headers: {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI2NjUzMGE2OWU1Nzk1NzMzZWY2M2VlZTIiLCJ1c2VybmFtZSI6Ik1lc3NpIiwicm9sZXMiOlsidXNlciJdLCJpYXQiOjE3MTY3MTgxODUsImV4cCI6MTcxNjgwNDU4NX0.GHjnJdWihwzhKVEXjkP6ouRPzwMi-SctmXf5Jp4tzXA'
    }, // Replace with your actual token
  );

  if (response.statusCode == 200) {
    final List<dynamic> responseData = jsonDecode(response.body);
    return responseData.map((json) => RestaurantModel.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load restaurants');
  }
}

import 'package:http/http.dart' as http;
import 'package:restaurant_review/core/storage.dart';

class AdminService {
  final String userUrl = 'http://localhost:3000/users';
  final String banUrl = 'http://localhost:3000/admin-func';
  final SecureStorage _secureStorage = SecureStorage.instance;

  Future<http.Response> banUser(String username) async {
    String? token = await _secureStorage.read('token');
    final response = await http.patch(
      Uri.parse('$banUrl/ban/$username'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    print(response.body);
    return response;
  }

  Future<http.Response> unbanUser(String username) async {
    String? token = await _secureStorage.read('token');
    final response = await http.patch(
      Uri.parse('$banUrl/unban/$username'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    print(response.body);
    return response;
  }

  Future<http.Response> getAllCustomers() async {
    String? token = await _secureStorage.read('token');

    final response = await http.get(Uri.parse('$userUrl?roles=user'), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });
    // print(response.body);
    return response;
  }

  Future<http.Response> getAllOwners() async {
    String? token = await _secureStorage.read('token');

    final response =
        await http.get(Uri.parse('$userUrl?roles=owner'), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });
    // print(response.body);
    return response;
  }
}

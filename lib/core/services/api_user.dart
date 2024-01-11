import 'dart:convert';
import 'package:http/http.dart' as http;

class APIUser {
  static const apiUrl =
      'https://dfa-charity-api-cde8f63449b1.herokuapp.com/api/v1/dj-rest-auth/user/';

  static Future<Map<String, dynamic>> getUserData(String token) async {
    try {
      Map<String, String> headers = {
        'Authorization': 'Token $token',
      };

      final response = await http.get(Uri.parse(apiUrl), headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data; // Assuming the API returns user data as a Map
      } else {
        throw Exception('Failed to fetch user data');
      }
    } catch (error) {
      print('Error fetching user data: $error');
      return {}; // Return an empty map on error
    }
  }
}

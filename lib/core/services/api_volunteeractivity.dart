import 'dart:convert';
import 'package:http/http.dart' as http;

class APIVolunteerActivity {
  // Replace with your actual API endpoint URL
  static const apiUrl =
      'https://dfa-charity-api-cde8f63449b1.herokuapp.com/api/v1/volunteer-activity';

  static Future<List<dynamic>> fetchActivities(String token) async {
    try {
      Map<String, String> headers = {
        'Authorization': 'Token $token',
      };

      final response = await http.get(Uri.parse(apiUrl), headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data; // Assuming the API returns a list of activities
      } else {
        throw Exception('Failed to fetch activities');
      }
    } catch (error) {
      print('Error fetching activities: $error');
      return []; // Return an empty list on error
    }
  }
}

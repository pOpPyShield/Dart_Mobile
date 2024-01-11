import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:volunteerapp/core/services/api_volunteeractivity.dart';
import 'dart:convert';

import 'package:volunteerapp/routes/app_routes.dart';

class APILogin {
  final String _apiUrl =
      'https://dfa-charity-api-cde8f63449b1.herokuapp.com/api/v1/dj-rest-auth/login/'; // Replace with your actual API endpoint

  // Future<String?> checkToken() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getString('token');
  // }

  Future<void> login(
      String username, String password, BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          // 'Authorization': 'Token',
        },
        body: jsonEncode(<String, String>{
          'username': username,
          'password': password,
          // Add any other required fields
        }),
      );

      if (response.statusCode == 200) {
        // Successful login
        final loginData = jsonDecode(response.body);
        print(loginData);
        // Extract the token from the response
        final token = loginData['key']; // Replace with the actual token key
        // Save the token using shared preferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        // Navigate to Home page

        Navigator.pushReplacementNamed(
            context, AppRoutes.bottomnavigationScreen);
      } else {
        // Handle error
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Something is wrong !'),
            content: Text('Username and password are incorrect, try again :('),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, 'Login faild'),
                child: Text('OK'),
              ),
            ],
          ),
        );
        print('Login failed with status: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (error) {
      print('Login error: $error');
      // Handle network or other errors here
    }
  }
}

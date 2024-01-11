import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:volunteerapp/routes/app_routes.dart';

class APIRegister {
  final String _apiUrl =
      'https://dfa-charity-api-cde8f63449b1.herokuapp.com/api/v1/dj-rest-auth/registration/'; // Replace with your actual API endpoint

  Future<void> register(
      Map<String, dynamic> registrationData, BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          // Add any other necessary headers
        },
        body: jsonEncode(registrationData),
      );

      if (response.statusCode == 200) {
        // Successful registration
        print('Registration successful: ${response.body}');
        Navigator.pushReplacementNamed(context, AppRoutes.loginScreen);
        // Handle successful registration response here
        Navigator.pushReplacementNamed(context, AppRoutes.loginScreen);
      } else {
        // Handle error
        print('Registration failed with status: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (error) {
      print('Registration error: $error');
      // Handle network or other errors here
    }
  }
}

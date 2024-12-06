import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:plantatree/model/login_model.dart';
import 'package:plantatree/model/login_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController {
  // Clear the stored token from SharedPreferences
  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  // Log in the user and return a response model or an error message
  Future<LoginResponseModel?> login(LoginModel user) async {
    await clearToken(); // Clear any existing token

    try {
      // Make the HTTP POST request
      final response = await http.post(
        Uri.parse('https://spinryte.in/tree/api/Auth/login'),
        body: user.toJson(),
      );

      // Check the response status code
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        // Extract the token and status from the response
        final token = jsonResponse['output']['token'];
        // final status = jsonResponse['output']['status'];

        // Store the token in SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);

        // Return the parsed LoginResponseModel
        return LoginResponseModel.fromJson(jsonResponse);
      } else if (response.statusCode == 400) {
        throw Exception('Invalid username or password');
      } else {
        throw Exception('Login failed. Please try again later.');
      }
    } catch (e) {
      // Handle any exceptions that occur during the HTTP request
      print('Error: $e');
      return null; // You can return a specific error model if needed
    }
  }
}

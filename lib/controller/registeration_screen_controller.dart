import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:plantatree/model/registeration_screen_model.dart';
import 'package:plantatree/view/bottom_screen.dart';
import 'package:plantatree/view/login_screen.dart';
import 'package:plantatree/widget/textbox_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterationScreenController {
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future register(BuildContext context, RegisterationScreenModel user) async {
    final response = await http.post(
        Uri.parse('https://spinryte.in/tree/api/Auth/signup'),
        body: user.toJson());

    if (response.statusCode == 200) {
      final prefs = getToken();
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const LoginScreen()));
      // Do something with the token and user details, such as storing them in SharedPreferences or navigating to the next screen
    } else if (response.statusCode == 400) {
      final jsonResponse = json.decode(response.body);
      final message = jsonResponse['message'];

      // Inform the user about invalid credentials, e.g., show a snackbar
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Center(
            child: GoogleFont(
          text: message,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        )),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Center(
            child: GoogleFont(
          text: 'Register failed. Please try again later.',
          fontSize: 16,
          fontWeight: FontWeight.w500,
        )),
      ));
    }
  }

  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }
}

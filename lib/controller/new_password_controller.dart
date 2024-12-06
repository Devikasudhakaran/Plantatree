import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:plantatree/view/login_screen.dart';
import 'package:plantatree/model/new_password_model.dart';
import 'package:plantatree/widget/textbox_widget.dart';

class NewPasswordController {
  Future newpasswordverification(
      String token, BuildContext context, NewPasswordModel user) async {
    print("Start otp email");
    final headers = {
      'Authorization1': token,
    };
    final response = await http.post(
      Uri.parse('https://spinryte.in/tree/Auth/forgot_password'),
      headers: headers,
      body: user.toJson(),
    );

    if (response.statusCode == 200) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const LoginScreen()));
    } else if (response.statusCode == 401) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Center(
            child: GoogleFont(
          text: 'Failed to change password',
          fontSize: 16,
          fontWeight: FontWeight.w500,
        )),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Center(
            child: GoogleFont(
          text: 'Failed to change password',
          fontSize: 16,
          fontWeight: FontWeight.w500,
        )),
      ));
    }
  }
}

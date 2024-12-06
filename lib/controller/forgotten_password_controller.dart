import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:plantatree/model/forgotten_password_fetch_model.dart';
import 'package:plantatree/model/forgotten_password_model.dart';
import 'package:plantatree/widget/textbox_widget.dart';

class ForgottenPasswordController {
  Future<ForgottenPasswordFetchModel?> emailverification(
      BuildContext context, ForgottenPasswordModel user) async {
    print("Start otp email");
    final response = await http.post(
      Uri.parse('https://spinryte.in/tree/api/Auth/check_mail'),
      body: user.toJson(),
    );
    final jsonResponse = json.decode(response.body);

    if (response.statusCode == 200) {
      return ForgottenPasswordFetchModel.fromJson(jsonResponse);
    } else if (response.statusCode == 401) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Center(
          child: GoogleFont(
            text: "Invalid Email , please try again",
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ));
    }
    return null;
  }
}

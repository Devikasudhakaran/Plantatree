import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:plantatree/model/otp_verification_fetch_model.dart';
import 'package:plantatree/model/otp_verification_model.dart';
import 'package:plantatree/view/new_password.dart';
import 'package:plantatree/widget/textbox_widget.dart';

class OtpVerificationController {
  Future<OtpVerificationFetchModel?> otpverifiaction(
      BuildContext context, OtpVerificationModel user) async {
    final response = await http.post(
      Uri.parse('https://spinryte.in/tree/api/Auth/otp_verify'),
      body: user.toJson(),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Forgottenpassword(
                token: jsonResponse['token'],
              )));
      print("token here.......................");
      print(jsonResponse['token']);
    } else if (response.statusCode == 401) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Center(
            child: GoogleFont(
          text: 'Invalid Email , please try again',
          fontSize: 16,
          fontWeight: FontWeight.w500,
        )),
      ));
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Center(
            child: GoogleFont(
          text: 'Invalid Email , please try again',
          fontSize: 16,
          fontWeight: FontWeight.w500,
        )),
      ));
    }
    return null;
  }
}

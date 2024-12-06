import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:plantatree/view/login_register_screen.dart';
import 'package:plantatree/model/profile_edit_screen_change_password_model.dart';
import 'package:plantatree/model/profile_edit_screen_fetch_model.dart';
import 'package:plantatree/model/profile_edit_screen_update.dart';
import 'package:plantatree/widget/textbox_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileEditScreenController {
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<ProfileEditScreenFetchModel?> fetchData() async {
    final token = await getToken();
    final headers = {
      'Authorization1': '$token',
    };
    // ignore: avoid_print
    print(token);
    final response = await http.get(
      Uri.parse('https://spinryte.in/tree/api/Auth/profile_view'),
      headers: headers,
    );
    print("working 3 ");

    if (response.statusCode == 200) {
      print("working 3 ");
      final jsonResponse = json.decode(response.body);
      return ProfileEditScreenFetchModel.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  Future<void> changepassword(
      BuildContext context, ProfileEditScreenChangePasswordModel user) async {
    try {
      final token = await getToken();
      final headers = {
        'Authorization1': '$token',
      };

      final response = await http.post(
        Uri.parse('https://spinryte.in/tree/api/Auth/change_password'),
        headers: headers,
        body: user.toJson(),
      );
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Center(
                child: GoogleFont(
          text: 'Your Password Changed',
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ))));
        clearToken();
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const LoginRegisterScreen(),
        ));
      } else {
        throw Exception('Failed to Change Your Password');
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Center(
                child: GoogleFont(
          text: 'Failed to Change Your Password',
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ))),
      );
    }
  }

  Future<void> deactivateaccount(BuildContext context) async {
    try {
      final token = await getToken();
      final headers = {
        'Authorization1': '$token',
      };

      final response = await http.post(
        Uri.parse('https://spinryte.in/tree/api/Auth/account_delete'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Center(
                child: GoogleFont(
          text: 'Your Account Deactivated',
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ))));
        clearToken();
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const LoginRegisterScreen(),
        ));
      } else {
        throw Exception('Failed to Deactivated Your Account');
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Center(
                child: GoogleFont(
          text: 'Failed to Deactivated Account',
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ))),
      );
    }
  }

  Future updateUser(ProfileEditScreenUpdate user, BuildContext context) async {
    try {
      final token = await getToken();
      final headers = {
        'Authorization1': '$token',
      };
      print("working");
      final response = await http.post(
        Uri.parse('https://spinryte.in/tree/api/Auth/user_update'),
        headers: headers,
        body: user.toJson(),
      );
      print("working 2 ");

      if (response.statusCode == 200) {
        fetchData();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Center(
                  child: GoogleFont(
            text: 'Error updateing data',
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ))),
        );
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error: $e');
    }
  }
}

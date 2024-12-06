import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:plantatree/model/home_fetch_model.dart';
import 'package:plantatree/model/project_delete_model.dart';
import 'package:plantatree/widget/textbox_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomeScreenController {
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future deleteProject(BuildContext context, ProjectDeleteModel user) async {
    try {
      final response = await http.post(
        Uri.parse('https://spinryte.in/tree/api/Project/project_delete'),
        body: user.toJson(),
      );
      if (response.statusCode == 200) {
        Navigator.of(context).pop("refresh");
        Navigator.of(context).pop("refresh");
      } else {
        throw Exception('Failed to Delete Your Project');
      }
    } catch (e) {
      // Handle error
      print('Error Deleteing Project: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Center(
                child: GoogleFont(
          text: 'Failed to Delete Project',
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ))),
      );
    }
  }

  Future<HomeFetchModel?> fetchData() async {
    final token = await getToken();
    final headers = {
      'Authorization1': '$token',
    };

    try {
      final response = await http.get(
        Uri.parse('https://spinryte.in/tree/api/Project/homepage'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        return HomeFetchModel.fromJson(jsonResponse);
      }
    } catch (e) {
      print('Error Deleteing Project: $e');
      return null;
    }
    return null;
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:plantatree/model/all_project_screen_delete_model.dart';
import 'package:plantatree/model/all_project_screen_fetch_model.dart';
import 'package:plantatree/widget/textbox_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProjectsScreenController {
  Future deleteProject(
      BuildContext context, ProjectScreenDeleteModel user) async {
    try {
      final response = await http.post(
          Uri.parse('https://spinryte.in/tree/api/Project/project_delete'),
          body: user.toJson());

      final statuscode = response.statusCode;

      if (statuscode == 200) {
        // Navigator.of(context).pop("refresh");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Center(
            child: GoogleFont(
              text: "Failed to Delete Project",
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          )),
        );
      }

      return statuscode.toInt();
    } catch (e) {
      print('Error Deleteing Project: $e');
    }
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<ProjectScreenFetchModel?> fetchData() async {
    try {
      final token = await getToken();
      print("token + $token");
      final headers = {
        'Authorization1': '$token',
      };

      final response = await http.get(
        Uri.parse('https://spinryte.in/tree/api/Project/projectList'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        return ProjectScreenFetchModel.fromJson(jsonResponse);
      } else {
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}

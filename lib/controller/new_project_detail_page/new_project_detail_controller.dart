import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:plantatree/model/new_project_detail_page/new_project_detail_delete_model.dart';
import 'package:plantatree/model/new_project_detail_page/new_project_detail_fetch_model.dart';
import 'package:plantatree/model/new_project_detail_page/new_project_detail_register_model.dart';
import 'package:plantatree/widget/textbox_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class NewProjectDetailController {
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<NewProjectDetailFetchModel?> fetchProjectDetails(int userid) async {
    try {
      final response = await http.get(
        Uri.parse('https://spinryte.in/tree/api/Project/single_view/$userid'),
      );

      print("Status code: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        print("woking if its working");
        final jsonResponse = json.decode(response.body);
        print("Response body: ${jsonResponse}");

        return NewProjectDetailFetchModel.fromJson(jsonResponse);
      } else {
        print("Failed to fetch project details: ${response.statusCode}");
      }
    } catch (e) {
      print('Error Fetching Project Details: $e');
    }

    return null;
  }

  Future<void> register(
      NewProjectDetailRegisterModel user, BuildContext context) async {
    final token = await getToken();
    final url =
        Uri.parse('https://spinryte.in/tree/api/Project/create_project');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Authorization1': '$token',
      },
      body: user.toJson(),
    );
    if (response.statusCode == 200) {
      print("success go on");
      final Map<String, dynamic> responseData = json.decode(response.body);

      if (responseData['status'] == true) {
        // ignore: avoid_print
        print('Project created successfully');
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop("refresh");
      } else {
        // ignore: avoid_print
        print('Failed to create project: ${responseData['message']}');
      }
    } else {
      // ignore: avoid_print
      print('Failed to create project. Error code: ${response.statusCode}');
      // ignore: avoid_print
      print('Error message: ${response.body}');
    }
  }

  Future<void> deleteProject(
      BuildContext context, NewProjectDetailDeleteModel user) async {
    try {
      final response = await http.post(
        Uri.parse('https://spinryte.in/tree/api/Project/project_delete'),
        body: user.toJson(),
      );
      if (response.statusCode == 200) {
        Navigator.of(context).pop();
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
}

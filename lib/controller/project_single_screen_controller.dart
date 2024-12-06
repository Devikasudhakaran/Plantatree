import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:plantatree/model/project_single_screen_delete_project_model.dart';
import 'package:plantatree/model/project_single_screen_fetch_model.dart';
import 'package:plantatree/widget/textbox_widget.dart';

class ProjectSingleScreenController {
  Future<void> deleteProject(
      BuildContext context, ProjectSingleScreenDeleteProjectModel user) async {
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

  Future<ProjectSingleScreenFetchModel?> fetchProjectDetails(int userid) async {
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

        return ProjectSingleScreenFetchModel.fromJson(jsonResponse);
      } else {
        print("Failed to fetch project details: ${response.statusCode}");
      }
    } catch (e) {
      print('Error Fetching Project Details: $e');
    }

    return null;
  }
}

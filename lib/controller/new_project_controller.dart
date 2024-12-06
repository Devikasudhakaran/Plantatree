import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:plantatree/view/new_project_detail.dart';
import 'package:plantatree/model/new_project_fetch_model.dart';
import 'package:plantatree/model/new_project_model.dart';
import 'package:plantatree/widget/textbox_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewProjectController {
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<NewProjectFetchModel?> postData(
      NewProjectModel user, BuildContext context, String name) async {
    final token = await getToken();
    final headers = {
      'Authorization1': '$token',
    };

    final response = await http.post(
        Uri.parse('https://spinryte.in/tree/api/Project/project'),
        headers: headers,
        body: user.toJson());

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => CreateProject(
                userid: jsonResponse["output"].toString(),
                projectname: name,
              )));

      return NewProjectFetchModel.fromJson(jsonResponse);
    } else if (response.statusCode == 401) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Center(
            child: GoogleFont(
          text: '${response.statusCode}',
          fontSize: 16,
          fontWeight: FontWeight.w500,
        )),
      ));
    }
    return null;
  }
}

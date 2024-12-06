import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:plantatree/model/profile_screen_fetch_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreenController {
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }
  // Future<void> uploadImage(String croppedFile) async {

  //   final token = await getToken();

  //   final request = http.MultipartRequest(
  //     'POST',
  //     Uri.parse('https://spinryte.in/tree/api/Auth/image_upload'),
  //   );

  //   request.headers['Authorization1'] = '$token';
  //   request.files.add(await http.MultipartFile.fromPath(
  //     'userImage', croppedFile.,
  //     contentType: MediaType.parse(mimeType),
  //   ));

  //   final response = await request.send();

  //   if (response.statusCode == 200) {
  //     // ignore: avoid_print
  //     print('Image uploaded successfully ${response.reasonPhrase}');
  //     fetchData();
  //     // ignore: use_build_context_synchronously
  //     Navigator.of(context).pop();
  //     setState(() {
  //       _croppedFile == null;
  //     });
  //   } else {
  //     // ignore: avoid_print
  //     print('Failed to upload image. Error: ${response.reasonPhrase}');
  //   }
  // }

  Future<ProfileScreenFetchModel?> fetchData() async {
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

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return ProfileScreenFetchModel.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load data');
    }
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:plantatree/model/feedback_query_fetch_model.dart';
import 'package:plantatree/model/feedback_query_model.dart';
import 'package:plantatree/widget/textbox_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FeedbackQueryController {
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<FeedbackQueryFetchModel?> fetchData() async {
    final token = await getToken();
    print("token + $token");
    print("fetching feedback and query ....... ");
    final headers = {
      'Authorization1': '$token',
    };

    final response = await http.get(
      Uri.parse('https://spinryte.in/tree/api/Feedback/feedbackList'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return FeedbackQueryFetchModel.fromJson(jsonResponse);
    } else {
      print("ERROR PLEASE TRY AGAIN");
      return null;
    }
  }

  Future postData(BuildContext context, FeedbackQueryModel user) async {
    final token = await getToken();
    final headers = {
      'Authorization1': '$token',
    };

    final response = await http.post(
      Uri.parse('https://spinryte.in/tree/api/Feedback/send_feedback'),
      headers: headers,
      body: user.toJson(),
    );
    final statuscodes = response.statusCode;
    if (statuscodes == 200) {
      fetchData();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Center(
          child: GoogleFont(
            text: "Feedback submitted",
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ));

      return statuscodes.toInt();
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Center(
          child: GoogleFont(
            text: "Error submiting Feedback",
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ));
    }
  }
}

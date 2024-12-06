import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:plantatree/model/bank_detail_fetch_model.dart';
import 'package:plantatree/model/bank_detail_page_model.dart';
import 'package:plantatree/model/bank_detail_update_model.dart';
import 'package:plantatree/widget/textbox_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Bankusercontroller {
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<BankDetailFetchModel?> fetchData() async {
    final token = await getToken();
    print("token + $token");
    final headers = {
      'Authorization1': '$token',
    };

    final response = await http.get(
      Uri.parse('https://spinryte.in/tree/api/Bank_account/AccountDetails'),
      headers: headers,
    );
    final jsonResponse = json.decode(response.body);
    if (response.statusCode == 200) {
      return BankDetailFetchModel.fromJson(jsonResponse);
    } else {
      return null;
    }
  }

  Future updatepostData(
      BankDetailUpdateModel user, BuildContext context) async {
    try {
      final token = await getToken();
      final headers = {
        'Authorization1': '$token',
      };

      final response = await http.post(
        Uri.parse('https://spinryte.in/tree/api/Bank_account/update_account'),
        headers: headers,
        body: user.toJson(),
      );
      final statuscode = response.statusCode;

      try {
        if (statuscode == 200) {
          fetchData();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Center(
              child: GoogleFont(
                text: "Bank Details submitted",
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ));
          Navigator.of(context).pop();
        } else if (statuscode == 401) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Center(
              child: GoogleFont(
                text: "Bank Details Not Sumbitted",
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ));
        }
      } catch (e) {
        print(e);
      }

      return statuscode.toInt();
    } catch (e) {
      print('Error Deleteing Project: $e');
      return null;
    }
  }

  Future postData(BuildContext context, BankDetailPageModel user) async {
    try {
      final token = await getToken();
      print(token);
      final headers = {
        'Authorization1': '$token',
      };
      print("post bank details");
      print(user);
      print(token);

      final response = await http.post(
        Uri.parse('https://spinryte.in/tree/api/Bank_account/add_account'),
        headers: headers,
        body: user.toJson(),
      );
      final statuscode = response.statusCode;
      if (statuscode == 200) {
        fetchData();
        Navigator.of(context).pop();
      } else if (statuscode == 401) {
        print("input is wrong");
      }
      if (statuscode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Center(
            child: GoogleFont(
              text: "Bank Details Not Sumbitted",
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ));
      }
      return statuscode.toInt();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Center(
          child: GoogleFont(
            text: "Bank Details Not Sumbitted",
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ));
      print('Error adding bank: $e');
      return null;
    }
  }
}

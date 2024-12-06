import 'package:http/http.dart' as http;
import 'package:plantatree/model/splash_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController {
  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('name');
    await prefs.remove('image');
    print('Token cleared');
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<String?> getfcmToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('fcmToken');
  }

  Future fcmtokenupload(SplashModel user) async {
    final token = await getToken();

    final headers = {
      'Authorization1': '$token',
    };
    try {
      final response = await http.post(
        Uri.parse('https://spinryte.in/tree/api/Fcm_token/create'),
        headers: headers,
        body: user.toJson(),
      );

      if (response.statusCode == 200) {
        print("fcm token upload complete");
        final statuscodes = response.statusCode;
        return statuscodes.toInt();
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<int> fetchData() async {
    final token = await getToken();
    final headers = {
      'Authorization1': '$token',
    };
    print("Bearer $token");

    final response = await http.get(
      Uri.parse('https://spinryte.in/tree/api/Project/projectList'),
      headers: headers,
    );
    final statuscode = response.statusCode;

    return statuscode.toInt();
  }
}

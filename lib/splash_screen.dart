import 'package:flutter/material.dart';
import 'package:plantatree/bottom_screen.dart';
import 'package:plantatree/login_register_screen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration(seconds: 3), () {
      fetchData();
    });
    super.initState();
  }

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

  Future<void> fetchData() async {
    final token = await getToken();
    final headers = {
      'Authorization1': '$token',
    };
    print("Bearer $token");

    final response = await http.get(
      Uri.parse('https://spinryte.in/tree/api/Project/projectList'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Bottomnavbar(),
      ));
    } else {
      clearToken();
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => LoginRegisterScreen(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        "asset/flash_screen/flash screen.png",
        fit: BoxFit.fill,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
      ),
    );
  }
}

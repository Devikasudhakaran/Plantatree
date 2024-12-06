import 'dart:io';

import 'package:flutter/material.dart';
import 'package:plantatree/view/bottom_screen.dart';
import 'package:plantatree/view/login_register_screen.dart';
import 'package:plantatree/controller/splash_controller.dart';
import 'package:plantatree/model/splash_model.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  final SplashController _SplashController = SplashController();

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      fcmtokenupload();
      fetchData();
    });
    super.initState();
  }

  Future<void> fetchData() async {
    final statuscode = await _SplashController.fetchData();
    if (statuscode == 200) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const Bottomnavbar(),
      ));
    } else {
      _SplashController.clearToken();
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const LoginRegisterScreen(),
      ));
    }
  }

  Future<void> fcmtokenupload() async {
    String platform = "";
    if (Platform.isAndroid) {
      setState(() {
        platform = "Android";
      });
    } else {
      setState(() {
        platform = "ios";
      });
    }
    final fcmToken = await _SplashController.getfcmToken();
    final user =
        SplashModel(deviceType: platform, fcmToken: fcmToken.toString());

    final statuscode = await _SplashController.fcmtokenupload(user);
    if (statuscode == 200) {
      print("fcm token upload complete");
    } else {
      print("fcm token upload failed");
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

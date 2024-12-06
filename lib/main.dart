import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:plantatree/view/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  // await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: "AIzaSyAug6lE9_87QOGGV_nE2qwbnXaiOGyC9a4",
              appId: "1:43656529552:android:6d8c81aa70c68b557b3a15",
              messagingSenderId: "43656529552",
              projectId: "plant-a-tree-376ab"))
      : await Firebase.initializeApp();
  // Future<void> HandleBackGroundMsg(RemoteMessage message) async {}
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  await firebaseMessaging.requestPermission();
  final fcmToken = await firebaseMessaging.getToken();
  print("token is here : $fcmToken");

  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('fcmToken', fcmToken.toString());

  // FirebaseMessaging.onBackgroundMessage(HandleBackGroundMsg);

  runApp(const Basepage());
}

class Basepage extends StatelessWidget {
  const Basepage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 236, 250, 238)),
      debugShowCheckedModeBanner: false,
      home: const Splashscreen(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:plantatree/splash_screen.dart';

Future<void> main() async {
  // await dotenv.load(fileName: ".env");
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

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:plantatree/bottom_screen.dart';
import 'package:http/http.dart' as http;
import 'package:plantatree/forgotten_password_email_verification.dart';
import 'package:plantatree/login_register_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  bool isPasswordVisible = true;
  @override
  void initState() {
    clearToken();
    super.initState();
  }

  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  Future<void> login() async {
    await clearToken();

    final response = await http.post(
      Uri.parse('https://spinryte.in/tree/api/Auth/login'),
      body: {
        'name': usernameController.text,
        'password': passwordController.text,
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final token = jsonResponse['output']['token'];

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      // ignore: avoid_print
      print('Token stored: $token');

      // ignore: use_build_context_synchronously
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const Bottomnavbar()));
    } else if (response.statusCode == 401) {
      setState(() {
        isLoading = false;
      });

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Center(child: Text('Invalid username or password')),
      ));
    } else {
      setState(() {
        isLoading = false;
      });

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Center(child: Text('Login failed. Please try again later.')),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          // Navigate to a different page when the back button is pressed
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginRegisterScreen()),
          );
          return false;
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Stack(children: [
              Image.asset(
                "asset/flash_screen/login page background.png",
                fit: BoxFit.fill,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 5,
                    ),
                    const Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF071305)),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 9),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "  Email",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF071305)),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 96),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.3,
                          height: MediaQuery.of(context).size.height / 17,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 5),
                              child: TextField(
                                controller: usernameController,
                                decoration: InputDecoration(
                                    suffixIcon: const Icon(
                                      Icons.email,
                                      color: Color(0xFF071305),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide.none,
                                    )),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "  Password",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF071305)),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 96),
                            Container(
                              width: MediaQuery.of(context).size.width / 1.3,
                              height: MediaQuery.of(context).size.height / 17,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 10, right: 5),
                                  child: TextField(
                                    controller: passwordController,
                                    obscureText: isPasswordVisible,
                                    decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                isPasswordVisible =
                                                    !isPasswordVisible; // Toggle the visibility
                                              });
                                            },
                                            icon: Icon(
                                              isPasswordVisible
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: const Color.fromARGB(
                                                  255, 23, 63, 16),
                                            )),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide.none,
                                        )),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 96),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const ForgottenEmail()));
                          },
                          child: const Text(
                            "Lost Password? ",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF071305)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 7),
                    GestureDetector(
                      onTap: () {
                        if (usernameController.text.isEmpty &&
                            passwordController.text.isEmpty) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content:
                                Text('Please Enter Your Username And Password'),
                          ));
                        } else {
                          setState(() {
                            isLoading = true; // Set loading state to true
                          });
                          login();
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.3,
                        height: MediaQuery.of(context).size.height / 17,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey
                                  .withOpacity(0.2), // Color of the shadow
                              spreadRadius: 3, // Spread radius
                              blurRadius: 3, // Blur radius
                              offset: const Offset(
                                  0, 3), // Offset from the container
                            ),
                          ],
                          color: const Color(0xFF40cd25),
                        ),
                        child: Center(
                            child: isLoading
                                ? LoadingAnimationWidget.fourRotatingDots(
                                    color: Colors.white, size: 20)
                                : const Text(
                                    "Login",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white),
                                  )),
                      ),
                    ),
                  ],
                ),
              )
            ]),
          ),
        ));
  }
}

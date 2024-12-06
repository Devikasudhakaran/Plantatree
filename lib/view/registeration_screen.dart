import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:plantatree/controller/registeration_screen_controller.dart';
import 'package:plantatree/model/registeration_screen_model.dart';
import 'package:plantatree/view/bottom_screen.dart';
import 'package:http/http.dart' as http;
import 'package:plantatree/view/login_screen.dart';
import 'package:plantatree/widget/loading.dart';
import 'package:plantatree/widget/textbox_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Registerationscreen extends StatefulWidget {
  const Registerationscreen({super.key});

  @override
  State<Registerationscreen> createState() => _RegisterationscreenState();
}

class _RegisterationscreenState extends State<Registerationscreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController Aboutcontroller = TextEditingController();
  RegisterationScreenController registerationScreenController =
      RegisterationScreenController();
  bool isLoading = false;
  bool isPasswordVisible = true;
  final String domain = '@gmail.com';

  void _updateText() {
    if (!EmailController.text.endsWith(domain)) {
      EmailController.text =
          EmailController.text.replaceAll(domain, '') + domain;
      EmailController.selection = TextSelection.fromPosition(
        TextPosition(offset: EmailController.text.length - domain.length),
      );
    }
  }

  Future<void> register() async {
    final user = RegisterationScreenModel(
      name: usernameController.text,
      email: EmailController.text,
      password: passwordController.text,
      mobile: phoneController.text,
    );
    registerationScreenController.register(context, user);
  }

  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  @override
  void initState() {
    clearToken();
    _updateText();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("asset/flash_screen/login page background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SizedBox(
          child: SingleChildScrollView(
            child: Container(
              child: Stack(children: [
                //  Image.asset("asset/flash_screen/login page background.png",fit: BoxFit.fill,
                //  width: MediaQuery.of(context).size.width,
                //   height: MediaQuery.of(context).size.height,),

                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 5,
                      ),
                      GoogleFont(
                        text: "Register",
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF071305),
                      ),
                      const SizedBox(height: 100),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GoogleFont(
                            text: "  Name",
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF071305),
                          ),
                          const SizedBox(height: 2),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.3,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 5),
                              child: TextField(
                                controller: usernameController,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[a-z,A-Z, ]')),
                                  LengthLimitingTextInputFormatter(10),
                                ],
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide.none,
                                )),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GoogleFont(
                            text: "  Email",
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF071305),
                          ),
                          const SizedBox(height: 2),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.3,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 5),
                              child: TextField(
                                controller: EmailController,
                                keyboardType: TextInputType.emailAddress,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp(
                                      r'[a-z0-9!@#$%^&*()_+{}|:;,.<>?~`-]')),
                                ],
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
                        ],
                      ),
                      const SizedBox(height: 30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GoogleFont(
                            text: "  Password",
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF071305),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.3,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 5),
                              child: TextField(
                                controller: passwordController,
                                obscureText: isPasswordVisible,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide.none,
                                )),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GoogleFont(
                            text: "  Confirm Password",
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF071305),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.3,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 5),
                              child: TextField(
                                controller: confirmpasswordController,
                                obscureText: isPasswordVisible,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide.none,
                                )),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GoogleFont(
                            text: "  Phone Number",
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF071305),
                          ),
                          const SizedBox(height: 2),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.3,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 5),
                              child: TextField(
                                controller: phoneController,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]')),
                                  LengthLimitingTextInputFormatter(10),
                                ],
                                keyboardType: TextInputType
                                    .phone, // This ensures only numeric keyboard

                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide.none,
                                )),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      GestureDetector(
                        onTap: () {
                          if (usernameController.text.isEmpty ||
                              passwordController.text.isEmpty ||
                              phoneController.text.isEmpty ||
                              EmailController.text.isEmpty ||
                              confirmpasswordController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Center(
                                  child: GoogleFont(
                                      text: 'Please Enter the fields')),
                            ));
                          } else if (confirmpasswordController.text !=
                              passwordController.text) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Center(
                                  child:
                                      GoogleFont(text: 'Incorrect Password')),
                            ));
                          } else {
                            setState(() {
                              isLoading = true; // Set loading state to true
                            });

                            register();
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.3,
                          height: 50,
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
                            color: const Color(0xFF497a39),
                          ),
                          child: Center(
                            child: isLoading
                                ? Loadingwidget(color: Colors.white, size: 20)
                                : GoogleFont(
                                    text: "Already have an account? ",
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(width: 10),
                          Row(
                            children: [
                              GoogleFont(
                                  text: "Already have an account? ",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF071305)),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen()),
                                  );
                                },
                                child: GoogleFont(
                                    text: "Login Now",
                                    fontSize: 14,
                                    color: Colors.blue),
                              )
                            ],
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

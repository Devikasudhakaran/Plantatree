import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:plantatree/otp_verification.dart';

class ForgottenEmail extends StatefulWidget {
  const ForgottenEmail({super.key});

  @override
  State<ForgottenEmail> createState() => _ForgottenEmailState();
}

class _ForgottenEmailState extends State<ForgottenEmail> {
  bool isLoading = false;
  TextEditingController emailController = TextEditingController();

  Future<void> emailverification() async {
    print("Start otp email");
    final response = await http.post(
      Uri.parse('https://spinryte.in/tree/api/Auth/check_mail'),
      body: {
        'email': emailController.text,
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final otp = jsonResponse['output'];
      print("here is you opt");
      print(otp);

      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ForgottenOtp(
                email: emailController.text,
                otp: otp,
              )));
    } else if (response.statusCode == 401) {
      setState(() {
        isLoading = false;
      });

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Center(child: Text('Invalid Email , please try again')),
      ));
    } else {
      setState(() {
        isLoading = false;
      });

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Center(child: Text('Invalid Email , please try again')),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  "Password Reset",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF071305)),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 30),
                Container(
                  width: MediaQuery.of(context).size.width / 1.3,
                  child: Text(
                    "Type your email ID in the field below to recive your validation code by e-mail",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF071305)),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 2.5),
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
                    SizedBox(height: MediaQuery.of(context).size.height / 96),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.3,
                      height: MediaQuery.of(context).size.height / 17,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 5),
                          child: TextField(
                            controller: emailController,
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
                SizedBox(height: MediaQuery.of(context).size.height / 30),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isLoading = true; // Set loading state to true
                    });
                    if (emailController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Please Enter Correct Email'),
                      ));
                    } else {
                      emailverification();
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
                          offset:
                              const Offset(0, 3), // Offset from the container
                        ),
                      ],
                      color: const Color(0xFF40cd25),
                    ),
                    child: Center(
                        child: isLoading
                            ? LoadingAnimationWidget.fourRotatingDots(
                                color: Colors.white, size: 20)
                            : const Text(
                                "Submit",
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
    );
  }
}

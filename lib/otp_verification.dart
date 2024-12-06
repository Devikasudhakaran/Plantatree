import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pinput/pinput.dart';
import 'package:plantatree/new_password.dart';

class ForgottenOtp extends StatefulWidget {
  ForgottenOtp({super.key, required this.email, required this.otp});
  String? email;
  int? otp;

  @override
  State<ForgottenOtp> createState() => _ForgottenOtpState();
}

class _ForgottenOtpState extends State<ForgottenOtp> {
  bool isLoading = false;
  TextEditingController emailController = TextEditingController();
  String? typeotp;
  bool resentaotp = false;

  Future<void> otpverifiaction() async {
    final response = await http.post(
      Uri.parse('https://spinryte.in/tree/api/Auth/otp_verify'),
      body: {
        'otp': typeotp,
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final token = jsonResponse['output']['token'];

      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Forgottenpassword(
                token: token,
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

  Future delaymsg() async {
    await Future.delayed(Duration(minutes: 1));
    setState(() {
      resentaotp = true;
      print(resentaotp);
    });
  }

  @override
  void initState() {
    delaymsg();
    super.initState();
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
                  height: MediaQuery.of(context).size.height / 7,
                ),
                const Text(
                  "OTP Verification",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF071305)),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 30),
                Container(
                  width: MediaQuery.of(context).size.width / 1.3,
                  child: Text(
                    "We have sent the code verification to ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF071305)),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 96),
                Container(
                  width: MediaQuery.of(context).size.width / 1.3,
                  child: Text(
                    widget.email!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF071305)),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 10),
                Container(
                  width: MediaQuery.of(context).size.width / 1.3,
                  child: Text(
                    "Enter the OTP below to verify it",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF071305)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          child: Pinput(
                            length: 5,
                            keyboardType: TextInputType.number,
                            defaultPinTheme: PinTheme(
                                width: MediaQuery.of(context).size.width / 9,
                                height: MediaQuery.of(context).size.height / 17,
                                textStyle: TextStyle(),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10))),
                            onCompleted: (value) {
                              setState(() {
                                typeotp = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 90),
                        Text(
                          "Resent code ?",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: resentaotp
                                  ? Colors.blue
                                  : Color.fromARGB(255, 131, 133, 130)),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 4),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isLoading = true; // Set loading state to true
                    });
                    print(widget.otp.toString());
                    print("new one");
                    print(typeotp);
                    if (identical(widget.otp.toString(), typeotp.toString())) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Wrong OTP'),
                      ));
                    } else {
                      otpverifiaction();
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

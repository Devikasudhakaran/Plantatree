import 'package:flutter/material.dart';
import 'package:plantatree/controller/forgotten_password_controller.dart';
import 'package:plantatree/model/forgotten_password_model.dart';
import 'package:plantatree/view/otp_verification.dart';
import 'package:plantatree/widget/button_widget.dart';
import 'package:plantatree/widget/custom_textfields.dart';
import 'package:plantatree/widget/textbox_widget.dart';

class ForgottenEmail extends StatefulWidget {
  const ForgottenEmail({super.key});

  @override
  State<ForgottenEmail> createState() => _ForgottenEmailState();
}

class _ForgottenEmailState extends State<ForgottenEmail> {
  bool isLoading = false;
  TextEditingController emailController = TextEditingController();
  final ForgottenPasswordController forgottenPasswordController =
      ForgottenPasswordController();

  Future emailverification() async {
    try {
      final user = ForgottenPasswordModel(email: emailController.text);
      final statuscode =
          await forgottenPasswordController.emailverification(context, user);
      if (statuscode?.output != null) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ForgottenOtp(
                  email: emailController.text,
                  otp: statuscode!.output,
                )));
      }

      print(
        statuscode!.output,
      );
    } catch (e) {
      print("password not changed");
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
                GoogleFont(
                  text: "Password Reset",
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 30),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.3,
                  child: GoogleFont(
                    text:
                        "Type your email ID in the field below to recive your validation code by e-mail",
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 2.5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GoogleFont(
                      text: " Email",
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 96),
                    CustomTextfields(
                      height: MediaQuery.of(context).size.height / 16,
                      width: MediaQuery.of(context).size.width / 1.3,
                      suffixIcon: const Icon(
                        Icons.email,
                        color: Color(0xFF071305),
                      ),
                      controller: emailController,
                      obscureText: false,
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 30),
                ButtonWidget(
                    onTap: () {
                      setState(() {
                        isLoading = true; // Set loading state to true
                      });
                      if (emailController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: GoogleFont(
                              text: "Please Enter Correct Email",
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: Colors.white),
                        ));
                      } else {
                        emailverification();
                      }
                    },
                    isloading: isLoading,
                    width: MediaQuery.of(context).size.width / 1.3,
                    hight: MediaQuery.of(context).size.height / 17,
                    text: "Submit"),
              ],
            ),
          )
        ]),
      ),
    );
  }
}

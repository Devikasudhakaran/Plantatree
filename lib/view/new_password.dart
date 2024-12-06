import 'package:flutter/material.dart';
import 'package:plantatree/controller/new_password_controller.dart';
import 'package:plantatree/model/new_password_model.dart';
import 'package:plantatree/widget/button_widget.dart';
import 'package:plantatree/widget/custom_textfields.dart';
import 'package:plantatree/widget/textbox_widget.dart';

class Forgottenpassword extends StatefulWidget {
  Forgottenpassword({super.key, required this.token});
  String? token;

  @override
  State<Forgottenpassword> createState() => _ForgottenpasswordState();
}

class _ForgottenpasswordState extends State<Forgottenpassword> {
  bool isLoading = false;
  TextEditingController emailController = TextEditingController();

  TextEditingController retypeemailController = TextEditingController();
  NewPasswordController newPasswordController = NewPasswordController();

  Future<void> newpasswordverification() async {
    final user = NewPasswordModel(
        newPassword: newPasswordController.toString(),
        confirmPassword: retypeemailController.toString());
    newPasswordController.newpasswordverification(
        widget.token.toString(), context, user);

    setState(() {
      isLoading = false;
    });
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
            child: Center(
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
                      color: const Color(0xFF071305)),
                  SizedBox(height: MediaQuery.of(context).size.height / 30),
                  GoogleFont(
                      text: "Set the new password for your account",
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF071305)),
                  SizedBox(height: MediaQuery.of(context).size.height / 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GoogleFont(
                          text: "New Password",
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF071305)),
                      SizedBox(height: MediaQuery.of(context).size.height / 96),
                      CustomTextfields(
                          width: MediaQuery.of(context).size.width / 1.3,
                          height: MediaQuery.of(context).size.height / 17,
                          controller: emailController,
                          obscureText: true),
                      SizedBox(height: MediaQuery.of(context).size.height / 20),
                      GoogleFont(
                          text: "Re-type Password",
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF071305)),
                      SizedBox(height: MediaQuery.of(context).size.height / 96),
                      CustomTextfields(
                          width: MediaQuery.of(context).size.width / 1.3,
                          height: MediaQuery.of(context).size.height / 17,
                          controller: retypeemailController,
                          obscureText: true),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 5),
                  ButtonWidget(
                    onTap: () {
                      setState(() {
                        isLoading = true; // Set loading state to true
                      });
                      if (emailController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              GoogleFont(text: 'Please enter new password'),
                        ));
                      } else if (retypeemailController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: GoogleFont(text: 'Please retype password'),
                        ));
                      } else if (emailController.text !=
                          retypeemailController.text) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              GoogleFont(text: 'Please check your Password'),
                        ));
                      } else {
                        newpasswordverification();
                      }
                    },
                    isloading: isLoading,
                    text: "Submit",
                    width: MediaQuery.of(context).size.width / 1.3,
                    hight: MediaQuery.of(context).size.height / 17,
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}

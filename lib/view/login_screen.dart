import 'package:plantatree/view/bottom_screen.dart';
import 'package:flutter/material.dart';
import 'package:plantatree/view/forgotten_password_email_verification.dart';
import 'package:plantatree/controller/login_controller.dart';
import 'package:plantatree/model/login_model.dart';
import 'package:plantatree/view/registeration_screen.dart';
import 'package:plantatree/widget/button_widget.dart';
import 'package:plantatree/widget/custom_textfields.dart';
import 'package:plantatree/widget/textbox_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final LoginController _loginController = LoginController();

  bool isLoading = false;
  bool isPasswordVisible = true;

  @override
  void initState() {
    super.initState();
    _loginController.clearToken();
  }

  Future<void> _login() async {
    setState(() {
      isLoading = true;
    });

    final user = LoginModel(
      password: passwordController.text,
      name: usernameController.text,
    );

    final status = await _loginController.login(user);
    final Token = await _loginController.login(user);
    print("here is the new token method :${Token?.output.token}");

    setState(() {
      isLoading = false;
    });

    if (status?.output.status == "1") {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const Bottomnavbar()));
    } else if (status?.output.status == "2") {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: GoogleFont(text: "Account Inactive")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: GoogleFont(
            text: status?.output.status.toString() ?? 'Unknown error occurred'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Bottomnavbar()),
        );
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Image.asset(
              "asset/flash_screen/login page background.png",
              fit: BoxFit.fill,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 5,
                    ),
                    GoogleFont(
                        text: "Login",
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF071305)),
                    SizedBox(height: MediaQuery.of(context).size.height / 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GoogleFont(
                            text: "  Email",
                            fontSize: 15,
                            color: const Color(0xFF071305)),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 96),
                        CustomTextfields(
                          width: MediaQuery.of(context).size.width / 1.3,
                          height: 50,
                          suffixIcon: const Icon(
                            Icons.email,
                            color: Color(0xFF071305),
                          ),
                          controller: usernameController,
                          obscureText: false,
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
                            GoogleFont(
                                text: "  Password",
                                fontSize: 15,
                                color: const Color(0xFF071305)),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 96),
                            CustomTextfields(
                              width: MediaQuery.of(context).size.width / 1.3,
                              height: 50,
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isPasswordVisible = !isPasswordVisible;
                                    });
                                  },
                                  icon: Icon(
                                    isPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color:
                                        const Color.fromARGB(255, 23, 63, 16),
                                  )),
                              controller: passwordController,
                              obscureText: isPasswordVisible,
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
                          child: GoogleFont(
                            text: "Lost Password? ",
                            color: Colors.blue,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 7),
                    ButtonWidget(
                      onTap: () {
                        if (usernameController.text.isEmpty &&
                            passwordController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: GoogleFont(
                                text:
                                    'Please Enter Your Username And Password'),
                          ));
                        } else {
                          setState(() {
                            isLoading = true;
                          });
                          _login();
                        }
                      },
                      isloading: isLoading,
                      text: "Login",
                      width: MediaQuery.of(context).size.width / 1.3,
                      hight: 50,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(width: 10),
                        Row(
                          children: [
                            GoogleFont(
                              text: "Don't have an account? ",
                              fontSize: 13,
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Registerationscreen()),
                                  );
                                },
                                child: GoogleFont(
                                  text: "Register Now",
                                  color: Colors.blue,
                                  fontSize: 13,
                                ))
                          ],
                        ),
                        const SizedBox(width: 10),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

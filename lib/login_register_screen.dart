import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plantatree/login_screen.dart';
import 'package:plantatree/registeration_screen.dart';

class LoginRegisterScreen extends StatefulWidget {
  const LoginRegisterScreen({super.key});

  @override
  State<LoginRegisterScreen> createState() => _LoginRegisterScreenState();
}

class _LoginRegisterScreenState extends State<LoginRegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false; 
      },child: Scaffold(
      body: Stack(children: [
        Image.asset(
          "asset/flash_screen/loginregister.png",
          fit: BoxFit.fill,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 1.34,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const Loginscreen(),
                  ));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.3,
                  height: MediaQuery.of(context).size.height / 17,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color:
                            Colors.grey.withOpacity(0.2), // Color of the shadow
                        spreadRadius: 3, // Spread radius
                        blurRadius: 3, // Blur radius
                        offset: const Offset(0, 3), // Offset from the container
                      ),
                    ],
                    color: const Color(0xFF40cd25),
                  ),
                  child: const Center(
                      child: Text(
                    "Login",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Colors.white),
                  )),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 25,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const Registerationscreen(),
                  ));
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
                        color: const Color(0xFF40cd25)),
                    child: const Center(
                        child: Text(
                      "Register",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Colors.white),
                    ))),
              )
            ],
          ),
        )
      ]),
    ));
  }
}

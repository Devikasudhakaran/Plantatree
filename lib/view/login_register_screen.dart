import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plantatree/view/login_screen.dart';
import 'package:plantatree/widget/button_widget.dart';

class LoginRegisterScreen extends StatelessWidget {
  const LoginRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          SystemNavigator.pop();
          return false;
        },
        child: Scaffold(
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
                    height: MediaQuery.of(context).size.height / 1.3,
                  ),
                  ButtonWidget(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ));
                    },
                    text: "Login",
                    width: MediaQuery.of(context).size.width / 1.3,
                    hight: 50,
                    isloading: false,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 25,
                  ),
                  ButtonWidget(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ));
                    },
                    text: "Register",
                    width: MediaQuery.of(context).size.width / 1.3,
                    hight: 50,
                    isloading: false,
                  ),
                ],
              ),
            )
          ]),
        ));
  }
}

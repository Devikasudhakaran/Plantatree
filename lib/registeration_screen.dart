import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:plantatree/bottom_screen.dart';
import 'package:http/http.dart' as http;
import 'package:plantatree/login_screen.dart';

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
  bool isLoading = false;
  bool isPasswordVisible = true;

  Future<void> register() async {
    print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
    print(EmailController.text);
    print(passwordController.text);

    final response = await http
        .post(Uri.parse('https://spinryte.in/tree/api/Auth/signup'), body: {
      "name": usernameController.text,
      "email": EmailController.text,
      "mobile": phoneController.text,
      "about": Aboutcontroller.text,
      "password": passwordController.text
    });

    if (response.statusCode == 200) {
      // Successful login
      print('Login successful');
      // Parse the JSON response
      final jsonResponse = json.decode(response.body);
      final token = jsonResponse['output']['token'];
      final userId = jsonResponse['output']['user_id'];
      final name = jsonResponse['output']["otp"];
      final email = jsonResponse['output']['email'];
      final mobile = jsonResponse['output']['mobile'];
      print("printing opt here ........");
      print(name);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Loginscreen()));
      // Do something with the token and user details, such as storing them in SharedPreferences or navigating to the next screen
    } else if (response.statusCode == 401) {
      setState(() {
        isLoading = false;
      });
      // Unauthorized - invalid credentials
      print('Invalid username or password');
      // Inform the user about invalid credentials, e.g., show a snackbar
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Center(child: Text('Invalid username or password')),
      ));
    } else {
      setState(() {
        isLoading = false;
      });
      // Other errors, handle accordingly
      print('Login failed with status code ${response.statusCode}');
      // Inform the user about the error, e.g., show a snackbar
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Center(child: Text('Login failed. Please try again later.')),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
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

                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 5,
                      ),
                      Text(
                        "Register",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF071305)),
                      ),
                      SizedBox(height: 100),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "  Name",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF071305)),
                          ),
                          SizedBox(height: 2),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.3,
                            height: MediaQuery.of(context).size.height / 17,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 5),
                              child: TextField(
                                controller: usernameController,
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
                      // SizedBox(height: 30),
                      //   Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Text(
                      //       "  About",
                      //       style: TextStyle(
                      //           fontSize: 18,
                      //           fontWeight: FontWeight.w400,
                      //           color: Color(0xFF071305)),
                      //     ),
                      //     SizedBox(height: 2),
                      //     Container(
                      //       width: MediaQuery.of(context).size.width / 1.3,
                      //       height: MediaQuery.of(context).size.height / 10,
                      //       decoration: BoxDecoration(
                      //         color: Colors.white,
                      //         borderRadius: BorderRadius.circular(20),
                      //       ),
                      //       child: Padding(
                      //         padding: const EdgeInsets.only(left: 10,right: 5),
                      //         child: TextField(
                      //           controller: Aboutcontroller,
                      //           decoration: InputDecoration(
                      //               border: OutlineInputBorder(
                      //                 borderRadius: BorderRadius.circular(20),
                      //                 borderSide: BorderSide.none,
                      //               )),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      SizedBox(height: 30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "  Email",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF071305)),
                          ),
                          SizedBox(height: 2),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.3,
                            height: MediaQuery.of(context).size.height / 17,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 5),
                              child: TextField(
                                controller: EmailController,
                                decoration: InputDecoration(
                                    suffixIcon: Icon(
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
                      SizedBox(height: 30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "  Password",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF071305)),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.3,
                            height: MediaQuery.of(context).size.height / 17,
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
                                          color:
                                              Color.fromARGB(255, 23, 63, 16),
                                        )),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide.none,
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "  Confirm Password",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF071305)),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.3,
                            height: MediaQuery.of(context).size.height / 17,
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
                                          color:
                                              Color.fromARGB(255, 23, 63, 16),
                                        )),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide.none,
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "  Phone Number",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF071305)),
                          ),
                          SizedBox(height: 2),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.3,
                            height: MediaQuery.of(context).size.height / 17,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 5),
                              child: TextField(
                                controller: phoneController,
                                keyboardType: TextInputType
                                    .phone, // This ensures only numeric keyboard
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter
                                      .digitsOnly, // This restricts input to only digits
                                  LengthLimitingTextInputFormatter(
                                      10), // This limits the length to 10 characters
                                ],
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
                      // SizedBox(height: 30),
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Text(
                      //       "  Place",
                      //       style: TextStyle(
                      //           fontSize: 18,
                      //           fontWeight: FontWeight.w400,
                      //           color: Color(0xFF071305)),
                      //     ),
                      //     SizedBox(height: 2),
                      //     Container(
                      //       width: MediaQuery.of(context).size.width / 1.3,
                      //       height: MediaQuery.of(context).size.height / 17,
                      //       decoration: BoxDecoration(
                      //         color: Colors.white,
                      //         borderRadius: BorderRadius.circular(20),
                      //       ),
                      //       child: TextField(
                      //         decoration: InputDecoration(

                      //             //  suffixIcon: Icon(Icons.email,color: Color(0xFF071305),),
                      //             border: OutlineInputBorder(
                      //           borderRadius: BorderRadius.circular(20),
                      //           borderSide: BorderSide.none,
                      //         )),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // SizedBox(height: 30),
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Text(
                      //       "  Address",
                      //       style: TextStyle(
                      //           fontSize: 18,
                      //           fontWeight: FontWeight.w400,
                      //           color: Color(0xFF071305)),
                      //     ),
                      //     SizedBox(height: 2),
                      //     Container(
                      //       width: MediaQuery.of(context).size.width / 1.3,
                      //       height: MediaQuery.of(context).size.height / 17,
                      //       decoration: BoxDecoration(
                      //         color: Colors.white,
                      //         borderRadius: BorderRadius.circular(20),
                      //       ),
                      //       child: Padding(
                      //         padding: const EdgeInsets.only(left: 10,right: 5),
                      //         child: TextField(
                      //           decoration: InputDecoration(

                      //               //    suffixIcon: Icon(Icons.email,color: Color(0xFF071305),),
                      //               border: OutlineInputBorder(
                      //             borderRadius: BorderRadius.circular(20),
                      //             borderSide: BorderSide.none,
                      //           )),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      SizedBox(height: 30),
                      GestureDetector(
                        onTap: () {
                          if (usernameController.text.isEmpty ||
                              passwordController.text.isEmpty ||
                              phoneController.text.isEmpty ||
                              EmailController.text.isEmpty ||
                              confirmpasswordController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Center(
                                  child: Text('Please Enter the fields')),
                            ));
                          } else if (confirmpasswordController.text !=
                              passwordController.text) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Center(child: Text('Incorrect Password')),
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
                                    Offset(0, 3), // Offset from the container
                              ),
                            ],
                            color: Color(0xFF40cd25),
                          ),
                          child: Center(
                              child: isLoading
                                  ? LoadingAnimationWidget.fourRotatingDots(
                                      color: Colors.white, size: 20)
                                  : Text(
                                      "Accept And Submit",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.white),
                                    )),
                        ),
                      ),
                      SizedBox(height: 100),
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

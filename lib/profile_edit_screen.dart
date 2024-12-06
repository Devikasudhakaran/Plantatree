import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:plantatree/login_register_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  bool isLoading = false;
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  TextEditingController usernameController = TextEditingController();
  TextEditingController CurrentpasswordController = TextEditingController();
  TextEditingController RetypepasswordController = TextEditingController();
  TextEditingController NewpasswordController = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController EmailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  Future<void> updateUser() async {
    // ignore: unused_local_variable
    try {
      final token = await getToken();
      final headers = {
        'Authorization1': '$token',
      };

      final response = await http.post(
        Uri.parse('https://spinryte.in/tree/api/Auth/user_update'),
        headers: headers,
        body: {
          "name": usernameController.text,
          "email": EmailController.text,
          "mobile": phoneController.text,
        },
      );

      if (response.statusCode == 200) {
      } else {
        setState(() {
          isLoading = true;
        });
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error: $e');
    }
  }

  String id = '';
  String name = '';
  String image = '';
  String email = '';
  String phonenumber = '';

  Future<void> fetchData() async {
    final token = await getToken();
    final headers = {
      'Authorization1': '$token',
    };
    // ignore: avoid_print
    print(token);
    final response = await http.get(
      Uri.parse('https://spinryte.in/tree/api/Auth/profile_view'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      setState(() {
        id = jsonResponse['output']['id'];
        name = jsonResponse['output']['name'];
        image = jsonResponse['output']['image'];
        email = jsonResponse['output']['email'];
        phonenumber = jsonResponse['output']['mobile'];
      });
    } else {
      setState(() {
        isLoading = true; // Set loading state to true
      });
      throw Exception('Failed to load data');
    }
  }

  void _showEditProfileBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height / 1.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(0xFFE9FFF2),
            ),
            padding: const EdgeInsets.all(20),
            child: Form(
              // Add your form fields for editing user information
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height / 50),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "  Name",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF071305)),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 96),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.1,
                        height: MediaQuery.of(context).size.height / 17,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 5),
                          child: TextField(
                            controller: usernameController,
                            decoration: InputDecoration(
                                hintText: name,
                                hintStyle: const TextStyle(
                                    color: Color.fromARGB(255, 152, 151, 151)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide.none,
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 50),
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
                        width: MediaQuery.of(context).size.width / 1.1,
                        height: MediaQuery.of(context).size.height / 17,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 5),
                          child: TextField(
                            controller: EmailController,
                            decoration: InputDecoration(
                                hintText: email,
                                hintStyle: const TextStyle(
                                    color: Color.fromARGB(255, 152, 151, 151)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide.none,
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 50),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "  Phone",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF071305)),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 96),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.1,
                        height: MediaQuery.of(context).size.height / 17,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 5),
                          child: TextField(
                            controller: phoneController,
                            decoration: InputDecoration(
                                hintText: phonenumber,
                                hintStyle: const TextStyle(
                                    color: Color.fromARGB(255, 152, 151, 151)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide.none,
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 20),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isLoading = true;
                      });

                      if (usernameController.text.isEmpty) {
                        setState(() {
                          usernameController.text = name;
                        });
                      }

                      if (EmailController.text.isEmpty) {
                        setState(() {
                          EmailController.text = email;
                        });
                      }

                      if (phoneController.text.isEmpty) {
                        setState(() {
                          phoneController.text = phonenumber;
                        });
                      }

                      updateUser();
                      fetchData();
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.1,
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
                      child: const Center(
                          child: Text(
                        "Accept And Submit",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: Colors.white),
                      )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> changepassword() async {
    try {
      final token = await getToken();
      final headers = {
        'Authorization1': '$token',
      };

      final response = await http.post(
        Uri.parse('https://spinryte.in/tree/api/Auth/change_password'),
        headers: headers,
        body: jsonEncode({
          "old_password": CurrentpasswordController.text,
          "new_password": NewpasswordController.text,
          "confirm_password": RetypepasswordController.text
        }),
      );
      if (response.statusCode == 200) {
        fetchData();
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Center(child: Text('Your Password Changed'))));
        Navigator.pop(context);
      } else {
        throw Exception('Failed to Change Your Password');
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Center(child: Text('Failed to Change Your Password'))),
      );
    }
  }

  void _changepassword() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height / 1.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(0xFFE9FFF2),
            ),
            padding: const EdgeInsets.all(20),
            child: Form(
              // Add your form fields for editing user information
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height / 50),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "  Current Password",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF071305)),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 96),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.1,
                        height: MediaQuery.of(context).size.height / 17,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 5),
                          child: TextField(
                            obscureText: true,
                            controller: CurrentpasswordController,
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
                  SizedBox(height: MediaQuery.of(context).size.height / 50),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "  New Password",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF071305)),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 96),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.1,
                        height: MediaQuery.of(context).size.height / 17,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 5),
                          child: TextField(
                            obscureText: true,
                            controller: NewpasswordController,
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
                  SizedBox(height: MediaQuery.of(context).size.height / 50),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "  Re-type New Password",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF071305)),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 96),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.1,
                        height: MediaQuery.of(context).size.height / 17,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 5),
                          child: TextField(
                            obscureText: true,
                            controller: RetypepasswordController,
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
                  SizedBox(height: MediaQuery.of(context).size.height / 20),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isLoading = true;
                      });

                      if (NewpasswordController.text.isEmpty &&
                          RetypepasswordController.text.isEmpty &&
                          CurrentpasswordController.text.isEmpty) {
                        setState(() {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Center(
                                      child: Text('Please enter a value'))));
                        });
                      }
                      if (NewpasswordController.text.isEmpty ==
                          RetypepasswordController.text.isEmpty) {
                        changepassword();
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.1,
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
                      child: const Center(
                          child: Text(
                        "Accept And Submit",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: Colors.white),
                      )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  Future<void> deactivateaccount() async {
    try {
      final token = await getToken();
      final headers = {
        'Authorization1': '$token',
      };

      final response = await http.post(
        Uri.parse('https://spinryte.in/tree/api/Auth/account_delete'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Center(child: Text('Your Account Deactivated'))));
        clearToken();
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const LoginRegisterScreen(),
        ));
      } else {
        throw Exception('Failed to Deactivated Your Account');
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Center(child: Text('Failed to Deactivated Account'))),
      );
    }
  }

  @override
  void initState() {
    fetchData();

    super.initState();
  }

  Future<void> decativateyouraccount() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 10),
                Text(
                  "WARRING !!",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Are You Sure, You Want To Delete This Account ?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                )

                // SizedBox(height: 10),
                // Text('Image ID: $imageId'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                deactivateaccount();
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        height: MediaQuery.of(context).size.height / 14,
        width: MediaQuery.of(context).size.width / 1.1,
        child: FloatingActionButton(
            onPressed: (() async {
              decativateyouraccount();
            }),
            backgroundColor: Color(0xFF40cd25),
            child: const Text(
              "Deactivate you account",
              style: TextStyle(color: Colors.white, fontSize: 16),
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 8.5,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 3,
                    blurRadius: 3,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 15, left: 15, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          child: Row(
                            children: [
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 70),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Icon(
                                  Icons.arrow_back_ios,
                                  color: Color(0xFF071305),
                                ),
                              ),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 70),
                              Text(
                                name,
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF071305)),
                              ),
                            ],
                          ),
                        ),
                        const CircleAvatar(
                          foregroundImage:
                              AssetImage("asset/flash_screen/payment.png"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/95,)
                ],
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              name,
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF071305)),
                            ),
                            IconButton(
                              onPressed: _showEditProfileBottomSheet,
                              icon: const Icon(
                                Icons.edit,
                                color: Color(0xFF071305),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 96),
                        Row(
                          children: [
                            const Text(
                              "Email   : ",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromARGB(255, 16, 74, 6)),
                            ),
                            Text(
                              email,
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromARGB(255, 16, 74, 6)),
                            ),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 96),
                        Row(
                          children: [
                            const Text(
                              "Phone  : ",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromARGB(255, 16, 74, 6)),
                            ),
                            Text(
                              phonenumber,
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromARGB(255, 16, 74, 6)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 10,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Change Password",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 16, 74, 6)),
                      ),
                      IconButton(
                        onPressed: _changepassword,
                        icon: const Icon(
                          Icons.edit,
                          color: Color(0xFF071305),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

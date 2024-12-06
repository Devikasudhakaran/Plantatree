import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:plantatree/project_add_screen_project_two.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CreateProjectPageOne extends StatefulWidget {
  const CreateProjectPageOne({super.key});

  @override
  State<CreateProjectPageOne> createState() => _CreateProjectPageOneState();
}

class _CreateProjectPageOneState extends State<CreateProjectPageOne> {
  // ignore: non_constant_identifier_names
  TextEditingController ProjectnameController = TextEditingController();
  bool isLoading1 = false;
  int _output = 0;

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> postData() async {
    if (ProjectnameController.text.isNotEmpty) {
      final token = await getToken();
      final headers = {
        'Authorization1': '$token',
      };

      final response = await http.post(
        Uri.parse('https://spinryte.in/tree/api/Project/project'),
        headers: headers,
        body: jsonEncode(<String, String>{
          'name': ProjectnameController.text,
        }),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        setState(() {
          _output = data['output'];
        });

        if (_output.toString().isNotEmpty) {
          // ignore: use_build_context_synchronously
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CreateProject(
                    userid: _output.toString(),
                    projectname: ProjectnameController.text,
                  )));
        } else if (response.statusCode == 401) {
          setState(() {
            isLoading1 = false;
          });
        } else {
          setState(() {
            isLoading1 = false;
          });

          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Center(child: Text('${response.statusCode}')),
          ));
        }
      }
    }
  }

  Future<void> showImageDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10),
                Text(
                  "WARRING !!",
                  style: TextStyle(fontSize: 20, color: Color(0xFF071305)),
                ),
                SizedBox(height: 10),
                Text(
                  "Changes that you made may not be saved",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Color(0xFF071305)),
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop("refresh");
              },
              child: const Text('Leave'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          Stack(children: [
            Image.asset(
              "asset/flash_screen/create project base.png",
              fit: BoxFit.fill,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Center(
                              child: GestureDetector(
                            onTap: () {
                              showImageDialog();
                            },
                            child: const Icon(
                              Icons.arrow_back_ios,
                              color: Color(0xFF071305),
                              size: 20,
                            ),
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
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
                    "New Project",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF071305)),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 1.8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "  Project Name",
                        style: TextStyle(
                            fontSize: 16,
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
                              controller: ProjectnameController,
                              decoration: InputDecoration(
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
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 25,
                  ),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          isLoading1 = true;
                        });
                        postData();
                      },
                      child: Container(
                          width: MediaQuery.of(context).size.width / 1.3,
                          height: MediaQuery.of(context).size.height / 17,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 3,
                                blurRadius: 3,
                                offset: const Offset(0, 3),
                              ),
                            ],
                            color: const Color(0xFF40cd25),
                          ),
                          child: Center(
                              child: isLoading1
                                  ? LoadingAnimationWidget.fourRotatingDots(
                                      color: Colors.white, size: 20)
                                  : const Text("Submit",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.white))))),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 30,
                  )
                ],
              ),
            )
          ]),
        ],
      )),
    );
  }
}

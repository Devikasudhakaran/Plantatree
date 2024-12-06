import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plantatree/login_register_screen.dart';
import 'package:plantatree/notification_screen.dart';
import 'package:plantatree/profile_edit_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _captureimage;
  // ignore: unused_field, prefer_final_fields
  bool _isLoading = true;
  // ignore: unused_field, prefer_final_fields
  String _uploadStatus = '';

  Future _selectPicture() async {
    // ignore: no_leading_underscores_for_local_identifiers
    final _capture = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: MediaQuery.of(context).size.width,
      maxHeight: MediaQuery.of(context).size.height,
      imageQuality: 50,
    );
    if (_capture == null) return;
    setState(() {
      _captureimage = File(_capture.path);
    });

    if (_captureimage != null) {
      uploadImage();
    }
  }

  Future _takePicture() async {
    // ignore: no_leading_underscores_for_local_identifiers
    final _capture = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: MediaQuery.of(context).size.width,
      maxHeight: MediaQuery.of(context).size.height,
      imageQuality: 50,
    );
    if (_capture == null) return;
    setState(() {
      _captureimage = File(_capture.path);
    });

    if (_captureimage != null) {
      uploadImage();
    }
  }

  Future<void> uploadImage() async {
    if (_captureimage == null) {
      // ignore: avoid_print
      print('Invalid image path');
      return;
    }

    String extension = _captureimage!.path.split('.').last;
    String mimeType = 'image/$extension';
    final token = await getToken();

    final request = http.MultipartRequest(
      'POST',
      Uri.parse('https://spinryte.in/tree/api/Auth/image_upload'),
    );

    request.headers['Authorization1'] = '$token';
    request.files.add(await http.MultipartFile.fromPath(
      'userImage',
      _captureimage!.path,
      contentType: MediaType.parse(mimeType),
    ));

    final response = await request.send();

    if (response.statusCode == 200) {
      // ignore: avoid_print
      print('Image uploaded successfully ${response.reasonPhrase}');
      fetchData();
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    } else {
      // ignore: avoid_print
      print('Failed to upload image. Error: ${response.reasonPhrase}');
    }
  }

  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  String id = '';
  String name = '';
  String image = '';

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

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
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void cameraorgalleryimage() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 5,
          color: const Color(0xFFE9FFF2),
          child: Padding(
            padding: const EdgeInsets.all(60.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      _selectPicture();
                    },
                    icon: const Icon(
                      Icons.collections,
                      size: 50,
                      color: Color(0xFF0e9215),
                    )),
                IconButton(
                    onPressed: () {
                      _takePicture();
                    },
                    icon: const Icon(
                      Icons.camera_alt,
                      size: 50,
                      color: Color(0xFF0e9215),
                    ))
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false; 
      },child: Scaffold(
      body: name.isEmpty
          ? Center(
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                  height: MediaQuery.of(context).size.height / 1.2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LoadingAnimationWidget.fourRotatingDots(
                          color: Colors.green, size: 40)
                    ],
                  )),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 2.6,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF0e9215),
                              Color(0xFF9af881),
                            ],
                          ),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 16,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Stack(children: [
                                    if (image.isEmpty)
                                      CircleAvatar(
                                        backgroundColor:
                                            const Color(0xFFE9FFF2),
                                        backgroundImage: const AssetImage(
                                          "asset/flash_screen/profile.png",
                                        ),
                                        radius:
                                            MediaQuery.of(context).size.height /
                                                7.5,
                                      ),
                                    Stack(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          foregroundColor: Colors.transparent,
                                          backgroundImage: NetworkImage(
                                            image,
                                          ),
                                          radius: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              7.5,
                                        ),
                                        Column(
                                          children: [
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  5,
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2.3,
                                                ),
                                                Container(
                                                  height: 50,
                                                  width: 50,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                    color: Colors.white,
                                                  ),
                                                  child: IconButton(
                                                      onPressed: () {
                                                        cameraorgalleryimage();
                                                      },
                                                      icon: const Icon(
                                                        Icons
                                                            .add_a_photo_outlined,
                                                        size: 20,
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ]),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 3.4,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  name,
                                  style: const TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xFFf8f8f8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 30,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const ProfileEditScreen(),
                                ));
                              },
                              child: const Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Edit Profile",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFF071305)),
                                      ),
                                      Text(
                                        ">",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFF071305)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 30,
                            ),
                            const Divider(
                              thickness: 1,
                              color: Color.fromARGB(255, 173, 173, 173),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 30,
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: const Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "My Rewards",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFF071305)),
                                      ),
                                      Text(
                                        ">",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFF071305)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 30,
                            ),
                            const Divider(
                              thickness: 1,
                              color: Color.fromARGB(255, 173, 173, 173),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 30,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const NotificationScreen(),
                                ));
                              },
                              child: const Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Notification",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFF071305)),
                                      ),
                                      Text(
                                        ">",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFF071305)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 30,
                            ),
                            const Divider(
                              thickness: 1,
                              color: Color.fromARGB(255, 173, 173, 173),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 30,
                            ),
                            GestureDetector(
                              onTap: () {
                                clearToken();
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const LoginRegisterScreen(),
                                ));
                              },
                              child: const Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Logout",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFF071305)),
                                      ),
                                      Text(
                                        ">",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFF071305)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 30,
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
    ) );
  }
}

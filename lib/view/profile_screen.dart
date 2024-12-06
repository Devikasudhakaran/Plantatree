import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plantatree/view/bank_details_screen_.dart';
import 'package:plantatree/view/feedbacks_screen.dart';
import 'package:plantatree/view/login_register_screen.dart';
import 'package:plantatree/view/notification_screen.dart';
import 'package:plantatree/view/profile_edit_screen.dart';
import 'package:plantatree/controller/profile_screen_controller.dart';
import 'package:plantatree/view/wallet_screen.dart';
import 'package:plantatree/widget/alert_message.dart';
import 'package:plantatree/widget/loading.dart';
import 'package:plantatree/widget/textbox_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:image_cropper/image_cropper.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileScreenController profileScreenController = ProfileScreenController();
  File? _captureimage;
  // ignore: unused_field, prefer_final_fields
  bool _isLoading = true;
  // ignore: unused_field, prefer_final_fields
  String _uploadStatus = '';
  CroppedFile? _croppedFile;
  String id = '';
  String name = '';
  String image = '';

  Future _selectPicture() async {
    // ignore: no_leading_underscores_for_local_identifiers
    final _capture = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: MediaQuery.of(context).size.width,
      maxHeight: MediaQuery.of(context).size.height,
      imageQuality: 100,
    );
    if (_capture == null) return;
    setState(() {
      _captureimage = File(_capture.path);
    });

    if (_captureimage != null) {
      _cropImage();
    }
  }

  Future<void> _cropImage() async {
    setState(() {
      _croppedFile = null;
    });

    print("Captured image path: ${_captureimage!.path}");
    if (_captureimage != null) {
      final CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: _captureimage!.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.green,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: false,
            hideBottomControls: false,
            aspectRatioPresets: [
              CropAspectRatioPreset.ratio4x3,
            ],
          ),
          IOSUiSettings(
            title: 'Cropper',
            aspectRatioPresets: [
              CropAspectRatioPreset.ratio4x3,
            ],
          ),
        ],
      );

      print("workining");
      setState(() {
        print("Cropped image path: ${croppedFile!.path}");
        _croppedFile = croppedFile;
      });
      uploadImage();
    }
  }

  Future _takePicture() async {
    // ignore: no_leading_underscores_for_local_identifiers
    final _capture = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );
    if (_capture == null) return;
    setState(() {
      _captureimage = File(_capture.path);
    });

    if (_captureimage != null) {
      _cropImage();
    }
  }

  Future<void> uploadImage() async {
    if (_croppedFile == null) {
      // ignore: avoid_print
      print('Invalid image path');
      return;
    }
    print("image upload");
    print(_croppedFile!.path);
    String extension = _croppedFile!.path.split('.').last;
    String mimeType = 'image/$extension';
    final token = await getToken();

    final request = http.MultipartRequest(
      'POST',
      Uri.parse('https://spinryte.in/tree/api/Auth/image_upload'),
    );

    request.headers['Authorization1'] = '$token';
    request.files.add(await http.MultipartFile.fromPath(
      'userImage',
      _croppedFile!.path,
      contentType: MediaType.parse(mimeType),
    ));

    final response = await request.send();

    if (response.statusCode == 200) {
      // ignore: avoid_print
      print('Image uploaded successfully ${response.reasonPhrase}');
      fetchData();
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
      setState(() {
        _croppedFile == null;
      });
    } else {
      // ignore: avoid_print
      print('Failed to upload image. Error: ${response.reasonPhrase}');
    }
  }

  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> fetchData() async {
    final details = await profileScreenController.fetchData();

    setState(() {
      id = details!.output.id;
      name = details!.output.name;
      image = details!.output.image;
    });
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
                      color: Color(0xFF497a39),
                    )),
                IconButton(
                    onPressed: () {
                      _takePicture();
                    },
                    icon: const Icon(
                      Icons.camera_alt,
                      size: 50,
                      color: Color(0xFF497a39),
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
        },
        child: Scaffold(
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
                          Loadingwidget(
                              color: const Color(0xFF497a39), size: 40)
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
                                  height:
                                      MediaQuery.of(context).size.height / 16,
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
                                            radius: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                7.5,
                                          ),
                                        Stack(
                                          children: [
                                            CircleAvatar(
                                              backgroundColor:
                                                  Colors.transparent,
                                              foregroundColor:
                                                  Colors.transparent,
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
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              2.3,
                                                    ),
                                                    Container(
                                                      height: 50,
                                                      width: 50,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25),
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
                                height:
                                    MediaQuery.of(context).size.height / 3.4,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GoogleFont(
                                        text: name,
                                        fontSize: 30,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white),
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
                                  height:
                                      MediaQuery.of(context).size.height / 30,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    String? Refreash =
                                        await Navigator.of(context)
                                            .push(MaterialPageRoute(
                                      builder: (context) =>
                                          const ProfileEditScreen(),
                                    ));
                                    if (Refreash == "refresh") {
                                      fetchData();
                                    }
                                  },
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          GoogleFont(
                                              text: "Edit Profile",
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xFF071305)),
                                          GoogleFont(
                                              text: ">",
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xFF071305)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 30,
                                ),
                                const Divider(
                                  thickness: 1,
                                  color: Color.fromARGB(255, 173, 173, 173),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 30,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    String? Refreash =
                                        await Navigator.of(context)
                                            .push(MaterialPageRoute(
                                      builder: (context) =>
                                          const BankDetailscreen(),
                                    ));
                                    if (Refreash == "refresh") {
                                      fetchData();
                                    }
                                  },
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          GoogleFont(
                                              text: "Bank Details",
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xFF071305)),
                                          GoogleFont(
                                              text: ">",
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xFF071305)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 30,
                                ),
                                const Divider(
                                  thickness: 1,
                                  color: Color.fromARGB(255, 173, 173, 173),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 30,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const WalletScren()));
                                  },
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          GoogleFont(
                                              text: "My Rewards",
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xFF071305)),
                                          GoogleFont(
                                              text: ">",
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xFF071305)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 30,
                                ),
                                const Divider(
                                  thickness: 1,
                                  color: Color.fromARGB(255, 173, 173, 173),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 30,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                          const NotificationScreen(),
                                    ));
                                  },
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          GoogleFont(
                                              text: "Notification",
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xFF071305)),
                                          GoogleFont(
                                              text: ">",
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xFF071305)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 30,
                                ),
                                const Divider(
                                  thickness: 1,
                                  color: Color.fromARGB(255, 173, 173, 173),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 30,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    String? Refreash =
                                        await Navigator.of(context)
                                            .push(MaterialPageRoute(
                                      builder: (context) =>
                                          const Feedbacksscreen(),
                                    ));
                                    if (Refreash == "refresh") {
                                      fetchData();
                                    }
                                  },
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          GoogleFont(
                                              text: "Feedbacks And Query",
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xFF071305)),
                                          GoogleFont(
                                              text: ">",
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xFF071305)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 30,
                                ),
                                const Divider(
                                  thickness: 1,
                                  color: Color.fromARGB(255, 173, 173, 173),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 30,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Altermessage.showCustomDialog(
                                      onConfirmed: () {
                                        clearToken();
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginRegisterScreen(),
                                        ));
                                      },
                                      title: "WARRING",
                                      message: "Log out of your account",
                                      confirmnavi: 1,
                                      cannelbutton: "Cancel",
                                      confirmbutton: 'Log out',
                                      context: context,
                                      cannelnavi: 0,
                                      onCannel: () {},
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          GoogleFont(
                                              text: "Logout",
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xFF071305)),
                                          GoogleFont(
                                              text: ">",
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xFF071305)),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 50,
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 30,
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
        ));
  }
}

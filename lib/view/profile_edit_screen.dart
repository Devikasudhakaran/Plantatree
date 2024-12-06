import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plantatree/controller/profile_edit_screen_controller.dart';
import 'package:plantatree/model/profile_edit_screen_change_password_model.dart';
import 'package:plantatree/model/profile_edit_screen_update.dart';
import 'package:plantatree/widget/add_info_box.dart';
import 'package:plantatree/widget/alert_message.dart';
import 'package:plantatree/widget/profile_info_box.dart';
import 'package:plantatree/widget/profile_info_change_password.dart';
import 'package:plantatree/widget/textbox_widget.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  bool isLoading = false;

  TextEditingController usernameController = TextEditingController();
  TextEditingController CurrentpasswordController = TextEditingController();
  TextEditingController RetypepasswordController = TextEditingController();
  TextEditingController NewpasswordController = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController EmailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  ProfileEditScreenController profileEditScreenController =
      ProfileEditScreenController();

  Future<void> updateUser() async {
    final user = ProfileEditScreenUpdate(
        name: usernameController.text,
        email: EmailController.text,
        mobile: phoneController.text);

    profileEditScreenController.updateUser(user, context);
    fetchData();
  }

  String id = '';
  String name = '';
  String image = '';
  String email = '';
  String phonenumber = '';

  Future<void> fetchData() async {
    final details = await profileEditScreenController.fetchData();
    try {
      setState(() {
        id = details!.output.id;
        name = details.output.name;
        image = details.output.image;
        email = details.output.email;
        phonenumber = details.output.mobile;
        isLoading = true;
      });
    } catch (e) {
      throw Exception('Failed to load data');
    }
  }

  Future deactivateaccount() async {
    profileEditScreenController.deactivateaccount(context);
  }

  Future<void> changepassword() async {
    final user = ProfileEditScreenChangePasswordModel(
        oldPassword: CurrentpasswordController.text,
        newPassword: NewpasswordController.text,
        confirmPassword: RetypepasswordController.text);

    profileEditScreenController.changepassword(context, user);
  }

  @override
  void initState() {
    fetchData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop("refresh");
          return false;
        },
        child: Scaffold(
          floatingActionButton: SizedBox(
            height: MediaQuery.of(context).size.height / 14,
            width: MediaQuery.of(context).size.width / 1.1,
            child: FloatingActionButton(
              onPressed: (() async {
                Altermessage.showCustomDialog(
                    context: context,
                    onConfirmed: () {
                      deactivateaccount();
                      Navigator.of(context).pop("refresh");
                      Navigator.of(context).pop("refresh");
                    },
                    confirmbutton: "Confirm",
                    cannelbutton: "Cancel",
                    title: "WARRING !!",
                    message: "Are You Sure, You Want To Delete This Account ?",
                    onCannel: () {
                      Navigator.pop(context);
                    },
                    confirmnavi: 2,
                    cannelnavi: 1);
              }),
              backgroundColor: const Color(0xFF497a39),
              child: GoogleFont(
                text: "Deactivate you account",
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          body: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 8.5,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color:
                          Colors.grey.withOpacity(0.2), // Color of the shadow
                      spreadRadius: 1, // Spread radius
                      blurRadius: 1.4, // Blur radius
                      offset: const Offset(0, 2),
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
                                    Navigator.of(context).pop("refresh");
                                  },
                                  child: const Icon(
                                    Icons.arrow_back_ios,
                                    color: Color(0xFF071305),
                                  ),
                                ),
                                SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 70),
                                GoogleFont(
                                  text: name,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF071305),
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
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 95,
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  ProfileInfoBox(
                    onTap: () {
                      AddInfoBox.showCustomDialog(
                          context: context,
                          obscureText1: false,
                          obscureText2: false,
                          obscureText3: false,
                          obscureText4: false,
                          obscureText5: false,
                          inputboxno: 3,
                          onConfirmed: () {
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
                            setState(() {
                              id = "";
                              name = "";
                              image = "";
                              email = "";
                              phonenumber = "";
                            });
                            updateUser();
                            Navigator.of(context).pop("refresh");
                          },
                          title4: "Change Details",
                          title1: "Name",
                          banknameController1: usernameController,
                          banknameController2: EmailController,
                          banknameController3: phoneController,
                          phonenumberlimiter: [
                            LengthLimitingTextInputFormatter(10),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          hintText1: name,
                          hintText2: email,
                          hintText3: phonenumber,
                          title2: "Email",
                          title3: "Phone Number",
                          onCancel: () {
                            Navigator.pop(context);
                          },
                          confirmbutton: "Submit",
                          cancelbutton: "Cancel");
                    },
                    headtext: name,
                    text2: email,
                    headtext2: "Email",
                    text3: phonenumber,
                    headtext3: "Phone",
                  ),
                  ProfileInfoChangePassword(onTap: () {
                    AddInfoBox.showCustomDialog(
                        context: context,
                        inputboxno: 3,
                        onConfirmed: () {
                          setState(() {
                            isLoading = true;
                          });

                          if (NewpasswordController.text.isEmpty &&
                              RetypepasswordController.text.isEmpty &&
                              CurrentpasswordController.text.isEmpty) {
                            setState(() {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                      content: Center(
                                          child: GoogleFont(
                                text: 'Please enter all the values',
                              ))));
                            });
                          }
                          if (NewpasswordController.text.isEmpty ==
                              RetypepasswordController.text.isEmpty) {
                            changepassword();
                          }
                          Navigator.of(context).pop("refresh");
                        },
                        title: "Change Password",
                        title1: "Current Password",
                        banknameController1: CurrentpasswordController,
                        banknameController2: NewpasswordController,
                        banknameController3: RetypepasswordController,
                        title2: "New password",
                        title3: "Re-type New Password",
                        onCancel: () {
                          Navigator.pop(context);
                        },
                        confirmbutton: "Submit",
                        cancelbutton: "Cancel",
                        obscureText1: true,
                        obscureText2: true,
                        obscureText3: true,
                        obscureText4: false,
                        obscureText5: false);
                  }),
                ],
              ),
            ],
          ),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:plantatree/controller/new_project_controller.dart';
import 'package:plantatree/model/new_project_model.dart';
import 'package:plantatree/widget/alert_message.dart';
import 'package:plantatree/widget/button_widget.dart';
import 'package:plantatree/widget/custom_textfields.dart';
import 'package:plantatree/widget/textbox_widget.dart';

class CreateProjectPageOne extends StatefulWidget {
  const CreateProjectPageOne({super.key});

  @override
  State<CreateProjectPageOne> createState() => _CreateProjectPageOneState();
}

class _CreateProjectPageOneState extends State<CreateProjectPageOne> {
  // ignore: non_constant_identifier_names
  TextEditingController ProjectnameController = TextEditingController();
  bool isLoading1 = false;
  final int _output = 0;
  NewProjectController newProjectController = NewProjectController();

  Future<void> postData() async {
    final user = NewProjectModel(name: ProjectnameController.text);
    final Token = await newProjectController.postData(
        user, context, ProjectnameController.text);
    setState(() {
      isLoading1 = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Altermessage.showCustomDialog(
              context: context,
              onConfirmed: () {
                Navigator.of(context).pop("refresh");
                Navigator.of(context).pop("refresh");
              },
              onCannel: () {
                Navigator.of(context).pop();
              },
              confirmbutton: 'Leave',
              cannelbutton: 'Cancel',
              title: "WARRING !!",
              message: "Changes that you made may not be saved",
              confirmnavi: 2,
              cannelnavi: 1);
          return false;
        },
        child: Scaffold(
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
                          onTap: () {},
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
                                  Altermessage.showCustomDialog(
                                      context: context,
                                      onConfirmed: () {
                                        Navigator.of(context).pop("refresh");
                                        Navigator.of(context).pop("refresh");
                                      },
                                      onCannel: () {
                                        Navigator.of(context).pop("refresh");
                                      },
                                      confirmbutton: 'Leave',
                                      cannelbutton: 'Cancel',
                                      title: "WARRING !!",
                                      message:
                                          "Changes that you made may not be saved",
                                      confirmnavi: 2,
                                      cannelnavi: 1);
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
                      GoogleFont(
                          text: "New Project",
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF071305)),
                      SizedBox(
                          height: MediaQuery.of(context).size.height / 1.8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GoogleFont(
                              text: "  Project Name",
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF071305)),
                          SizedBox(
                              height: MediaQuery.of(context).size.height / 96),
                          CustomTextfields(
                            controller: ProjectnameController,
                            width: MediaQuery.of(context).size.width / 1.3,
                            height: MediaQuery.of(context).size.height / 17,
                            obscureText: false,
                            maxLength: 12,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 25,
                      ),
                      ButtonWidget(
                        onTap: () {
                          setState(() {
                            isLoading1 = true;
                          });
                          postData();
                        },
                        isloading: isLoading1,
                        text: "Submit",
                        width: MediaQuery.of(context).size.width / 1.3,
                        hight: MediaQuery.of(context).size.height / 17,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 30,
                      )
                    ],
                  ),
                )
              ]),
            ],
          )),
        ));
  }
}

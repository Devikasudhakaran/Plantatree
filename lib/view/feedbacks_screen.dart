import 'package:flutter/material.dart';
import 'package:plantatree/controller/feedback_query_controller.dart';
import 'package:plantatree/model/feedback_query_fetch_model.dart';
import 'package:plantatree/model/feedback_query_model.dart';
import 'package:plantatree/widget/add_bank-details.dart';
import 'package:plantatree/widget/add_info_box.dart';
import 'package:plantatree/widget/appbar.dart';
import 'package:plantatree/widget/feedback_query_detail.dart';
import 'package:plantatree/widget/list_view_builder.dart';
import 'package:plantatree/widget/loading.dart';
import 'package:plantatree/widget/textbox_widget.dart';

class Feedbacksscreen extends StatefulWidget {
  const Feedbacksscreen({super.key});

  @override
  State<Feedbacksscreen> createState() => _FeedbacksscreenState();
}

class _FeedbacksscreenState extends State<Feedbacksscreen> {
  TextEditingController subjectController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isloading = true;
  bool addpageinfopage = true;
  final FeedbackQueryController feedbackQueryController =
      FeedbackQueryController();
  List<DataList> dataList = [];

  Future postData() async {
    if (descriptionController.text.isNotEmpty &&
        subjectController.text.isNotEmpty) {
      setState(() {
        isloading = true;
        dataList.clear();
      });

      final user = FeedbackQueryModel(
          subject: subjectController.text,
          description: descriptionController.text);
      final statuscode = await feedbackQueryController.postData(context, user);

      if (statuscode == 200) {
        setState(() {
          dataList.clear();
          subjectController.clear();
          descriptionController.clear();
        });
        fetchData();
        Navigator.of(context).pop();
      }
    }
  }

  Future<void> fetchData() async {
    final statuscode = await feedbackQueryController.fetchData();

    try {
      setState(() {
        dataList = statuscode!.dataList;
      });
      if (dataList.isEmpty) {
        setState(() {
          isloading = false;
        });
      }
      if (dataList.isNotEmpty) {
        setState(() {
          isloading = false;
          addpageinfopage = false;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Center(
          child: GoogleFont(
              text: e.toString(),
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Colors.white),
        ),
      ));
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isloading
          ? Loadingwidget(color: Colors.green, size: 40)
          : Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 7.5,
                      ),
                      addpageinfopage
                          ? AddBankDetailBox(
                              text: '+Feedback & Query',
                              onTap: () {
                                AddInfoBox.showCustomDialog(
                                    context: context,
                                    obscureText1: false,
                                    obscureText2: false,
                                    obscureText3: false,
                                    obscureText4: false,
                                    obscureText5: false,
                                    onConfirmed: () {
                                      postData();
                                      Navigator.of(context).pop("refresh");
                                    },
                                    onCancel: () {
                                      Navigator.of(context).pop();
                                    },
                                    confirmbutton: "Sumbit",
                                    cancelbutton: "Cancel",
                                    title: "Feedback And Query",
                                    title1: "Subject",
                                    title2: "description",
                                    banknameController1: subjectController,
                                    banknameController2: descriptionController,
                                    hight:
                                        MediaQuery.of(context).size.height / 14,
                                    hight1:
                                        MediaQuery.of(context).size.height / 8,
                                    inputboxno: 2);
                              },
                              fontSize: 30,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            )
                          : SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: ListViewBuilder(
                                  itemBuilder: (condext, Index) {
                                    final details = dataList[Index];

                                    return FeedbackQueryDetail(
                                      date: details.createdAt.toString(),
                                      description: details.feedbackNote,
                                      subject: details.subject,
                                      replay: details.reply,
                                    );
                                  },
                                  itemCount: dataList.length),
                            )
                    ],
                  ),
                ),
                Appbar(headingtext: "Feedback And Query"),
              ],
            ),
      floatingActionButton: addpageinfopage
          ? null
          : FloatingActionButton(
              onPressed: (() async {
                AddInfoBox.showCustomDialog(
                    context: context,
                    obscureText1: false,
                    obscureText2: false,
                    obscureText3: false,
                    obscureText4: false,
                    obscureText5: false,
                    onConfirmed: () {
                      postData();
                      Navigator.of(context).pop("refresh");
                    },
                    onCancel: () {
                      Navigator.of(context).pop();
                    },
                    confirmbutton: "Sumbit",
                    cancelbutton: "Cancel",
                    title: "Feedback And Query",
                    title1: "Subject",
                    title2: "description",
                    banknameController1: subjectController,
                    banknameController2: descriptionController,
                    hight: MediaQuery.of(context).size.height / 14,
                    hight1: MediaQuery.of(context).size.height / 8,
                    inputboxno: 2);
              }),
              backgroundColor: Colors.white,
              child: const Icon(
                Icons.add,
                color: Color(0xFF497a39),
              ),
            ),
    );
  }
}

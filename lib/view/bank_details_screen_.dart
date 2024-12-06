import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plantatree/controller/bank_detailpage_user_controller.dart';
import 'package:plantatree/model/bank_detail_fetch_model.dart';
import 'package:plantatree/model/bank_detail_page_model.dart';
import 'package:plantatree/model/bank_detail_update_model.dart';
import 'package:plantatree/widget/add_bank-details.dart';
import 'package:plantatree/widget/add_info_box.dart';
import 'package:plantatree/widget/appbar.dart';
import 'package:plantatree/widget/bank_detail_box.dart';
import 'package:plantatree/widget/loading.dart';
import 'package:plantatree/widget/textbox_widget.dart';

class BankDetailscreen extends StatefulWidget {
  const BankDetailscreen({super.key});

  @override
  State<BankDetailscreen> createState() => _BankDetailscreenState();
}

class _BankDetailscreenState extends State<BankDetailscreen> {
  bool isloading = true; // change to false

  TextEditingController banknameController = TextEditingController();
  TextEditingController accountnameController = TextEditingController();
  TextEditingController accountnumberController = TextEditingController();
  TextEditingController branchController = TextEditingController();
  TextEditingController ifscController = TextEditingController();
  final Bankusercontroller _bankusercontroller = Bankusercontroller();
  List<DataList> dataList = [];

  bool fristloading = false;
  bool dataloading = true;
  String? id;

  Future<void> updatepostData(String id) async {
    if (banknameController.text.isNotEmpty &&
        accountnameController.text.isNotEmpty &&
        accountnumberController.text.isNotEmpty &&
        branchController.text.isNotEmpty &&
        ifscController.text.isNotEmpty) {
      final user = BankDetailUpdateModel(
          branch: branchController.text,
          accountName: accountnameController.text,
          accountNo: accountnumberController.text,
          ifsc: ifscController.text,
          bankName: banknameController.text,
          id: id);
      final statuscode =
          await _bankusercontroller.updatepostData(user, context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Center(
            child: GoogleFont(
          text: "Please Enter All Datils",
          fontSize: 16,
          fontWeight: FontWeight.w500,
        )),
      ));
    }
  }

  Future<void> postData() async {
    if (banknameController.text.isNotEmpty &&
        accountnameController.text.isNotEmpty &&
        accountnumberController.text.isNotEmpty &&
        branchController.text.isNotEmpty &&
        ifscController.text.isNotEmpty) {
      try {
        final user = BankDetailPageModel(
            branch: branchController.text,
            accountName: accountnameController.text,
            accountNo: accountnumberController.text,
            ifsc: ifscController.text,
            bankName: banknameController.text);
        final statuscode = await _bankusercontroller.postData(context, user);
        if (statuscode == 200) {
          fetchData();
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Center(
              child: GoogleFont(
            text: "Error :${(e)}",
            fontSize: 16,
            fontWeight: FontWeight.w500,
          )),
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Center(
            child: GoogleFont(
          text: "Please Enter All Datils",
          fontSize: 16,
          fontWeight: FontWeight.w500,
        )),
      ));
    }
  }

  Future<void> fetchData() async {
    final statuscode = await _bankusercontroller.fetchData();
    setState(() {
      fristloading = true;
    });
    try {
      if (statuscode != null) {
        setState(() {
          if (statuscode.status == true && statuscode.dataList.isNotEmpty) {
            dataList = statuscode.dataList;
            dataloading = true;
            id = statuscode.dataList[0].id;
            banknameController.text = statuscode.dataList[0].bankName;
            banknameController.text = statuscode.dataList[0].bankName;
            accountnameController.text = statuscode.dataList[0].accountName;
            accountnumberController.text = statuscode.dataList[0].accountNo;
            branchController.text = statuscode.dataList[0].branch;
            ifscController.text = statuscode.dataList[0].ifsc;
          } else {
            dataloading = false;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Center(
                  child: GoogleFont(
                text: statuscode.message,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              )),
            ));
          }
        });
      }
    } catch (e) {
      print("error");
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
      body: Column(
        children: [
          fristloading
              ? Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 7.3,
                          ),
                          dataloading && dataList.isNotEmpty
                              ? GestureDetector(
                                  onTap: () {
                                    AddInfoBox.showCustomDialog(
                                      obscureText1: false,
                                      obscureText2: false,
                                      obscureText3: false,
                                      obscureText4: false,
                                      obscureText5: false,
                                      context: context,
                                      onConfirmed: () {
                                        updatepostData(id!);
                                        Navigator.of(context).pop("refresh");
                                      },
                                      onCancel: () {
                                        Navigator.of(context).pop();
                                      },
                                      confirmbutton: 'Submit',
                                      cancelbutton: 'Cancel',
                                      title: "Bank Details",
                                      hight:
                                          MediaQuery.of(context).size.height /
                                              14,
                                      hight1:
                                          MediaQuery.of(context).size.height /
                                              14,
                                      hight2:
                                          MediaQuery.of(context).size.height /
                                              14,
                                      hight3:
                                          MediaQuery.of(context).size.height /
                                              14,
                                      hight4:
                                          MediaQuery.of(context).size.height /
                                              14,
                                      title1: "Account Number",
                                      accountnoinputFormatters: [
                                        LengthLimitingTextInputFormatter(16),
                                      ],
                                      banknameController1:
                                          accountnumberController,
                                      title2: "Account Name",
                                      banknameController2:
                                          accountnameController,
                                      title3: "Bank Name",
                                      banknameController3: banknameController,
                                      title4: "IFSC",
                                      banknameController4: ifscController,
                                      title5: "Branch",
                                      banknameController5: branchController,
                                      inputboxno: 5,
                                    );
                                  },
                                  child: DetailBox(
                                    bankname: dataList[0].bankName,
                                    ifsc: dataList[0].ifsc,
                                    branch: dataList[0].branch,
                                    accountname: dataList[0].accountName,
                                    accountnumber: dataList[0].accountNo,
                                  ),
                                )
                              : AddBankDetailBox(
                                  onTap: () {
                                    AddInfoBox.showCustomDialog(
                                      obscureText1: false,
                                      obscureText2: false,
                                      obscureText3: false,
                                      obscureText4: false,
                                      obscureText5: false,
                                      context: context,
                                      onConfirmed: () {
                                        postData();
                                        Navigator.of(context).pop("refresh");
                                      },
                                      onCancel: () {
                                        banknameController.text = '';
                                        accountnameController.text = "";
                                        accountnumberController.text = '';
                                        branchController.text = '';
                                        ifscController.text = '';
                                        Navigator.of(context).pop();
                                      },
                                      confirmbutton: 'Submit',
                                      cancelbutton: 'Cancel',
                                      title: "Bank Details",
                                      hight:
                                          MediaQuery.of(context).size.height /
                                              14,
                                      hight1:
                                          MediaQuery.of(context).size.height /
                                              14,
                                      hight2:
                                          MediaQuery.of(context).size.height /
                                              14,
                                      hight3:
                                          MediaQuery.of(context).size.height /
                                              14,
                                      hight4:
                                          MediaQuery.of(context).size.height /
                                              14,
                                      title1: "Account Number",
                                      accountnoinputFormatters: [
                                        LengthLimitingTextInputFormatter(16),
                                      ],
                                      banknameController1:
                                          accountnumberController,
                                      title2: "Account Name",
                                      banknameController2:
                                          accountnameController,
                                      title3: "Bank Name",
                                      banknameController3: banknameController,
                                      title4: "IFSC",
                                      banknameController4: ifscController,
                                      title5: "Branch",
                                      banknameController5: branchController,
                                      inputboxno: 5,
                                    );
                                  },
                                  color: Colors.grey,
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                  text: "+AddBank",
                                ),
                        ],
                      ),
                    ),
                    Appbar(
                      headingtext: 'Bank Details',
                    ),
                  ],
                )
              : Loadingwidget(color: Colors.green, size: 40),
        ],
      ),
    );
  }
}

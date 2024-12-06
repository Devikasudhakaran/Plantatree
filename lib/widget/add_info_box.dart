import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plantatree/widget/textbox_widget.dart';
import 'package:plantatree/widget/textfields.dart';

class AddInfoBox {
  static Future<void> showCustomDialog({
    TextEditingController? banknameController1,
    TextEditingController? banknameController2,
    TextEditingController? banknameController3,
    TextEditingController? banknameController4,
    TextEditingController? banknameController5,
    List<TextInputFormatter>? accountnoinputFormatters,
    List<TextInputFormatter>? phonenumberlimiter,
    required BuildContext context,
    required int inputboxno,
    String? title,
    String? title1,
    required bool obscureText1,
    required bool obscureText2,
    required bool obscureText3,
    required bool obscureText4,
    required bool obscureText5,
    String? title2,
    String? title3,
    String? title4,
    String? title5,
    String? hintText1,
    String? hintText2,
    String? hintText3,
    String? hintText4,
    String? hintText5,
    double? hight,
    double? hight1,
    double? hight2,
    double? hight3,
    double? hight4,
    required VoidCallback onConfirmed,
    required VoidCallback onCancel,
    required String confirmbutton,
    required String cancelbutton,
  }) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              const SizedBox(height: 10),
              GoogleFont(
                text: title,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 70,
                  ),
                  GoogleFont(
                    text: title1,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 90,
                  ),
                  Textfields(
                    controller: banknameController1,
                    hintText: hintText1,
                    hight: hight,
                    inputFormatters: accountnoinputFormatters,
                    obscureText: obscureText1,
                    width: MediaQuery.of(context).size.width,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  if (inputboxno == 2 || inputboxno >= 2 && inputboxno <= 5)
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 70,
                    ),
                  if (inputboxno == 2 || inputboxno >= 2 && inputboxno <= 5)
                    GoogleFont(
                      text: title2,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  if (inputboxno == 2 || inputboxno >= 2 && inputboxno <= 5)
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 90,
                    ),
                  if (inputboxno == 2 || inputboxno >= 2 && inputboxno <= 5)
                    Textfields(
                      controller: banknameController2,
                      hintText: hintText2,
                      hight: hight1,
                      obscureText: obscureText2,
                      width: MediaQuery.of(context).size.width,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  if (inputboxno == 3 || inputboxno >= 3 && inputboxno <= 5)
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 70,
                    ),
                  if (inputboxno == 3 || inputboxno >= 3 && inputboxno <= 5)
                    GoogleFont(
                      text: title3,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  if (inputboxno == 3 || inputboxno >= 3 && inputboxno <= 5)
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 90,
                    ),
                  if (inputboxno == 3 || inputboxno >= 3 && inputboxno <= 5)
                    Textfields(
                      controller: banknameController3,
                      hight: hight3,
                      hintText: hintText3,
                      obscureText: obscureText3,
                      inputFormatters: phonenumberlimiter,
                      width: MediaQuery.of(context).size.width,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  if (inputboxno == 4 || inputboxno >= 4 && inputboxno <= 5)
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 70,
                    ),
                  if (inputboxno == 4 || inputboxno >= 4 && inputboxno <= 5)
                    GoogleFont(
                      text: title4,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  if (inputboxno == 4 || inputboxno >= 4 && inputboxno <= 5)
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 90,
                    ),
                  if (inputboxno == 4 || inputboxno >= 4 && inputboxno <= 5)
                    Textfields(
                      controller: banknameController4,
                      hintText: hintText4,
                      obscureText: obscureText4,
                      hight: hight4,
                      width: MediaQuery.of(context).size.width,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  if (inputboxno == 5)
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 70,
                    ),
                  if (inputboxno == 5)
                    GoogleFont(
                      text: title5,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  if (inputboxno == 5)
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 90,
                    ),
                  if (inputboxno == 5)
                    Textfields(
                      controller: banknameController5,
                      hintText: hintText5,
                      hight: hight4,
                      obscureText: obscureText5,
                      width: MediaQuery.of(context).size.width,
                      borderRadius: BorderRadius.circular(12),
                    ),
                ],
              )
            ]),
          ),
          actions: <Widget>[
            Column(
              children: [
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        onConfirmed();
                      },
                      child: GoogleFont(
                        text: confirmbutton,
                        fontSize: 15,
                        color: Color(0xFF497a39),
                      ),
                    ),
                    Container(
                      width: .8,
                      height: MediaQuery.of(context).size.height / 20,
                      color: Colors.black87,
                    ),
                    TextButton(
                      onPressed: () {
                        onCancel();
                      },
                      child: GoogleFont(
                        text: cancelbutton,
                        fontSize: 15,
                        color: Color.fromARGB(255, 62, 61, 61),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

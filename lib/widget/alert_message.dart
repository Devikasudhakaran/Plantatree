import 'package:flutter/material.dart';
import 'package:plantatree/widget/textbox_widget.dart';

class Altermessage {
  static Future<void> showCustomDialog({
    required BuildContext context,
    String? title = '',
    String? message = '',
    required VoidCallback onConfirmed,
    required VoidCallback onCannel,
    String? confirmbutton = '',
    String? cannelbutton = '',
    required int confirmnavi,
    required int cannelnavi,
  }) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(height: 10),
                GoogleFont(
                  text: title!,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(height: 10),
                GoogleFont(
                  text: message!,
                  textAlign: TextAlign.center,
                  fontSize: 15,
                ),
              ],
            ),
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
                          text: confirmbutton!,
                          fontSize: 15,
                          color: Colors.blue[600]),
                    ),
                    Container(
                      width: .8,
                      height: MediaQuery.of(context).size.height / 20,
                      color: Colors.black87,
                    ),
                    TextButton(
                      onPressed: () {
                        onCannel();

                        if (cannelnavi == 2) {
                          Navigator.of(context).pop("refresh");
                          Navigator.of(context).pop("refresh");
                        } else if (confirmnavi == 1) {
                          Navigator.of(context).pop("refresh");
                        }
                      },
                      child: GoogleFont(
                          text: cannelbutton!, fontSize: 15, color: Colors.red),
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

import 'package:flutter/material.dart';
import 'package:plantatree/widget/textbox_widget.dart';

class VerificationStatus extends StatelessWidget {
  bool verifying;
  bool verifiedornot;
  VerificationStatus(
      {super.key, required this.verifiedornot, required this.verifying});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        verifying
            ? Row(
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    size: 16,
                    color: Colors.greenAccent[600],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 90,
                  ),
                  GoogleFont(
                    text: "Verifying",
                    fontSize: 10,
                  )
                ],
              )
            : Column(
                children: [
                  verifiedornot
                      ? Row(
                          children: [
                            Icon(
                              Icons.check_circle_outline,
                              size: 16,
                              color: Colors.greenAccent[600],
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 90,
                            ),
                            GoogleFont(
                              text: "Verified",
                              fontSize: 10,
                            )
                          ],
                        )
                      : Row(
                          children: [
                            Icon(
                              Icons.check_circle_outline,
                              size: 16,
                              color: Colors.red[600],
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 90,
                            ),
                            GoogleFont(
                              text: "Rejected",
                              fontSize: 10,
                            )
                          ],
                        ),
                ],
              ),
      ],
    );
  }
}

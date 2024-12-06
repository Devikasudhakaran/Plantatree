import 'package:flutter/material.dart';
import 'package:plantatree/widget/textbox_widget.dart';

class Appbar extends StatelessWidget {
  String? headingtext;
  Appbar({super.key, required this.headingtext});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 7.7,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2), // Color of the shadow
          spreadRadius: 1, // Spread radius
          blurRadius: 2, // Blur radius
          offset: const Offset(0, 2), // Offset from the container
        ),
      ]),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                          size: 18,
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    GoogleFont(
                      text: headingtext,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    )
                  ],
                ),
                const CircleAvatar(
                  foregroundImage: AssetImage("asset/flash_screen/payment.png"),
                  radius: 18,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

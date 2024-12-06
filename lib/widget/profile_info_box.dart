import 'package:flutter/material.dart';
import 'package:plantatree/widget/textbox_widget.dart';

class ProfileInfoBox extends StatelessWidget {
  String? headtext;
  String? text2;
  String? headtext2;
  String? text3;
  String? headtext3;
  String? text4;
  String? headtext4;
  String? text5;
  Function()? onTap;
  String? headtext5;

  ProfileInfoBox(
      {super.key,
      this.headtext,
      required this.text2,
      this.text3,
      this.text4,
      required this.onTap,
      this.text5,
      this.headtext2,
      this.headtext3,
      this.headtext4,
      this.headtext5});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2), // Color of the shadow
                  spreadRadius: 1, // Spread radius
                  blurRadius: 1, // Blur radius
                  offset: const Offset(0, 1), // Offset from the container
                ),
              ]),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 90,
                    ),
                    const Icon(
                      Icons.edit_note_outlined,
                      size: 24,
                    ),
                  ],
                ),
                if (headtext != null)
                  GoogleFont(
                    text: "$headtext",
                    fontSize: 18,
                  ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (headtext2 != null)
                          GoogleFont(
                            text: headtext2,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        if (headtext3 != null)
                          GoogleFont(
                            text: headtext3,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        if (headtext4 != null)
                          GoogleFont(
                            text: headtext4,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        if (headtext5 != null)
                          GoogleFont(
                            text: headtext5,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                      ],
                    ),
                    Column(
                      children: [
                        if (headtext2 != null) GoogleFont(text: ":"),
                        if (headtext3 != null) GoogleFont(text: ":"),
                        if (headtext4 != null) GoogleFont(text: ":"),
                        if (headtext5 != null) GoogleFont(text: ":"),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (headtext2 != null)
                          GoogleFont(
                            text: "$text2",
                            fontSize: 13,
                          ),
                        if (headtext3 != null)
                          GoogleFont(
                            text: "$text3",
                            fontSize: 13,
                          ),
                        if (headtext4 != null)
                          GoogleFont(
                            text: "$text4",
                            fontSize: 13,
                          ),
                        if (headtext5 != null)
                          GoogleFont(
                            text: "$text5",
                            fontSize: 13,
                          ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

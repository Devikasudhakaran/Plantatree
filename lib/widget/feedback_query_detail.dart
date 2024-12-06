import 'package:flutter/material.dart';
import 'package:plantatree/widget/textbox_widget.dart';

class FeedbackQueryDetail extends StatelessWidget {
  String? date;
  String? description;
  String? subject;
  String? replay;
  FeedbackQueryDetail({
    super.key,
    required this.date,
    required this.description,
    required this.subject,
    required this.replay,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
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
          padding: const EdgeInsets.all(20.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Center(
              child: GoogleFont(
                text: "$subject",
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 60,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GoogleFont(
                      text: "Description :",
                      fontSize: 15,
                    ),
                    GoogleFont(
                      text: "$description",
                      fontSize: 13,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 50,
                    ),
                    GoogleFont(
                      text: "Answer :",
                      fontSize: 15,
                    ),
                    GoogleFont(
                      text: "$replay",
                      fontSize: 13,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    GoogleFont(
                      text: "$date",
                      fontSize: 13,
                    ),
                  ],
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}

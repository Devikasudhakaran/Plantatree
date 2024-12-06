import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:plantatree/widget/loading.dart';
import 'package:plantatree/widget/textbox_widget.dart';
import 'package:plantatree/widget/verification_status.dart';

class ProjectCard extends StatefulWidget {
  String imageURL;
  String Name;
  String status;
  String temperture;
  String description;

  ProjectCard(
      {super.key,
      required this.imageURL,
      required this.status,
      required this.description,
      required this.temperture,
      required this.Name});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool verifiedornot = true;
  bool verifying = true;
  @override
  Widget build(BuildContext context) {
    if (widget.status == '1') {
      setState(() {
        verifiedornot = true;
        verifying = false;
      });
    } else if (widget.status == '2') {
      setState(() {
        verifiedornot = false;
        verifying = false;
      });
    } else if (widget.status == '3') {
      setState(() {
        verifying = true;
      });
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 4,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2), // Color of the shadow
              spreadRadius: 1, // Spread radius
              blurRadius: 1, // Blur radius
              offset: const Offset(0, 1), // Offset from the container
            ),
          ]),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 180,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: widget.imageURL.isEmpty || widget.imageURL == ""
                      ? Container(
                          height: MediaQuery.of(context).size.height / 5.5,
                          width: MediaQuery.of(context).size.width / 2.5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.green[100],
                          ),
                          child: Loadingwidget(
                              color: const Color.fromARGB(255, 252, 252, 252),
                              size: 30),
                        )
                      : Container(
                          height: MediaQuery.of(context).size.height / 5.5,
                          width: MediaQuery.of(context).size.width / 2.5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.amber,
                            image: DecorationImage(
                                image: NetworkImage(
                                  widget.imageURL,
                                ),
                                fit: BoxFit.cover),
                          ),
                        ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 20, right: 20, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GoogleFont(
                        text: widget.Name.characters.take(12).toString(),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        height: MediaQuery.of(context).size.width / 4.2,
                        child: GoogleFont(
                          text: widget.description,
                          fontSize: 12,
                          maxLines: 5,
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Row(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height / 30,
                            width: MediaQuery.of(context).size.width / 6.5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.green[100],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [GoogleFont(text: widget.temperture)],
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height / 30,
                            width: MediaQuery.of(context).size.width / 5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.green[100],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Center(
                                    child: VerificationStatus(
                                      verifiedornot: verifiedornot,
                                      verifying: verifying,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

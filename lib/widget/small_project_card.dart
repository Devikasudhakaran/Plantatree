import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:plantatree/widget/loading.dart';
import 'package:plantatree/widget/textbox_widget.dart';
import 'package:plantatree/widget/verification_status.dart';

class SmallProjectCard extends StatefulWidget {
  String? imageURL;
  String? Name;
  String? status;
  SmallProjectCard({
    super.key,
    required this.imageURL,
    required this.Name,
    required this.status,
  });

  @override
  State<SmallProjectCard> createState() => _SmallProjectCardState();
}

class _SmallProjectCardState extends State<SmallProjectCard> {
  bool verifying = true;
  bool verifiedornot = true;
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
    return Scaffold(
      body: widget.imageURL == null || widget.imageURL == ""
          ? Container(
              width: MediaQuery.of(context).size.width / 2.4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: Loadingwidget(
                          color: const Color(0xFF497a39), size: 40)),
                ],
              ),
            )
          : Container(
              height: MediaQuery.of(context).size.height / 4.2,
              width: MediaQuery.of(context).size.width / 2.4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  verifiedornot
                      ? Container(
                          height: MediaQuery.of(context).size.height / 6,
                          width: MediaQuery.of(context).size.width / 2.4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color.fromARGB(255, 213, 255, 215),
                              image: DecorationImage(
                                  image: NetworkImage(
                                    widget.imageURL!,
                                  ),
                                  fit: BoxFit.cover)),
                          child: Column(
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 9,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white.withOpacity(0.6),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: GoogleFont(
                                    text: widget.Name!.characters
                                        .take(20)
                                        .toString(),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF071305),
                                    maxLines: 1,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      : Container(
                          height: MediaQuery.of(context).size.height / 5.8,
                          width: MediaQuery.of(context).size.width / 2.4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color.fromARGB(255, 213, 255, 215),
                              image: DecorationImage(
                                  image: NetworkImage(
                                    widget.imageURL!,
                                  ),
                                  fit: BoxFit.cover)),
                          child: Column(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height / 5.8,
                                width: MediaQuery.of(context).size.width / 2.4,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.green.withOpacity(0.6),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Center(
                                      child: Icon(
                                    Icons.delete,
                                    size: 50,
                                    color: Colors.white,
                                  )),
                                ),
                              )
                            ],
                          ),
                        ),
                  VerificationStatus(
                    verifiedornot: verifiedornot,
                    verifying: verifying,
                  ),
                ],
              ),
            ),
    );
  }
}

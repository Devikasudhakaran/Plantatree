import 'package:flutter/material.dart';
import 'package:plantatree/widget/textbox_widget.dart';

class DetailBox extends StatelessWidget {
  String? accountname;
  String? accountnumber;
  String? bankname;
  String? ifsc;
  String? branch;
  DetailBox({
    super.key,
    required this.bankname,
    required this.branch,
    required this.accountname,
    required this.accountnumber,
    required this.ifsc,
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
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        size: 16,
                        color: Colors.greenAccent[400],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 90,
                      ),
                      GoogleFont(
                        text: "Verified",
                        fontSize: 12,
                      )
                    ],
                  ),
                  const Icon(
                    Icons.edit_note_outlined,
                    size: 24,
                  ),
                ],
              ),
              GoogleFont(
                text: "$bankname",
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
                      GoogleFont(
                        text: "Account Number",
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                      GoogleFont(
                        text: "Account Name",
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                      GoogleFont(
                        text: "IFSC",
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                      GoogleFont(
                        text: "Branch",
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      GoogleFont(text: ":"),
                      GoogleFont(text: ":"),
                      GoogleFont(text: ":"),
                      GoogleFont(text: ":"),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GoogleFont(
                        text: "$accountnumber",
                        fontSize: 13,
                      ),
                      GoogleFont(
                        text: "$accountname",
                        fontSize: 13,
                      ),
                      GoogleFont(
                        text: "$ifsc",
                        fontSize: 13,
                      ),
                      GoogleFont(
                        text: "$branch",
                        fontSize: 13,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 40,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: GoogleFont(
                      textAlign: TextAlign.center,
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                      text:
                          "Your Bank Details Not Verified, Please Edit Your Bank Details"),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

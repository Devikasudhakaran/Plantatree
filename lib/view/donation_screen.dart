import 'package:flutter/material.dart';
import 'package:plantatree/widget/appbar.dart';
import 'package:plantatree/widget/textbox_widget.dart';

class DonationScreen extends StatefulWidget {
  const DonationScreen({super.key});

  @override
  State<DonationScreen> createState() => _DonationScreenState();
}

class _DonationScreenState extends State<DonationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      SizedBox(
        height: MediaQuery.of(context).size.height / 1.02,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 6,
                ),
                const CircleAvatar(
                  foregroundImage: AssetImage("asset/flash_screen/payment.png"),
                  radius: 100,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 30,
                ),
                GoogleFont(
                    text: 'Company',
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 50,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: GoogleFont(
                      text: 'Company dsdwds dsdsdsd dsdsdsd sdsdsdsd  eqeqe',
                      fontSize: 14,
                      textAlign: TextAlign.left,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 30,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey
                              .withOpacity(0.2), // Color of the shadow
                          spreadRadius: 3, // Spread radius
                          blurRadius: 3, // Blur radius
                          offset:
                              const Offset(0, 3), // Offset from the container
                        ),
                      ],
                      color: const Color(0xFF497a39),
                    ),
                    child: Center(
                      child: GoogleFont(
                          text: 'Donate',
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      Appbar(
        headingtext: "Company Name",
      )
    ]));
  }
}

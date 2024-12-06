import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:plantatree/view/notification_screen.dart';
import 'package:plantatree/widget/walletlist.dart';
import 'package:plantatree/widget/appbar.dart';
import 'package:plantatree/widget/textbox_widget.dart';

class WalletScren extends StatefulWidget {
  const WalletScren({super.key});

  @override
  State<WalletScren> createState() => _WalletScrenState();
}

class _WalletScrenState extends State<WalletScren> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Appbar(headingtext: "Wallet"),
          Padding(
            padding: const EdgeInsets.only(top: 20, right: 15, left: 15),
            child: Container(
              height: MediaQuery.of(context).size.height / 4,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.green,
                  image: const DecorationImage(
                    image: AssetImage(
                      "asset/wallet/leaf.png",
                    ),
                    fit: BoxFit.cover,
                  )),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GoogleFont(
                              text: "Akhil",
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 28,
                          ),
                          Row(
                            children: [
                              Container(
                                height: 45,
                                width: 65,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.green,
                                    image: const DecorationImage(
                                      image: AssetImage(
                                        "asset/wallet/sim.png",
                                      ),
                                      fit: BoxFit.fill,
                                    )),
                              ),
                              Container(
                                height: 35,
                                width: 45,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.green,
                                    image: const DecorationImage(
                                      image: AssetImage(
                                        "asset/wallet/wifi.png",
                                      ),
                                      fit: BoxFit.fill,
                                    )),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          GoogleFont(
                              text: "Total balance",
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                          Row(
                            children: [
                              SizedBox(
                                  height: 15,
                                  width: 15,
                                  child: Image.asset(
                                    "asset/icons/25473.png",
                                    color: Colors.white,
                                  )),
                              GoogleFont(
                                  text: " 2000",
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 35,
                                width: 120,
                                color: Colors.white,
                              ),
                              Container(
                                height: 30,
                                width: 120,
                                color: Colors.green.shade800,
                                child: Center(
                                  child: GoogleFont(
                                      text: "PLANT A TREE",
                                      fontSize: 15,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                          GoogleFont(
                              text: "VISA",
                              fontSize: 26,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w900,
                              color: Colors.white),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xFFf8f8f8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GoogleFont(
                          text: "History",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF071305),
                        ),
                        GoogleFont(
                          text: "See all",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF071305),
                        ),
                      ],
                    ),
                    SizedBox(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return const Walletlist();
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    ));
    // ); /
  }
}

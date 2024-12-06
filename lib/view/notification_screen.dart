import 'package:flutter/material.dart';
import 'package:plantatree/widget/textbox_widget.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      SizedBox(
        height: MediaQuery.of(context).size.height / 1.02,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 9.5,
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                clipBehavior: Clip.none,
                itemCount: 15,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GoogleFont(
                                text: "Hello",
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                            const SizedBox(
                              height: 1,
                            ),
                            GoogleFont(
                                text:
                                    "You did greate job uygsd hdshdsudu  usu hsdhsdhs shdsdusd sdhsihdisd",
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                                color: Colors.black),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 105,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2), // Color of the shadow
                spreadRadius: 3, // Spread radius
                blurRadius: 3, // Blur radius
                offset: const Offset(0, 3), // Offset from the container
              ),
            ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    right: 15,
                    left: 15,
                    bottom: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Icon(Icons.arrow_back_ios)),
                            const SizedBox(
                              width: 10,
                            ),
                            GoogleFont(
                                text: "Notifications",
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                          ],
                        ),
                      ),
                      const CircleAvatar(
                        foregroundImage:
                            AssetImage("asset/flash_screen/payment.png"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ]));
  }
}

import 'package:flutter/material.dart';
import 'package:plantatree/widget/textbox_widget.dart';

class Walletlist extends StatelessWidget {
  const Walletlist({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GoogleFont(
                  text: "Money Plant",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF071305)),
              GoogleFont(
                  text: "INR 200",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF071305)),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            thickness: 1,
            color: Color.fromARGB(255, 173, 173, 173),
          ),
        ],
      ),
    );
  }
}

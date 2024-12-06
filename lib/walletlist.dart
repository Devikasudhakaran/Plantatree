import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Walletlist extends StatelessWidget {
  const Walletlist({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Money Plant",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF071305)),
              ),
              Text(
                "INR 200",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF071305)),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            thickness: 1,
            color: const Color.fromARGB(255, 173, 173, 173),
          ),
        ],
      ),
    );
  }
}

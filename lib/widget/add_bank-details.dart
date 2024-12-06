import 'package:flutter/material.dart';
import 'package:plantatree/widget/textbox_widget.dart';

class AddBankDetailBox extends StatelessWidget {
  String? text;
  void Function()? onTap;
  double? fontSize;
  FontWeight? fontWeight;
  Color? color;

  AddBankDetailBox(
      {super.key,
      required this.text,
      required this.onTap,
      this.color,
      this.fontSize,
      this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 3,
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
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Center(
                    child: GoogleFont(
                  text: "$text",
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                  color: color,
                )),
              ),
            )),
      ),
    );
  }
}

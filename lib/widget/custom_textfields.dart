import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextfields extends StatelessWidget {
  double? height;
  double? width;
  TextEditingController? controller;
  Widget? suffixIcon;
  bool obscureText;
  int? maxLength;
  CustomTextfields(
      {super.key,
      required this.controller,
      this.height,
      this.width,
      required this.obscureText,
      this.maxLength,
      this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 5),
          child: TextField(
            style: GoogleFonts.poppins(),
            controller: controller,
            obscureText: obscureText,
            maxLength: maxLength,
            decoration: InputDecoration(
                suffixIcon: suffixIcon,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                )),
          ),
        ),
      ),
    );
  }
}

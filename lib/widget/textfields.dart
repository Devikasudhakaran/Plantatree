import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class Textfields extends StatelessWidget {
  double? width;
  double? hight;
  Color? color;
  String? hintText;
  int? minLines;
  int? maxLines;
  bool obscureText;
  TextInputType? keyboardType;
  TextEditingController? controller;
  BorderRadiusGeometry? borderRadius;
  List<TextInputFormatter>? inputFormatters;
  Textfields(
      {super.key,
      required this.controller,
      this.borderRadius,
      this.keyboardType,
      required this.obscureText,
      this.color,
      this.hight,
      this.hintText,
      this.inputFormatters,
      this.maxLines,
      this.minLines,
      this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: hight,
      decoration: BoxDecoration(
          color: color,
          borderRadius: borderRadius,
          border: Border.all(color: Colors.grey)),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 5,
          ),
          child: Center(
            child: TextField(
              obscureText: obscureText,
              style: GoogleFonts.poppins(),
              minLines: obscureText ? 1 : minLines,
              maxLines: obscureText ? 1 : maxLines,
              controller: controller,
              keyboardType: keyboardType,
              inputFormatters: inputFormatters,
              decoration: InputDecoration(
                hintText: hintText,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

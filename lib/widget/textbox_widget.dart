import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GoogleFont extends StatelessWidget {
  FontWeight? fontWeight;
  Color? color;
  double? fontSize;
  String? text;
  int? maxLines;
  FontStyle? fontStyle;
  TextAlign? textAlign;
  GoogleFont(
      {super.key,
      this.textAlign,
      this.fontSize,
      this.fontStyle,
      this.fontWeight,
      required this.text,
      this.maxLines,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      "$text",
      textAlign: textAlign,
      maxLines: maxLines,
      style: GoogleFonts.poppins(
        fontStyle: fontStyle,
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}

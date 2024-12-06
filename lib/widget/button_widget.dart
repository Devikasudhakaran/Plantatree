import 'package:flutter/material.dart';
import 'package:plantatree/widget/loading.dart';
import 'package:plantatree/widget/textbox_widget.dart';

class ButtonWidget extends StatefulWidget {
  void Function()? onTap;
  double? width;
  double? hight;
  bool isloading;
  String text;
  ButtonWidget(
      {super.key,
      required this.onTap,
      required this.isloading,
      required this.text,
      this.hight,
      this.width});

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: widget.onTap,
        child: Container(
          width: widget.width,
          height: widget.hight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2), // Color of the shadow
                spreadRadius: 3, // Spread radius
                blurRadius: 3, // Blur radius
                offset: const Offset(0, 3), // Offset from the container
              ),
            ],
            color: const Color(0xFF497a39),
          ),
          child: Center(
              child: widget.isloading
                  ? Loadingwidget(
                      color: Colors.white,
                      size: 20,
                    )
                  : GoogleFont(
                      text: widget.text,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    )),
        ));
  }
}

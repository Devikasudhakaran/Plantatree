import 'package:flutter/material.dart';

class profileimagecarousel extends StatefulWidget {
  String? imageUrl;
  String? imageId;
  profileimagecarousel(
      {super.key, required this.imageUrl, required this.imageId});

  @override
  State<profileimagecarousel> createState() => _profileimagecarouselState();
}

class _profileimagecarouselState extends State<profileimagecarousel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2,
      decoration: BoxDecoration(
          color: const Color(0xFF497a39),
          image: DecorationImage(
              image: NetworkImage(widget.imageUrl!), fit: BoxFit.fill),
          borderRadius: const BorderRadius.only(
              // bottomLeft: Radius.circular(50),
              )),
    );
  }
}

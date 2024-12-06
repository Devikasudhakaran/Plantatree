import 'package:flutter/material.dart';

// ignore: camel_case_types
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
          color: Colors.amber,
          image: DecorationImage(
              image: NetworkImage(widget.imageUrl!), fit: BoxFit.fill),
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50))),
    );
  }
}

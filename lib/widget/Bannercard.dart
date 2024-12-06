import 'package:flutter/material.dart';

class Bannercard extends StatefulWidget {
  String imageUrl = "";
  Bannercard({super.key, required this.imageUrl});

  @override
  State<Bannercard> createState() => _BannercardState();
}

class _BannercardState extends State<Bannercard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 3,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2), // Color of the shadow
              spreadRadius: 1, // Spread radius
              blurRadius: 1, // Blur radius
              offset: const Offset(-1, 0), // Offset from the container
            ),
          ],
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(50), bottomRight: Radius.circular(50)),
          image: DecorationImage(
              image: NetworkImage(
                widget.imageUrl,
              ),
              fit: BoxFit.cover)),
    );
  }
}

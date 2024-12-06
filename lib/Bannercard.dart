import 'package:flutter/cupertino.dart';

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
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              image: NetworkImage(
                widget.imageUrl,
              ),
              fit: BoxFit.cover)),
    );
  }
}

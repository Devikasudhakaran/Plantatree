import 'package:flutter/material.dart';
import 'package:plantatree/widget/textbox_widget.dart';

class ProjectCards extends StatelessWidget {
  String? imageUrl;
  String? Name;
  ProjectCards({super.key, required this.imageUrl, required this.Name});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2.4,
      height: MediaQuery.of(context).size.height / 7,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          image: DecorationImage(
              image: NetworkImage(
                imageUrl!,
              ),
              fit: BoxFit.cover)),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 7,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white.withOpacity(0.6),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GoogleFont(
                text: Name!.characters.take(20).toString(),
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: Color(0xFF071305),
                maxLines: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProjectCardsIcon extends StatelessWidget {
  String? Name;
  ProjectCardsIcon({super.key, required this.Name});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 5,
            width: MediaQuery.of(context).size.width / 2.4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(0xFF497a39),
            ),
            child: Center(
              child: Stack(
                children: [
                  Center(
                      child: Column(
                    children: [
                      // Icon(Icons.add_circle_outline,color: Colors.white,size: 120,),
                      Container(
                        height: MediaQuery.of(context).size.height / 5,
                        width: MediaQuery.of(context).size.width / 2.4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: const DecorationImage(
                              image: AssetImage(
                                "asset/flash_screen/plant.jpg",
                              ),
                              fit: BoxFit.cover,
                            )),
                      ),
                    ],
                  )),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white.withOpacity(0.6),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GoogleFont(
                                text: Name!,
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF071305),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProjectCards extends StatelessWidget {
  String? imageUrl;
  String? Name;
  ProjectCards({super.key, required this.imageUrl, required this.Name});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2.4,
      height: 250,
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
            height: 120,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white.withOpacity(0.6),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                Name!.characters.take(10).toString(),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF071305),
                ),
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
            height: MediaQuery.of(context).size.height / 4.5,
            width: MediaQuery.of(context).size.width / 2.4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color.fromARGB(255, 81, 222, 52),
            ),
            child: Center(
              child: Stack(
                children: [
                  Center(
                      child: Column(
                    children: [
                      // Icon(Icons.add_circle_outline,color: Colors.white,size: 120,),
                      Container(
                        height: MediaQuery.of(context).size.height / 4.5,
                        width: MediaQuery.of(context).size.width / 2.4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
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
                              child: Text(
                                Name!,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF071305)),
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

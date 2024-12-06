import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ProjectCard extends StatefulWidget {
  String? imageURL;
  String? Name;
  ProjectCard({super.key, required this.imageURL, required this.Name});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.imageURL == null || widget.imageURL == ""
          ? Container(
              height: MediaQuery.of(context).size.height / 4.5,
              width: MediaQuery.of(context).size.width / 2.4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color.fromARGB(255, 213, 255, 215),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: LoadingAnimationWidget.fourRotatingDots(
                        color: const Color.fromARGB(255, 115, 230, 119),
                        size: 40),
                  ),
                ],
              ),
            )
          : Container(
              height: MediaQuery.of(context).size.height / 4.5,
              width: MediaQuery.of(context).size.width / 2.4,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromARGB(255, 213, 255, 215),
                  image: DecorationImage(
                      image: NetworkImage(
                        widget.imageURL!,
                      ),
                      fit: BoxFit.cover)),
              child: Column(
                children: [
                  SizedBox(
                    height: 120,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white.withOpacity(0.6),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        widget.Name!.characters.take(10).toString(),
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
            ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:plantatree/widget/textbox_widget.dart';

class SingleProjectUpdate extends StatelessWidget {
  Function()? onTap;

  SingleProjectUpdate({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2), // Color of the shadow
                  spreadRadius: 1, // Spread radius
                  blurRadius: 1, // Blur radius
                  offset: const Offset(0, 1), // Offset from the container
                ),
              ]),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                        onTap: () {},
                        child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.green[700],
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ))),
                    GestureDetector(
                        onTap: () {},
                        child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.green[700],
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ))),
                    GestureDetector(
                        onTap: () {},
                        child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.green[700],
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ))),
                    GestureDetector(
                        onTap: () {},
                        child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.green[700],
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                            )))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, right: 30, left: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GoogleFont(
                        text: "discripton",
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                      GestureDetector(
                          onTap: () {},
                          child: Container(
                              width: 80,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.green[700],
                              ),
                              child: Center(
                                child: GoogleFont(
                                  text: "Update",
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                ),
                              ))),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

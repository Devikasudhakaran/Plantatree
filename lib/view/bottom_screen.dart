import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plantatree/view/home_screen.dart';
import 'package:plantatree/view/profile_screen.dart';
import 'package:plantatree/view/all_projects_screen.dart';
import 'package:plantatree/widget/textbox_widget.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class Bottomnavbar extends StatefulWidget {
  const Bottomnavbar({super.key});

  @override
  State<Bottomnavbar> createState() => _BottomnavbarState();
}

class _BottomnavbarState extends State<Bottomnavbar> {
  int index = 0;
  bool heart = false;
  var page = [
    const HomeScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: StylishBottomBar(
        option: AnimatedBarOptions(
          padding: const EdgeInsets.all(10),
          iconSize: 24,
          barAnimation: BarAnimation.blink,
          iconStyle: IconStyle.animated,
          // opacity: 0.3,
        ),
        items: [
          BottomBarItem(
              icon: const Icon(
                Icons.home,
                color: Color(0xFF497a39),
              ),
              selectedColor: const Color(0xFF497a39),
              // unSelectedColor: Colors.purple,
              // backgroundColor: Colors.orange,
              title: GoogleFont(
                text: 'Home',
                fontSize: 16,
                fontWeight: FontWeight.w500,
              )),
          BottomBarItem(
              icon: const Icon(
                Icons.person,
                color: Color(0xFF497a39),
              ),
              selectedColor: const Color(0xFF497a39),
              unSelectedColor: Colors.grey,
              // backgroundColor: Colors.orange,
              title: GoogleFont(
                text: 'Profile',
                fontSize: 16,
                fontWeight: FontWeight.w500,
              )),
        ],
        hasNotch: true,
        currentIndex: index,
        notchStyle: NotchStyle.circle,
        onTap: (index) {
          setState(() {
            this.index = index;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          setState(() {
            heart = !heart;

            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ProjectsScreen()));
          });
        },
        backgroundColor: Colors.white,
        child: const Icon(
          CupertinoIcons.add,
          color: Color(0xFF497a39),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: page[index],
    );
  }
}

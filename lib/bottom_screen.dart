import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:plantatree/home_screen.dart';
import 'package:plantatree/profile_screen.dart';
import 'package:plantatree/projects_screen.dart';
import 'package:plantatree/wallet_screen.dart';

class Bottomnavbar extends StatefulWidget {
  const Bottomnavbar({super.key});

  @override
  State<Bottomnavbar> createState() => _BottomnavbarState();
}

class _BottomnavbarState extends State<Bottomnavbar> {
  int index = 0;
  var page = [
    const HomeScreen(),
    const ProjectsScreen(),
    const WalletScren(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: const Color(0xFF40cd25),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: GNav(
            selectedIndex: index,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            onTabChange: (index) {
              setState(() {
                this.index = index;
              });
            },
            gap: 8,
            tabBackgroundColor: const Color.fromARGB(255, 111, 220, 89),
            backgroundColor: const Color(0xFF40cd25),
            tabs: const [
              GButton(
                icon: Icons.home,
                iconActiveColor: Colors.white,
                iconColor: Colors.white,
                text: "Home",
                textColor: Colors.white,
              ),
              GButton(
                icon: Icons.task_outlined,
                iconActiveColor: Colors.white,
                iconColor: Colors.white,
                text: "Projects",
                textColor: Colors.white,
              ),
              GButton(
                icon: Icons.wallet,
                iconActiveColor: Colors.white,
                iconColor: Colors.white,
                text: "Wallet",
                textColor: Colors.white,
              ),
              GButton(
                icon: Icons.person,
                iconActiveColor: Colors.white,
                iconColor: Colors.white,
                text: "Profile",
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
      body: page[index],
    );
  }
}

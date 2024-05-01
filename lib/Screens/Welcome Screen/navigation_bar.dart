import 'package:flutter/material.dart';
import 'package:rk_learning/Constants/colors.dart';
import 'package:rk_learning/Screens/Welcome%20Screen/welcome_screen.dart';
import 'package:rk_learning/Screens/course_screen.dart';
import 'package:rk_learning/Screens/test_screen.dart';
import 'package:rk_learning/Screens/whatsapp_screen.dart';

class NavigationBarScreen extends StatefulWidget {
  const NavigationBarScreen({super.key});

  @override
  State<NavigationBarScreen> createState() => _NavigationBarScreenState();
}

class _NavigationBarScreenState extends State<NavigationBarScreen> {
  int myCurrentIndex = 0;

  List pages = [
    const WelcomeScreen(),
    const CourseScreen(),
    const TestScreen(),
    const WhatsAppScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(
              color: primaryContainerColor,
              blurRadius: 10,
              spreadRadius: 0.1,
              offset: Offset(0, 0),
            ),
            BoxShadow(
              color: Colors.white,
              blurRadius: 20,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BottomNavigationBar(
            selectedLabelStyle: const TextStyle(color: Colors.black),
            currentIndex: myCurrentIndex,
            onTap: (index) {
              setState(() {
                myCurrentIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/icons/course.png",
                  scale: 15,
                ),
                label: "Courses",
              ),
              BottomNavigationBarItem(
                icon: Image.asset("assets/icons/test.png", scale: 15),
                label: "Tests",
              ),
              BottomNavigationBarItem(
                icon:
                    Image.asset("assets/icons/community_filled.png", scale: 15),
                label: "Community",
              ),
              BottomNavigationBarItem(
                icon: Image.asset("assets/icons/whatsapp.png", scale: 15),
                label: "WhatsApp Us",
              ),
            ],
          ),
        ),
      ),
      body: pages[myCurrentIndex],
    );
  }
}

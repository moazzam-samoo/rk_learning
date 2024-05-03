import 'package:flutter/material.dart';
import 'package:rk_learning/Constants/responsive_screen.dart';
import 'package:rk_learning/Screens/Welcome%20Screen/Conopnents%20Of%20WelcomeScreen/components_of_welcomescreen.dart';
import 'package:rk_learning/Widgets/build_screens_tabBar.dart';
import 'package:rk_learning/Widgets/build_widgets.dart';
import 'package:rk_learning/Widgets/custom_drawer.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 4, vsync: this);
    double height = (MediaQuery.of(context).size.height);
    return Scaffold(
      drawer: const CustomDrawer(),
      body: Container(
        margin: EdgeInsets.symmetric(
          vertical: ResponsiveScreen.height(context) * 0.06,
          horizontal: ResponsiveScreen.width(context) * 0.04,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildProfilePicAndName(context),
            SizedBox(height: height * 0.01),
            buildTabBar(tabController),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  courseScreen(),
                  testScreen(),
                  notificationScreen(),
                  contactScreen(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rk_learning/Constants/responsive_screen.dart';
import 'package:rk_learning/Screens/Welcome%20Screen/Conopnents%20Of%20WelcomeScreen/components_of_welcomescreen.dart';
import 'package:rk_learning/Widgets/build_screens_tabBar.dart';
import 'package:rk_learning/Widgets/build_widgets.dart';
import 'package:rk_learning/Widgets/custom_drawer.dart';

import '../../Widgets/navigate_links_to_other_platform.dart';

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
                  Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 30.h, horizontal: 15.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            contactButton(context, "WhatsApp Us", "whatsapp",
                                onTab: () {
                              whatsAppLaunchUrl();
                            }),
                            contactButton(context, "Instagram", "instagram",
                                onTab: () {
                              instagramLaunchUrl();
                            }),
                          ],
                        ),
                        SizedBox(
                          height: 50.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            contactButton(context, "Facebook", "facebook",
                                onTab: () {
                              facebookLaunchUrl();
                            }),
                            contactButton(context, "YouTube", "youtube",
                                onTab: () {
                              youTubeLaunchUrl();
                            }),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

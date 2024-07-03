import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rk_learning/Constants/colors.dart';
import 'package:rk_learning/Constants/responsive_screen.dart';
import 'package:rk_learning/Screens/Welcome%20Screen/Conopnents%20Of%20WelcomeScreen/components_of_welcomescreen.dart';
import 'package:rk_learning/Widgets/custom_drawer.dart';
import 'package:rk_learning/Widgets/reuseable_widgets.dart';
import 'package:rk_learning/Widgets/tabbar_screens_.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  TextEditingController test = TextEditingController();
  TextEditingController inter = TextEditingController();
  TextEditingController matriculation = TextEditingController();
  int index = 0;
  @override
  void initState() {
    super.initState();
    test = TextEditingController();
    inter = TextEditingController();
    matriculation = TextEditingController();
  }

  @override
  void dispose() {
    test.dispose();
    inter.dispose();
    matriculation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false; // Disable back button
      },
      child: Scaffold(
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
              SizedBox(
                height: ResponsiveScreen.height(context) * 0.03,
              ),
              SizedBox(
                height: ResponsiveScreen.height(context) * 0.06,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    buildCourseButton(ResponsiveScreen.width(context) - 100),
                    buildCpnButton(ResponsiveScreen.width(context) - 150),
                    buildNotificationButton(
                        ResponsiveScreen.width(context) - 70),
                    buildContactButton(ResponsiveScreen.width(context) - 120),
                  ],
                ),
              ),
              SizedBox(height: ResponsiveScreen.height(context) * 0.02),
              index == 0
                  ? reuseText("Choose Your Course", 20, FontWeight.normal,
                      primaryTextColor)
                  : index == 1
                      ? reuseText("", 20, FontWeight.normal, primaryTextColor)
                      : index == 2
                          ? reuseText("Notifications", 20, FontWeight.normal,
                              primaryTextColor)
                          : reuseText("Contact Us", 20, FontWeight.normal,
                              primaryTextColor),

              index == 0
                  ? Expanded(child: courseScreen())
                  : index == 1
                      ? Expanded(
                          child: cpnCalculator(
                              test, inter, matriculation, context, () {
                          double testMarks = double.tryParse(test.text) ?? 0;
                          double interPercentage =
                              double.tryParse(inter.text) ?? 0;
                          double matricPercentage =
                              double.tryParse(matriculation.text) ?? 0;
                          double cpn = calculateCPN(
                              testMarks, interPercentage, matricPercentage);
                          // Display the result in a dialog
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: shadowColor,
                                  title: const Text(
                                    "CPN Result",
                                    style: TextStyle(color: primaryTextColor),
                                  ),
                                  content: reuseText(
                                      "Your CPN is ${cpn.toStringAsFixed(2)}",
                                      14,
                                      FontWeight.normal,
                                      primaryTextColor),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text(
                                        "OK",
                                        style:
                                            TextStyle(color: primaryTextColor),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        test.clear();
                                        inter.clear();
                                        matriculation.clear();
                                      },
                                    ),
                                  ],
                                );
                              });
                        }))
                      : index == 2
                          ? Expanded(child: notificationScreen())
                          : Expanded(child: contactScreen(context))

              // buildWelcomeTabBar(tabController),
              // Expanded(
              //   child: TabBarView(
              //     controller: tabController,
              //     children: [
              //       courseScreen(),
              //       notificationScreen(),
              //       contactScreen(context),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector buildCourseButton(double width) {
    return GestureDetector(
        onTap: () {
          setState(() {
            index = 0;
          });
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 5.w),
          alignment: Alignment.center,
          height: 35.h,
          width: width * 0.35,
          decoration: BoxDecoration(
              color: index == 0 ? shadowColor : null,
              borderRadius: BorderRadius.circular(50),
              border: index != 0
                  ? Border.all(color: primaryTextColor, width: 3)
                  : null),
          child: reuseText("Course", 14, FontWeight.bold, primaryTextColor),
        ));
  }

  GestureDetector buildCpnButton(double width) {
    return GestureDetector(
        onTap: () {
          setState(() {
            index = 1;
          });
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 5.w),
          alignment: Alignment.center,
          height: 35.h,
          width: width * 0.35,
          decoration: BoxDecoration(
              color: index == 1 ? shadowColor : null,
              borderRadius: BorderRadius.circular(50),
              border: index != 1
                  ? Border.all(color: primaryTextColor, width: 3)
                  : null),
          child: reuseText("CPN", 14, FontWeight.bold, primaryTextColor),
        ));
  }

  GestureDetector buildNotificationButton(double width) {
    return GestureDetector(
        onTap: () {
          setState(() {
            index = 2;
          });
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 5.w),
          alignment: Alignment.center,
          height: 35.h,
          width: width * 0.35,
          decoration: BoxDecoration(
              color: index == 2 ? shadowColor : null,
              borderRadius: BorderRadius.circular(50),
              border: index != 2
                  ? Border.all(color: primaryTextColor, width: 3)
                  : null),
          child:
              reuseText("Notification", 14, FontWeight.bold, primaryTextColor),
        ));
  }

  GestureDetector buildContactButton(double width) {
    return GestureDetector(
        onTap: () {
          setState(() {
            index = 3;
          });
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 5.w),
          alignment: Alignment.center,
          height: 35.h,
          width: width * 0.35,
          decoration: BoxDecoration(
              color: index == 3 ? shadowColor : null,
              borderRadius: BorderRadius.circular(50),
              border: index != 3
                  ? Border.all(color: primaryTextColor, width: 3)
                  : null),
          child: reuseText("Contact", 14, FontWeight.bold, primaryTextColor),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rk_learning/Constants/colors.dart';
import 'package:rk_learning/Constants/responsive_screen.dart';
import 'package:rk_learning/Widgets/tabbar_screens_.dart';
import 'package:rk_learning/Widgets/build_widgets.dart';
import 'package:rk_learning/Widgets/reuseable_widgets.dart';

///This Screen Contains All the Data that is available in Course.
///Course Data will Come's form firebase database this class will get these data.
class CourseContent extends StatefulWidget {
  final int selectedIndex;
  const CourseContent({super.key, required this.selectedIndex});

  @override
  State<CourseContent> createState() => _CourseContentState();
}

class _CourseContentState extends State<CourseContent>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);
    return Scaffold(
      backgroundColor: containerColor,
      body: Container(
        margin: EdgeInsets.only(top: ResponsiveScreen.height(context) * 0.06),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: courseContentImage(
                  context, courses[widget.selectedIndex]["image"]),
            ),
            SizedBox(
              height: 10.h,
            ),
            reuseText(
                "${courses[widget.selectedIndex]["title"]} Entry Test Preparation",
                16,
                FontWeight.w600,
                primaryTextColor),
            SizedBox(
              height: 5.h,
            ),
            reuseText("Instructor: ${courses[widget.selectedIndex]["author"]}",
                12, FontWeight.w600, primaryTextColor),
            SizedBox(
              height: 10.h,
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: firstPrimaryBg,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  border: Border(top: BorderSide(color: shadowColor, width: 3)),
                ),
                child: Column(
                  children: [
                    buildCourseContentTabBar(tabController),
                    Expanded(
                      child: TabBarView(
                        controller: tabController,
                        children: [
                          playListScreen(),
                          Center(
                            child: reuseText("MCQs", 18, FontWeight.normal,
                                primaryTextColor),
                          ),
                          Center(
                            child: reuseText("Notes", 18, FontWeight.normal,
                                primaryTextColor),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

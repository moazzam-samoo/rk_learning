import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rk_learning/Constants/colors.dart';
import 'package:rk_learning/Constants/responsive_screen.dart';
import 'package:rk_learning/Models/course_model.dart';
import 'package:rk_learning/Widgets/tabbar_screens_.dart';
import 'package:rk_learning/Widgets/build_widgets.dart';
import 'package:rk_learning/Widgets/reuseable_widgets.dart';
import '../../Database/firebase_handler.dart';

///This Screen Contains All the Data that is available in Course.
///Course Data will Come's form firebase database this class will get these data.
class CourseContent extends StatefulWidget {
  final String courseID;
  final int selectedIndex;
  final String courseTitle;
  const CourseContent(
      {super.key,
      required this.selectedIndex,
      required this.courseID,
      required this.courseTitle});

  @override
  State<CourseContent> createState() => _CourseContentState();
}

class _CourseContentState extends State<CourseContent>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);
    return StreamBuilder(
        stream: NotificationHandler.readCourse(),
        builder: (BuildContext context,
            AsyncSnapshot<List<NewCourseModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                "An error occurred while fetching Course",
                style: TextStyle(fontSize: 18, color: primaryTextColor),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "You haven't added any Course yet",
                style: TextStyle(fontSize: 18, color: primaryTextColor),
              ),
            );
          }
          snapshot.data!.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
          final courses = snapshot.data!;
          return Scaffold(
            backgroundColor: containerColor,
            body: Container(
              margin:
                  EdgeInsets.only(top: ResponsiveScreen.height(context) * 0.06),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: courseContentImage(
                        context, courses[widget.selectedIndex].image),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  reuseText(
                      textAlign: TextAlign.center,
                      "${courses[widget.selectedIndex].title} ${courses[widget.selectedIndex].subtitle}",
                      16,
                      FontWeight.w600,
                      primaryTextColor),
                  SizedBox(
                    height: 5.h,
                  ),
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
                        border: Border(
                            top: BorderSide(color: shadowColor, width: 3)),
                      ),
                      child: Column(
                        children: [
                          buildCourseContentTabBar(tabController),
                          Expanded(
                            child: TabBarView(
                              controller: tabController,
                              children: [
                                playListScreen(
                                    widget.courseID, widget.courseTitle),
                                quizScreen(widget.courseID, widget.courseTitle),
                                notesScreen(
                                    widget.courseID, widget.courseTitle),
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
        });
  }
}

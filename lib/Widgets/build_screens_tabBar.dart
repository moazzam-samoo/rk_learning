import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rk_learning/Widgets/reuseable_widgets.dart';

import '../Constants/colors.dart';
import '../Constants/responsive_screen.dart';
import 'build_widgets.dart';

courseScreen() {
  return ListView.builder(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: courses.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 5.h),
          width: ResponsiveScreen.width(context),
          height: ResponsiveScreen.height(context) * 0.18,
          decoration: BoxDecoration(
              color: containerColor,
              border: Border.all(color: shadowColor, width: 3.w),
              borderRadius: BorderRadius.circular(30)),
          child: Row(
            children: [
              courseImage(context, courses[index]["image"]),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    reuseText(courses[index]["title"], 16, FontWeight.bold,
                        primaryTextColor,
                        maxWords: 2),
                    reuseText("Entry Test Preparation", 10, FontWeight.normal,
                        primaryTextColor),
                    purchaseButton(() {}, context)
                  ],
                ),
              )
            ],
          ),
        );
      });
}

testScreen() {
  return ListView.builder(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: courses.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 5.h),
          width: ResponsiveScreen.width(context),
          height: ResponsiveScreen.height(context) * 0.10,
          decoration: BoxDecoration(
              color: containerColor,
              border: Border.all(color: shadowColor, width: 3.w),
              borderRadius: BorderRadius.circular(30)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                'assets/icons/qna.png',
                scale: 9,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  reuseText("${courses[index]["title"] + " MCQs"}", 18,
                      FontWeight.bold, primaryTextColor),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    children: [
                      reuseText("Total MCQs", 16, FontWeight.w500,
                          secondaryTextColor),
                      SizedBox(
                        width: 10.w,
                      ),
                      reuseText("${courses.length}", 16, FontWeight.w400,
                          primaryTextColor),
                    ],
                  )
                ],
              )
            ],
          ),
        );
      });
}

List<Map<String, dynamic>> courses = [
  {
    "image": "images.jpg",
    "title": "Sindh University",
    "description":
        "Sindh University is a public research university in Sindh, Pakistan."
  },
  {
    "image": "mehran.jpg",
    "title": "Mehran University",
    "description":
        "Mehran University of Engineering and Technology is a public research university in Jamshoro, Sindh, Pakistan."
  },
  {
    "image": "mehran.jpg",
    "title": "Mehran University",
    "description":
        "Mehran University of Engineering and Technology is a public research university in Jamshoro, Sindh, Pakistan."
  },
  {
    "image": "mehran.jpg",
    "title": "Mehran University",
    "description":
        "Mehran University of Engineering and Technology is a public research university in Jamshoro, Sindh, Pakistan."
  },
  {
    "image": "mehran.jpg",
    "title": "Mehran University",
    "description":
        "Mehran University of Engineering and Technology is a public research university in Jamshoro, Sindh, Pakistan."
  },
  {
    "image": "lumhs.jpg",
    "title": "LUMHS University",
    "description":
        "Liaquat University of Medical and Health Sciences is a public research university in Jamshoro, Sindh, Pakistan."
  },
  {
    "image": "gc.jpg",
    "title": "GC University",
    "description":
        "Government College University is a public research university in Faisalabad, Punjab, Pakistan."
  },
];

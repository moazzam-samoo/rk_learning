import 'package:flutter/material.dart';
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
          margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 4.w),
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
                padding: const EdgeInsets.only(top: 10),
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
          margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
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

notificationScreen() {
  return ListView.builder(
    physics: const BouncingScrollPhysics(),
    scrollDirection: Axis.vertical,
    itemCount: notifications.length,
    itemBuilder: (context, index) {
      return Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
            decoration: BoxDecoration(
                color: containerColor,
                border: Border.all(color: shadowColor, width: 3.w),
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: reuseText(notifications[index]["title"], 22,
                        FontWeight.w600, primaryTextColor,
                        maxWords: 2),
                  ),
                  const Divider(
                    thickness: 0.2,
                  ),
                  Row(
                    children: [
                      reuseText(
                          "Date:", 16, FontWeight.normal, secondaryTextColor),
                      SizedBox(
                        width: 10.w,
                      ),
                      reuseText("28-April-2024", 14, FontWeight.normal,
                          primaryTextColor),
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  reuseText(
                    notifications[index]["noti"],
                    14,
                    FontWeight.normal,
                    primaryTextColor,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          reuseText("Author", 16, FontWeight.normal,
                              secondaryTextColor),
                          reuseText(notifications[index]["author"], 16,
                              FontWeight.normal, primaryTextColor),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          reuseText("Dead Line", 16, FontWeight.normal,
                              secondaryTextColor),
                          reuseText("10:00 AM", 16, FontWeight.normal,
                              primaryTextColor),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      );
    },
  );
}

//Dummy Data for Show TODO it wll be replaced with Firebase Database Latter.
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
List<Map<String, dynamic>> notifications = [
  {
    "title": "Important Announcement",
    "author": "Dr.Yasir Arfat",
    "noti":
        "A silent forest whispers secrets in the night, Moonlight dances on the surface of the lake, Stars twinkle like diamonds in the velvet sky, A lone wolf howls, its call haunting and wild. Leaves rustle in the gentle breeze, Echoes of the past linger in the air, The river flows, a steady, timeless rhythm, Mysteries hide in the depths of the shadows."
  },
  {
    "title": "Test Schedule",
    "author": "Dr.Fida Chandio",
    "noti":
        "Mountains rise majestically towards the heavens, Birds soar on invisible currents of wind,Footsteps echo on the ancient cobblestone path,The sun sets, painting the horizon in hues of fire."
  },
  {
    "title": "RRK Menu",
    "author": "Dr.Waheed",
    "noti":
        "The sun cast a warm glow over the city, peeking through the clouds.Birds chirped happily in the treetops, a melody of nature's song. their voices like music."
  }
];

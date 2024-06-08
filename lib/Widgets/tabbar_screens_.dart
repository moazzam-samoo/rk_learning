import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:rk_learning/Models/new_course_Model.dart';
import 'package:rk_learning/Widgets/player.dart';
import 'package:rk_learning/Widgets/reuseable_widgets.dart';
import '../Constants/colors.dart';
import '../Constants/responsive_screen.dart';
import '../Database/firebase_handler.dart';
import '../Models/notification_model.dart';
import '../Screens/Course Content/course_content.dart';
import '../Screens/MCQs/mcq.dart';
import 'build_widgets.dart';
import 'navigate_links_to_other_platform.dart';

///Course Screen that its show how many courses are present,
///and just show the simple course title text etc.
courseScreen() {
  return StreamBuilder(
      stream: NotificationHandler.readCourse(),
      builder:
          (BuildContext context, AsyncSnapshot<List<NewCourseModel>> snapshot) {
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
              "Course Not Added Yet",
              style: TextStyle(fontSize: 18, color: primaryTextColor),
            ),
          );
        }
        final course = snapshot.data;
        return ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: course!.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => CourseContent(
                              selectedIndex: index,
                              courseID: course[index].id!,
                            ))),
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 4.w),
                  width: ResponsiveScreen.width(context),
                  height: ResponsiveScreen.height(context) * 0.18,
                  decoration: BoxDecoration(
                      color: containerColor,
                      border: Border.all(color: shadowColor, width: 3.w),
                      borderRadius: BorderRadius.circular(30)),
                  child: Row(
                    children: [
                      courseImage(context, course[index].image),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            reuseText(course[index].title!, 16, FontWeight.bold,
                                primaryTextColor,
                                maxWords: 2),
                            reuseText(course[index].subtitle!, 10,
                                FontWeight.normal, primaryTextColor),
                            purchaseButton(() {}, context),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            });
      });
}

///Test Screen that its show how many Tests/MCQs are present,
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

///Notification Screen that its show how many Notifications are present,
notificationScreen() {
  return StreamBuilder(
      stream: NotificationHandler.getNotifications(),
      builder: (BuildContext context,
          AsyncSnapshot<List<NotificationModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text(
              "An error occurred while fetching Notifications",
              style: TextStyle(fontSize: 18, color: primaryTextColor),
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text(
              "You haven't added any Notifications yet",
              style: TextStyle(fontSize: 18, color: primaryTextColor),
            ),
          );
        }
        final notifications = snapshot.data;
        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: notifications!.length,
          itemBuilder: (context, index) {
            final Timestamp? created = notifications[index].time;
            String formattedDate = created != null
                ? DateFormat('dd MMM yyyy').format(created.toDate())
                : '';
            return Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                  decoration: BoxDecoration(
                      color: containerColor,
                      border: Border.all(color: shadowColor, width: 3.w),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: reuseText(notifications[index].title!, 22,
                              FontWeight.w600, primaryTextColor,
                              maxWords: 2),
                        ),
                        const Divider(
                          thickness: 0.2,
                        ),
                        Row(
                          children: [
                            reuseText("Date:", 16, FontWeight.normal,
                                secondaryTextColor),
                            SizedBox(
                              width: 10.w,
                            ),
                            reuseText(formattedDate, 14, FontWeight.normal,
                                primaryTextColor),
                          ],
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        reuseText(
                          notifications[index].text!,
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
                                reuseText(notifications[index].author!, 16,
                                    FontWeight.normal, primaryTextColor),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                reuseText("Dead Line", 16, FontWeight.normal,
                                    secondaryTextColor),
                                reuseText(notifications[index].deadLine!, 16,
                                    FontWeight.normal, primaryTextColor),
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
      });
}

///Contact Screen that its show all the contacts when user click
///any contact it will navigate user to that platform
contactScreen(BuildContext context) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 30.h, horizontal: 15.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            contactButton(context, "WhatsApp Us", "whatsapp", onTab: () {
              whatsAppLaunchUrl();
            }),
            contactButton(context, "Instagram", "instagram", onTab: () {
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
            contactButton(context, "Facebook", "facebook", onTab: () {
              facebookLaunchUrl();
            }),
            contactButton(context, "YouTube", "youtube", onTab: () {
              youTubeLaunchUrl();
            }),
          ],
        )
      ],
    ),
  );
}

playListScreen(
  String courseID,
) {
  return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('course')
          .doc(courseID)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text(
              "An error occurred while fetching Playlist",
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          );
        } else if (!snapshot.hasData) {
          return const Center(
            child: Text(
              "You haven't added any Lessons yet",
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          );
        }
        var playlist = snapshot.data?.get("playlist") as List?;
        if (playlist == null || playlist.isEmpty) {
          return const Center(
            child: Text("No lessons added yet",
                style: TextStyle(fontSize: 18, color: Colors.white)),
          );
        }
        return ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: playlist.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Player(
                      link: playlist[index]['link'],
                    ),
                  ));
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                  width: ResponsiveScreen.width(context),
                  height: ResponsiveScreen.height(context) * 0.12,
                  decoration: BoxDecoration(
                      color: containerColor,
                      border: Border.all(color: shadowColor, width: 3.w),
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Lottie.asset("assets/animations/play.json",
                            height: 80.h, width: 80.w),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                reuseText(
                                    "${playList[index]["course"]}:",
                                    14,
                                    maxWords: 2,
                                    FontWeight.w400,
                                    primaryTextColor),
                                SizedBox(
                                  width: 10.w,
                                ),
                                reuseText(
                                    playlist[index]["title"],
                                    15,
                                    maxWords: 3,
                                    FontWeight.normal,
                                    secondaryTextColor),
                              ],
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Row(
                              children: [
                                reuseText("Duration:", 18, FontWeight.normal,
                                    primaryTextColor),
                                SizedBox(
                                  width: 10.w,
                                ),
                                reuseText(playlist[index]["time"], 16,
                                    FontWeight.w400, secondaryTextColor),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            });
      });
}

quizScreen(String courseID) {
  return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('course')
          .doc(courseID)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text(
              "An error occurred while fetching MCQs",
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          );
        } else if (!snapshot.hasData) {
          return const Center(
            child: Text(
              "You haven't added any MCQs yet",
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          );
        }
        var mcq = snapshot.data?.get("mcq") as List?;
        if (mcq == null || mcq.isEmpty) {
          return const Center(
            child: Text("No MCQs added yet",
                style: TextStyle(fontSize: 18, color: Colors.white)),
          );
        }
        return ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: mcq.length,
            itemBuilder: (context, index) {
              var questionsLength = (mcq[index]['questions'] as List).length;
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) =>
                              MCQ(mcq: mcq[index]['questions']))));
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                  width: ResponsiveScreen.width(context),
                  height: ResponsiveScreen.height(context) * 0.12,
                  decoration: BoxDecoration(
                      color: containerColor,
                      border: Border.all(color: shadowColor, width: 3.w),
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Lottie.asset("assets/animations/mcq.json",
                            height: 80.h, width: 80.w),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            reuseText(
                                "${mcq[index]["title"]}",
                                18,
                                maxWords: 2,
                                FontWeight.w400,
                                primaryTextColor),
                            SizedBox(
                              height: 5.h,
                            ),
                            Row(
                              children: [
                                reuseText("Total MCQs:", 14, FontWeight.normal,
                                    primaryTextColor),
                                SizedBox(
                                  width: 10.w,
                                ),
                                reuseText(questionsLength.toString(), 16,
                                    FontWeight.w400, secondaryTextColor),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            });
      });
}

notesScreen() {
  return ListView.builder(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: notes.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
          width: ResponsiveScreen.width(context),
          height: ResponsiveScreen.height(context) * 0.12,
          decoration: BoxDecoration(
              color: containerColor,
              border: Border.all(color: shadowColor, width: 3.w),
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Lottie.asset("assets/animations/notes.json",
                    height: 80.h, width: 80.w),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: reuseText(
                          "${notes[index]["title"]}",
                          20,
                          maxWords: 2,
                          FontWeight.w400,
                          primaryTextColor),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      });
}

//Dummy Data for Show TODO it wll be replaced with Firebase Database Latter
List<Map<String, dynamic>> courses = [
  {
    "image": "images.jpg",
    "author": 'Sir Raj Kumar',
    "title": "Sindh University",
    "description":
        "Sindh University is a public research university in Sindh, Pakistan."
  },
  {
    "image": "mehran.jpg",
    "author": 'Moazzam Samoo',
    "title": "Mehran University",
    "description":
        "Mehran University of Engineering and Technology is a public research university in Jamshoro, Sindh, Pakistan."
  },
  {
    "image": "mehran.jpg",
    "author": 'Dr.Waheed Jatoi',
    "title": "Mehran University",
    "description":
        "Mehran University of Engineering and Technology is a public research university in Jamshoro, Sindh, Pakistan."
  },
  {
    "image": "mehran.jpg",
    "author": 'Dr.Asad Buledi',
    "title": "Mehran University",
    "description":
        "Mehran University of Engineering and Technology is a public research university in Jamshoro, Sindh, Pakistan."
  },
  {
    "image": "mehran.jpg",
    "author": 'Dr.Fida Chandio',
    "title": "Mehran University",
    "description":
        "Mehran University of Engineering and Technology is a public research university in Jamshoro, Sindh, Pakistan."
  },
  {
    "image": "lumhs.jpg",
    "author": 'Dr.Sumera Dero',
    "title": "LUMHS University",
    "description":
        "Liaquat University of Medical and Health Sciences is a public research university in Jamshoro, Sindh, Pakistan."
  },
  {
    "image": "gc.jpg",
    "author": 'Dr.Najma Channa',
    "title": "GC University",
    "description":
        "Government College University is a public research university in Faisalabad, Punjab, Pakistan."
  },
];
List<Map<String, dynamic>> playList = [
  {
    "course": "English",
    "title": "Past Present Tense",
    "duration": "45:34",
  },
  {
    "course": "Math",
    "title": "Simple IQ",
    "duration": "10:44",
  },
  {
    "course": "General Knowledge",
    "title": "Nehru Report",
    "duration": "15:31",
  },
  {
    "course": "Pakistan Study",
    "title": "Chain Relations",
    "duration": "18:12",
  },
  {
    "course": "Math",
    "title": "Matrix Multiplication",
    "duration": "25:23",
  },
  {
    "course": "General Knowledge",
    "title": "Mountains",
    "duration": "13:14",
  },
  {
    "course": "English",
    "title": "Present Continues",
    "duration": "45:14",
  }
];
List<Map<String, dynamic>> quiz = [
  {"title": "GK Rivers", "total": "40"},
  {"title": "Math IQ", "total": "30"},
  {"title": "English", "total": "20"},
  {"title": "General Knowledge", "total": "10"},
  {"title": "GK Mountains", "total": "60"},
  {"title": "Math Average-%", "total": "10"},
  {"title": "GK PakStudy", "total": "50"},
  {"title": "GK Countries", "total": "20"},
  {"title": "GK Flags", "total": "40"},
  {"title": "Math Percentage", "total": "10"},
];
List<Map<String, dynamic>> notes = [
  {"title": "GK Rivers"},
  {"title": "Math IQ"},
  {"title": "English"},
  {"title": "General Knowledge"},
  {"title": "GK Mountains"},
  {"title": "Math Average-%"},
  {"title": "GK PakStudy"},
  {"title": "GK Countries"},
  {"title": "GK Flags"},
  {"title": "Math Percentage"},
];

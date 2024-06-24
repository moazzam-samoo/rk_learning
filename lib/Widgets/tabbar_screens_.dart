import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:rk_learning/Models/course_model.dart';
import 'package:rk_learning/Widgets/pdf_view.dart';
import 'package:rk_learning/Widgets/player.dart';
import 'package:rk_learning/Widgets/request_handler.dart';
import 'package:rk_learning/Widgets/reuseable_widgets.dart';
import 'package:url_launcher/url_launcher.dart';
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
        snapshot.data!.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
        final course = snapshot.data!;
        return ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: course.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () async {
                  String purchasedStatus =
                      await RequestHandler.checkCoursePurchaseStatus(
                          course[index].id!);
                  if (purchasedStatus == 'approved') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CourseContent(
                          selectedIndex: index,
                          courseID: course[index].id!,
                        ),
                      ),
                    );
                  } else if (purchasedStatus == 'pending') {
                    RequestHandler.showPendingRequestDialog(context);
                  } else if (purchasedStatus == 'denied') {
                    RequestHandler.showDeniedRequestDialog(
                        context, course[index].id!, course[index].title!);
                  } else {
                    RequestHandler.showPurchaseDialog(
                        context, course[index].id!, course[index].title!);
                  }
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 4.w),
                  width: ResponsiveScreen.width(context),
                  height: ResponsiveScreen.height(context) * 0.18,
                  decoration: BoxDecoration(
                    color: containerColor,
                    border: Border.all(color: shadowColor, width: 3.w),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      courseImage(context, course[index].image),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              reuseText(
                                course[index].title ?? "No Title",
                                16,
                                FontWeight.bold,
                                primaryTextColor,
                                maxLines: 2,
                                overflow: TextOverflow.visible,
                              ),
                              reuseText(
                                course[index].subtitle ?? "No Subtitle",
                                10,
                                FontWeight.normal,
                                primaryTextColor,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(
                                height: ResponsiveScreen.height(context) * 0.01,
                              ),
                              Row(
                                children: [
                                  reuseText(
                                    "Price: ",
                                    12,
                                    FontWeight.normal,
                                    primaryTextColor,
                                  ),
                                  reuseText(
                                    course[index].price ?? "Free",
                                    14,
                                    FontWeight.normal,
                                    primaryTextColor,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
      });
}

///Test Screen that its show how many Tests/MCQs are present,
cpnCalculator(TextEditingController test, TextEditingController inter,
    TextEditingController matric, context, Function() onTab) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
    child: GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            reuseText("Sindh University CPN Calculator", 18, FontWeight.normal,
                secondaryTextColor),
            SizedBox(
              height: 15.h,
            ),
            cpnTextField(hintText: "Test Marks", controller: test),
            SizedBox(
              height: ResponsiveScreen.height(context) * 0.02,
            ),
            cpnTextField(
                hintText: "Intermediate Percentage", controller: inter),
            SizedBox(
              height: ResponsiveScreen.height(context) * 0.02,
            ),
            cpnTextField(
                hintText: "Matriculation Percentage", controller: matric),
            SizedBox(
              height: ResponsiveScreen.height(context) * 0.03,
            ),
            calculateButton(onTab, context)
          ],
        ),
      ),
    ),
  );
}

double calculateCPN(double test, double inter, double matric) {
  return (test * 0.6) + (inter * 0.3) + (matric * 0.1);
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
              "Notifications not Added Yet",
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
                              textAlign: TextAlign.center, maxWords: 15),
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
                        buildTextWithLinks(notifications[index].text!),
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

Widget buildTextWithLinks(String text) {
  RegExp linkRegExp = RegExp(r'http(s)?://\S+');
  Iterable<Match> matches = linkRegExp.allMatches(text);

  List<Widget> widgets = [];

  int lastMatchEnd = 0;

  for (Match match in matches) {
    if (match.start > lastMatchEnd) {
      widgets.add(reuseText(text.substring(lastMatchEnd, match.start), 14,
          FontWeight.normal, primaryTextColor));
    }
    String url = text.substring(match.start, match.end);
    widgets.add(
      GestureDetector(
        onTap: () {
          launch(url);
        },
        child: Text(
          url,
          style: const TextStyle(
              color: Colors.blue, decoration: TextDecoration.underline),
        ),
      ),
    );
    lastMatchEnd = match.end;
  }

  if (lastMatchEnd < text.length) {
    widgets.add(reuseText(
        text.substring(lastMatchEnd), 14, FontWeight.normal, primaryTextColor));
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: widgets,
  );
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

playListScreen(String courseID) {
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
                  decoration: BoxDecoration(
                      color: containerColor,
                      border: Border.all(color: shadowColor, width: 3.w),
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Lottie.asset("assets/animations/play.json",
                            height: 50.h, width: 50.w),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              reuseText(
                                  playlist[index]['category'],
                                  16,
                                  maxWords: 2,
                                  FontWeight.w400,
                                  primaryTextColor),
                              SizedBox(
                                width: 10.w,
                              ),
                              reuseText(
                                  playlist[index]['title'],
                                  15,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  maxWords: 6,
                                  FontWeight.normal,
                                  secondaryTextColor),
                              SizedBox(
                                height: 5.h,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.timelapse_outlined,
                                    color: primaryTextColor,
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  reuseText(playlist[index]["time"], 14,
                                      FontWeight.w400, secondaryTextColor),
                                ],
                              )
                            ],
                          ),
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
                            height: 50.h, width: 50.w),
                        SizedBox(
                          width: 10.w,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            reuseText(
                                "${mcq[index]["title"]}",
                                16,
                                maxWords: 2,
                                FontWeight.w400,
                                primaryTextColor),
                            SizedBox(
                              height: 5.h,
                            ),
                            Row(
                              children: [
                                reuseText("Total MCQs:", 12, FontWeight.normal,
                                    primaryTextColor),
                                SizedBox(
                                  width: 10.w,
                                ),
                                reuseText(questionsLength.toString(), 14,
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

notesScreen(String courseID) {
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
              "An error occurred while fetching Notes",
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          );
        } else if (!snapshot.hasData) {
          return const Center(
            child: Text(
              "Notes not Added Yet",
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          );
        }
        var note = snapshot.data?.get("notes") as List?;
        if (note == null || note.isEmpty) {
          return const Center(
            child: Text("No Notes added yet",
                style: TextStyle(fontSize: 18, color: Colors.white)),
          );
        }
        return ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: note.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => PDFScreen(
                          path: note[index]['link'],
                          title: note[index]['title'])));
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                  width: ResponsiveScreen.width(context),
                  decoration: BoxDecoration(
                      color: containerColor,
                      border: Border.all(color: shadowColor, width: 3.w),
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Lottie.asset("assets/animations/notes.json",
                            height: 50.h, width: 50.w),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Column(
                            children: [
                              Center(
                                child: reuseText(
                                    note[index]['title'],
                                    16,
                                    maxWords: 2,
                                    maxLines: 2,
                                    FontWeight.w400,
                                    primaryTextColor),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            });
      });
}

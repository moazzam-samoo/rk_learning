import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rk_learning/Constants/capitalize.dart';
import 'package:rk_learning/Constants/colors.dart';
import 'package:rk_learning/Widgets/reuseable_widgets.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../../Constants/responsive_screen.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key, required this.count, required this.mcq});
  final int count;
  final List mcq;
  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    String? displayName = FirebaseAuth.instance.currentUser?.displayName;
    String studentName = displayName != null && displayName.isNotEmpty
        ? displayName.split(" ")[0].capitalize()
        : "Guest";
    final result = ((widget.count / widget.mcq.length) * 100).toInt();
    return Screenshot(
      controller: screenshotController,
      child: Scaffold(
        backgroundColor: firstPrimaryBg,
        body: Container(
          margin: EdgeInsets.only(top: ResponsiveScreen.height(context) * 0.07),
          child: Column(
            children: [
              Center(
                child: CircleAvatar(
                  backgroundColor:
                      result < 40 ? Colors.redAccent : Colors.greenAccent,
                  radius: 78,
                  child: FirebaseAuth.instance.currentUser?.photoURL != null
                      ? CircleAvatar(
                          backgroundImage: NetworkImage(FirebaseAuth
                              .instance.currentUser!.photoURL
                              .toString()),
                          radius: 75,
                        )
                      : CircleAvatar(
                          backgroundColor: result < 40
                              ? Colors.redAccent
                              : Colors.greenAccent,
                          radius: 78,
                          child: const Image(
                            image: AssetImage('assets/icons/user.png'),
                            fit: BoxFit.cover,
                            height: 150,
                            width: 150,
                          ),
                        ),
                ),
              ),
              SizedBox(height: 20.h),
              reuseText(
                  result < 40
                      ? "Sorry to Say, $studentName"
                      : "Congratulations, $studentName",
                  20,
                  FontWeight.normal,
                  primaryTextColor),
              SizedBox(height: 8.h),
              reuseText("Score $result / 100", 18, FontWeight.w600,
                  secondaryTextColor),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                child: Container(
                  height: ResponsiveScreen.height(context) * 0.4,
                  width: ResponsiveScreen.width(context),
                  decoration: BoxDecoration(
                      border: Border.all(color: primaryTextColor),
                      color: containerColor,
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _status("${widget.mcq.length}", "Total",
                                const Color(0xff13F344)),
                            _status("${widget.count}", "Correct",
                                const Color(0xffF3B413)),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _status(
                                result < 40
                                    ? "F"
                                    : result >= 40 && result < 50
                                        ? "C"
                                        : result >= 50 && result < 60
                                            ? "C+"
                                            : result >= 60 && result < 70
                                                ? "B"
                                                : result >= 70 && result < 80
                                                    ? "B+"
                                                    : result >= 80 &&
                                                            result < 90
                                                        ? "A"
                                                        : "A+",
                                "Grade",
                                const Color(0xffE56C14)),
                            _status(
                                result < 40 ? "Fail" : "Pass",
                                "Remarks",
                                result < 40
                                    ? Colors.red
                                    : const Color(0xffD91EDD)),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        reuseText("RK Learning", 22, FontWeight.w500,
                            primaryTextColor),
                        reuseText("A Journey To Excellence!", 12,
                            FontWeight.w500, secondaryTextColor),
                        SizedBox(height: 15.h),
                        reuseText(
                            textAlign: TextAlign.center,
                            result > 80
                                ? "Outstanding performance! Keep up the excellent work."
                                : result > 70
                                    ? "Great job! Your hard work and dedication are paying off."
                                    : result >= 60 && result < 70
                                        ? "Good work, but there's still room for improvement. Keep pushing yourself!"
                                        : result >= 50 && result < 60
                                            ? "Solid effort, but there are areas where you can excel even more with extra focus."
                                            : result >= 40 && result < 50
                                                ? "Some improvement needed. Let's work together to raise your performance."
                                                : result < 40
                                                    ? "Work harder to meet expectations. I believe you can do better."
                                                    : "This grade shows significant improvement is needed. Let's discuss strategies to help you succeed.",
                            13,
                            FontWeight.w500,
                            primaryTextColor),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _smallButtons("Go Back", () {
                    int count = 0;
                    Navigator.of(context).popUntil((route) {
                      return count++ == 2;
                    });
                  }, Icons.update),
                  _smallButtons("Share", () async {
                    final image = await screenshotController.capture();
                    if (image != null) {
                      await Share.shareXFiles(
                          [XFile.fromData(image, mimeType: 'image/png')]);
                    }
                  }, Icons.share),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _status(String title, String subtitle, Color circleColor) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: circleColor,
          radius: 10,
        ),
        SizedBox(
          width: 10.w,
        ),
        Column(
          children: [
            reuseText(title, 20, FontWeight.bold, Colors.white),
            reuseText(subtitle, 12, FontWeight.normal, circleColor),
          ],
        )
      ],
    );
  }

  _smallButtons(String title, Function() onTab, IconData icon) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTab,
          child: CircleAvatar(
            radius: 30,
            backgroundColor: shadowColor,
            child: Icon(
              icon,
              color: Colors.white,
              size: 30.sp,
            ),
          ),
        ),
        reuseText(title, 18, FontWeight.normal, primaryTextColor),
      ],
    );
  }
}

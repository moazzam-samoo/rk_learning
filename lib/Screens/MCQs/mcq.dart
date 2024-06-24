import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rk_learning/Screens/MCQs/result_screen.dart';
import 'package:rk_learning/Widgets/reuseable_widgets.dart';

import '../../Constants/colors.dart';
import '../../Constants/responsive_screen.dart';

class MCQ extends StatefulWidget {
  final List mcq;

  const MCQ({super.key, required this.mcq});

  @override
  State<MCQ> createState() => _MCQState();
}

class _MCQState extends State<MCQ> {
  int selectedIndex = -1;
  int count = 0;
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: containerColor,
      body: Stack(children: [
        Container(
          margin: EdgeInsets.only(top: ResponsiveScreen.height(context) * 0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildQuestionCount(),
              SizedBox(height: 10.h),
              _buildQuestionBox(),
              SizedBox(height: 10.h),
              Expanded(
                child: Container(
                  width: ResponsiveScreen.width(context),
                  decoration: const BoxDecoration(
                    color: firstPrimaryBg,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                    border:
                        Border(top: BorderSide(color: shadowColor, width: 3)),
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        buildButton(0),
                        buildButton(1),
                        buildButton(2),
                        buildButton(3),
                        SizedBox(height: 10.h),
                        _buildNextButton(0.7),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        _buildBackButton(context),
      ]),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Positioned(
      top: 40.h,
      left: 20.w,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: CircleAvatar(
          backgroundColor: shadowColor,
          radius: 20.sp,
          child: Icon(
            Icons.arrow_back,
            color: primaryTextColor,
            size: 24.sp,
          ),
        ),
      ),
    );
  }

  GestureDetector buildButton(int ans) {
    return GestureDetector(
      onTap: selectedIndex == -1
          ? () async {
              setState(() {
                selectedIndex = ans;
              });
              if (selectedIndex + 1 == widget.mcq[index]['correct']) {
                count++;
              }
              if (index == widget.mcq.length - 1) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) =>
                        ResultScreen(count: count, mcq: widget.mcq)));
              }
            }
          : null,
      child: Padding(
        padding: EdgeInsets.only(top: 10.h, left: 20.w, right: 20.w),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
          margin: EdgeInsets.symmetric(vertical: 4.h),
          decoration: BoxDecoration(
            color: containerColor,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: ans == selectedIndex
                  ? (selectedIndex + 1 == widget.mcq[index]['correct']
                      ? Colors.green
                      : Colors.red)
                  : (ans + 1 == widget.mcq[index]['correct'] &&
                          selectedIndex > -1
                      ? Colors.green
                      : primaryTextColor),
              width: ans == selectedIndex
                  ? (selectedIndex + 1 == widget.mcq[index]['correct']
                      ? 2 // Width for correct answer
                      : 2) // Width for wrong answer
                  : (ans + 1 == widget.mcq[index]['correct'] &&
                          selectedIndex > -1
                      ? 2 // Width for correct answer
                      : 2), // Width for wrong answer
            ),
          ),
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      reuseText(
                        ans == 0
                            ? "A"
                            : ans == 1
                                ? "B"
                                : ans == 2
                                    ? "C"
                                    : "D",
                        20,
                        FontWeight.bold,
                        ans == selectedIndex
                            ? (selectedIndex + 1 == widget.mcq[index]['correct']
                                ? Colors.green
                                : Colors.red)
                            : (ans + 1 == widget.mcq[index]['correct'] &&
                                    selectedIndex > -1
                                ? Colors.green
                                : secondaryTextColor),
                      ),
                    ],
                  ),
                  SizedBox(width: 10.w),
                  Flexible(
                    child: reuseText(
                      maxLines: 2,
                      widget.mcq[index]['ans'][ans] ?? '',
                      16,
                      FontWeight.w500,
                      Colors.white,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  ans == selectedIndex
                      ? (selectedIndex + 1 == widget.mcq[index]['correct']
                          ? const Icon(
                              Icons.done,
                              color: Colors.green,
                            )
                          : const Icon(
                              Icons.close,
                              color: Colors.red,
                            ))
                      : (ans + 1 == widget.mcq[index]['correct'] &&
                              selectedIndex > -1
                          ? const Icon(
                              Icons.done,
                              color: Colors.green,
                            )
                          : const SizedBox()),
                ],
              )),
        ),
      ),
    );
  }

  _buildQuestionCount() {
    return Center(
      child: CircleAvatar(
        backgroundColor: primaryTextColor,
        radius: 42.sp,
        child: CircleAvatar(
          backgroundColor: shadowColor,
          radius: 40.sp,
          child: reuseText("${index + 1}/${widget.mcq.length}", 18,
              FontWeight.w700, primaryTextColor),
        ),
      ),
    );
  }

  _buildQuestionBox() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 20.w),
      decoration: BoxDecoration(
          color: shadowColor,
          border: Border.all(color: primaryTextColor, width: 2.w),
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: reuseText(
                "Question",
                14,
                FontWeight.w600,
                secondaryTextColor,
              ),
            ),
            const Divider(
              color: Colors.white,
              thickness: 0.4,
            ),
            SizedBox(height: 5.h),
            reuseText(
                widget.mcq[index]['questions'] ?? '',
                16,
                maxLines: 5,
                FontWeight.normal,
                primaryTextColor)
          ],
        ),
      ),
    );
  }

  _buildNextButton(double width) {
    return Visibility(
      visible: selectedIndex > -1 && index < widget.mcq.length - 1,
      child: GestureDetector(
        onTap: () {
          selectedIndex = -1;
          if (index < widget.mcq.length - 1) {
            setState(() {
              index++;
            });
          }
        },
        child: Container(
            height: ResponsiveScreen.height(context) * 0.06,
            width: ResponsiveScreen.width(context) * width,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            margin: const EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
                color: shadowColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white)),
            child: const Text(
              "Next",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            )),
      ),
    );
  }
}

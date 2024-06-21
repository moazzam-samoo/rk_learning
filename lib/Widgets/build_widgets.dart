import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rk_learning/Widgets/reuseable_widgets.dart';
import '../Constants/colors.dart';
import '../Constants/responsive_screen.dart';

//Tab Bar that is Showing in Course Content Screen
buildCourseContentTabBar(TabController tabController) {
  return TabBar(
    physics: const ClampingScrollPhysics(),
    padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
    indicatorSize: TabBarIndicatorSize.label,
    unselectedLabelColor: secondaryTextColor,
    labelColor: Colors.white,
    dividerColor: Colors.transparent,
    controller: tabController,
    tabs: const [
      Tab(
        text: "PlayList",
      ),
      Tab(
        text: "MCQs",
      ),
      Tab(
        text: "Notes",
      ),
    ],
  );
}

///Calculate button that is present in <courseScreen> . That calculates the CPN
calculateButton(Function() onTab, BuildContext context) {
  return GestureDetector(
    onTap: onTab,
    child: Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(vertical: 16.h),
      height: ResponsiveScreen.height(context) * 0.05,
      width: ResponsiveScreen.width(context) * 0.450,
      decoration: BoxDecoration(
          gradient: buttonGradientColor(),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: shadowColor, width: 1)),
      child: reuseText("Calculate", 14, FontWeight.normal, primaryTextColor),
    ),
  );
}

//Course Image that is present in <courseScreen>
Widget courseImage(BuildContext context, String? image) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    width: MediaQuery.of(context).size.width * 0.39,
    height: MediaQuery.of(context).size.height * 0.150,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
    ),
    child: Stack(
      fit: StackFit.expand,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.7), // 40% opacity
              BlendMode.dstATop,
            ),
            child: image != null
                ? Image.network(
                    image,
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.fill,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return const Center(
                          child: Icon(
                        Icons.image_rounded,
                        size: 40,
                      ));
                    },
                  )
                : const Center(
                    child: Text(
                      'No Image Provided',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
          ),
        ),
      ],
    ),
  );
}

//Course Image that is present in <CourseContent Screen>
courseContentImage(BuildContext context, String? image) {
  return Container(
    height: ResponsiveScreen.height(context) * 0.245,
    width: ResponsiveScreen.width(context) * 0.820,
    decoration: BoxDecoration(
      border: Border.all(color: primaryTextColor, width: 2),
      borderRadius: BorderRadius.circular(40),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(40),
      child: ColorFiltered(
        colorFilter: ColorFilter.mode(
          Colors.white.withOpacity(0.7), // 40% opacity
          BlendMode.dstATop,
        ),
        child: image != null
            ? Image.network(
                image,
                filterQuality: FilterQuality.high,
                fit: BoxFit.fill,
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return const Center(
                      child: Icon(
                    Icons.image,
                    size: 40,
                  ));
                },
              )
            : const Center(
                child: Text(
                  'No Image Provided',
                  style: TextStyle(color: Colors.red),
                ),
              ),
      ),
    ),
  );
}

//Contact button that is present in <contactScreen>
contactButton(
  BuildContext context,
  String title,
  String icon, {
  VoidCallback? onTab,
}) {
  return GestureDetector(
    onTap: onTab,
    child: Container(
      height: ResponsiveScreen.height(context) * 0.14,
      width: ResponsiveScreen.width(context) * 0.33,
      decoration: BoxDecoration(
        color: containerColor,
        border: Border.all(color: shadowColor, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/icons/$icon.png',
            scale: 8,
          ),
          SizedBox(
            height: 10.h,
          ),
          reuseText(title, 14, FontWeight.w500, primaryTextColor)
        ],
      ),
    ),
  );
}

cpnTextField(
    {required String hintText, required TextEditingController controller}) {
  return TextField(
    keyboardType: TextInputType.number,
    maxLines: 1,
    textInputAction: TextInputAction.done,
    controller: controller,
    cursorColor: primaryTextColor,
    showCursor: true,
    style: TextStyle(
        color: primaryTextColor,
        fontWeight: FontWeight.normal,
        fontSize: 14.sp),
    decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: primaryTextColor, // Set border color here
            width: 1.5.w, // Set border width here
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: shadowColor, // Set border color here
            width: 1.5.w, // Set border width here
          ),
        ),
        hintStyle: TextStyle(
            color: primaryTextColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.normal),
        hintText: hintText),
  );
}

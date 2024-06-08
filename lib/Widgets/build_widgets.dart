import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rk_learning/Widgets/reuseable_widgets.dart';
import '../Constants/colors.dart';
import '../Constants/responsive_screen.dart';

/// --> This is Whole For Tab Bars...
//Tab Bar that is showing in Welcome Screen
buildWelcomeTabBar(TabController tabController) {
  return TabBar(
    indicator: CircleTabIndicator(
      color: buttonFirstColor,
      radius: 4,
    ),
    unselectedLabelColor: secondaryTextColor,
    labelColor: Colors.white,
    dividerColor: Colors.transparent,
    controller: tabController,
    tabs: const [
      Tab(
        text: "Courses",
      ),
      Tab(
        text: "Test",
      ),
      Tab(
        text: "Notification",
      ),
      Tab(
        text: "Contact",
      ),
    ],
  );
}

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

//Decoration Class For tab Bar... Note <Ignore it its nothing just an small dot indicator>
class CircleTabIndicator extends Decoration {
  final Color color;
  double radius;

  CircleTabIndicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final double radius;
  late Color color;
  _CirclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    late Paint paint;
    paint = Paint()..color = color;
    paint = paint..isAntiAlias = true;
    final Offset circleOffset =
        offset + Offset(cfg.size!.width / 2, cfg.size!.height - radius);
    canvas.drawCircle(circleOffset, radius, paint);
  }
}
// --> Whole for BuildTabBar Ended...

///Purchase button that is present in <courseScreen>
purchaseButton(VoidCallback onTab, BuildContext context) {
  return GestureDetector(
    onTap: () {},
    child: Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(vertical: 16.h),
      height: ResponsiveScreen.height(context) * 0.05,
      width: ResponsiveScreen.width(context) * 0.240,
      decoration: BoxDecoration(
          gradient: buttonGradientColor(),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: shadowColor, width: 1)),
      child: reuseText("BUY", 14, FontWeight.normal, primaryTextColor),
    ),
  );
}

//Course Image that is present in <courseScreen>
Widget courseImage(BuildContext context, String? image) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16.w),
    width: ResponsiveScreen.width(context) * 0.39,
    height: ResponsiveScreen.height(context) * 0.150,
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
            child: Image.network(
              image!,
              filterQuality: FilterQuality.high,
              fit: BoxFit.fill,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              (loadingProgress.expectedTotalBytes ?? 1)
                          : null,
                      strokeWidth: 2, // Adjust thickness of the spinner
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(Colors.black),
                    ),
                  );
                }
              },
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
        child: Image.network(
          image!,
          filterQuality: FilterQuality.high,
          fit: BoxFit.fill,
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

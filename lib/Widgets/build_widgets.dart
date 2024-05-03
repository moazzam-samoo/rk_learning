import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rk_learning/Widgets/reuseable_widgets.dart';

import '../Constants/colors.dart';
import '../Constants/responsive_screen.dart';
import '../Screens/Welcome Screen/welcome_screen.dart';

buildImage(BuildContext context) {
  double height = (((MediaQuery.of(context).size.height) - 70) / 2);
  double width = (((MediaQuery.of(context).size.width) - 2));
  return Container(
      height: height,
      width: width,
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/icons/app_logo.png'),
        fit: BoxFit.fill,
      )));
}

// --> Whole for BuildTabBar
buildTabBar(TabController tabController) {
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
// --> Whole for BuildTabBar

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

courseImage(BuildContext context, String image) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16.w),
    width: ResponsiveScreen.width(context) * 0.39,
    height: ResponsiveScreen.height(context) * 0.150,
    decoration: BoxDecoration(
      border: Border.all(color: textWhiteColor, width: 2),
      borderRadius: BorderRadius.circular(30),
      color: Colors.white,
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: ColorFiltered(
        colorFilter: ColorFilter.mode(
          Colors.white.withOpacity(0.6), // 40% opacity
          BlendMode.dstATop,
        ),
        child: Image.asset(
          "assets/images/$image",
          filterQuality: FilterQuality.high,
          fit: BoxFit.fill,
        ),
      ),
    ),
  );
}

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

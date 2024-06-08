import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:rk_learning/Constants/colors.dart';
import 'package:rk_learning/Widgets/google_login_button.dart';
import 'package:rk_learning/Widgets/reuseable_widgets.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 35.h, horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Lottie.asset("assets/animations/logo_rk.json"),
                SizedBox(height: 20.h),
                reuseText(
                  "RK Learning",
                  48,
                  FontWeight.bold,
                  primaryTextColor,
                ),
                reuseText("A Journey To Excellence!", 16, FontWeight.w300,
                    secondaryTextColor),
                SizedBox(height: 10.h),
                reuseText(
                    "Your Gateway to Success! Unlock your potential with expertly crafted online courses and insider tips for acing entry tests.",
                    11,
                    FontWeight.w200,
                    thirdTextColor),
                SizedBox(
                  height: 38.h,
                ),

                /// Calling the button Widget that contain Login to navigate
                /// and Other properties as well.
                const GoogleButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:rk_learning/Constants/colors.dart';
import 'package:rk_learning/Screens/Authentication%20Screen/auth/authentication_screen.dart';
import '../Screens/Authentication Screen/google_auth.dart';

//TODO >> Add the Developer info >> Add the Current Version of App >> Add the Vision of app

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: containerColor,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: 70.w, right: 70.w, bottom: 60.h, top: 24.h),
              child: Lottie.asset("assets/animations/circle.json"),
            ),
            buildButton(context, FontAwesomeIcons.arrowRightFromBracket,
                "Sign Out", const AuthenticationScreen())
          ],
        ),
      ),
    );
  }

  buildButton(BuildContext context, IconData icon, String label, page) {
    return MaterialButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: textWhiteColor,
              ),
              SizedBox(
                width: 20.w,
              ),
              Text(label,
                  style: TextStyle(
                      fontSize: 17.sp,
                      color: primaryTextColor,
                      fontWeight: FontWeight.w400)),
            ],
          ),
          const Align(
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.arrow_forward_ios,
                color: textWhiteColor,
              )),
        ],
      ),
      onPressed: () {
        Authentication.signOut();
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
    );
  }
}

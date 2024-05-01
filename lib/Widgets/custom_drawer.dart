import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rk_learning/Constants/colors.dart';
import 'package:rk_learning/Screens/Authentication%20Screen/auth/authentication_screen.dart';

import '../Screens/Authentication Screen/google_auth.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: secondaryBackgroundColorII,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:  EdgeInsets.only(
                  left: 70.w, right: 70.w, bottom: 60.h, top: 24.h),
              child: Image.asset(
                'assets/icons/app_logo.png',
              ),
            ),
            //buildButton(context, Icons.book, ' My Courses', const MyCourse()),
            buildButton(context, Icons.logout, ' Sign Out',
                const AuthenticationScreen()),
          ],
        ),
      ),
    );
  }

  MaterialButton buildButton(
      BuildContext context, IconData icon, String label, page) {
    return MaterialButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon),
               SizedBox(
                width: 4.w,
              ),
              Text(label,
                  style: TextStyle(
                      fontSize: 17.sp,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500)),
            ],
          ),
          const Align(
              alignment: Alignment.centerRight,
              child: Icon(Icons.arrow_forward_ios)),
        ],
      ),
      onPressed: () {
        Authentication.signOut();
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rk_learning/Constants/colors.dart';
import 'package:rk_learning/Screens/Welcome%20Screen/welcome_screen.dart';
import 'package:rk_learning/Widgets/reuseable_widgets.dart';

import '../Constants/responsive_screen.dart';
import '../Screens/Authentication Screen/google_auth.dart';

class GoogleButton extends StatefulWidget {
  const GoogleButton({super.key});

  @override
  State<GoogleButton> createState() => _GoogleButtonState();
}

class _GoogleButtonState extends State<GoogleButton>
    with WidgetsBindingObserver {
  bool isSignIn = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addObserver(this);
    double height = (((MediaQuery.of(context).size.height) - 200) / 11);
    double width = (((MediaQuery.of(context).size.width) - 2));

    return CupertinoButton(
      padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 5.w),
      onPressed: () async {
        EasyLoading.show();
        User? user = await Authentication.signInWithGoogle();
        if (!mounted) {
          EasyLoading.dismiss();
        }
        if (user != null) {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const WelcomeScreen()));
        }
      },
      child: Container(
          alignment: Alignment.center,
          width: ResponsiveScreen.width(context),
          height: ResponsiveScreen.height(context) * 0.1,
          decoration: BoxDecoration(
            gradient: buttonGradientColor(),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: Colors.white, width: 0.5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              reuseText(
                  "Start Learning", 24, FontWeight.w300, primaryTextColor),
              const Icon(
                FontAwesomeIcons.arrowRight,
                color: Colors.white,
              ),
            ],
          )),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      EasyLoading.dismiss();
    }
  }
}

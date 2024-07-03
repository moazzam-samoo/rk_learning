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

///This is the Google Sign In Button that is called in Authentication Screen
///this button ensures the user and navigate it to welcome Screen.
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

    return CupertinoButton(
      padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 5.w),
      onPressed: () async {
        showSignInDialog(context, () async {
          EasyLoading.show();
          User? user = await Authentication.signInWithGoogle();
          if (!mounted) {
            EasyLoading.dismiss();
          }
          if (user != null) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const WelcomeScreen(),
              ),
            );
          }
        });
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

  static void showSignInDialog(BuildContext context, Function() onPressed) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: shadowColor,
          title: reuseText("Sign In", 22, FontWeight.bold, primaryTextColor),
          content: reuseText("Please choose a sign-in method", 14,
              FontWeight.normal, primaryTextColor),
          actions: <Widget>[
            TextButton(
              onPressed: onPressed,
              child: Row(
                children: [
                  Image.asset(
                    'assets/icons/google.png', // Add your Google icon asset here
                    height: 24,
                    width: 24,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Sign in with Google',
                    style: TextStyle(fontSize: 16, color: primaryTextColor),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const WelcomeScreen(),
                  ),
                );
              },
              child: Row(
                children: [
                  const Icon(
                    Icons.person,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 10),
                  reuseText("Sign in as Guest", 14, FontWeight.normal,
                      primaryTextColor),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

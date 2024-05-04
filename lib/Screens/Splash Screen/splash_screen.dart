import 'package:flutter/material.dart';

///This is Splash Screen that Show the App Logo for 2 seconds only
///and it will disappear and move user to next Screen that is Signing page.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Image.asset(
        "assets/icons/app_logo.png",
        width: 200,
        height: 200,
      )),
    );
  }
}

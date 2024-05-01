import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rk_learning/Constants/colors.dart';
import 'package:rk_learning/Screens/Authentication%20Screen/auth/authentication_screen.dart';
import 'package:rk_learning/Screens/Splash%20Screen/splash_screen.dart';
import 'package:rk_learning/Screens/Welcome%20Screen/navigation_bar.dart';
import 'package:rk_learning/Screens/Welcome%20Screen/welcome_screen.dart';
import 'package:rk_learning/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 640),
        builder: (context, child) => MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              textTheme: TextTheme(
                  displayLarge: TextStyle(
                      fontSize: 21.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: "primaryFont",
                      color: textWhiteColor),
                  headlineSmall: TextStyle(
                      fontSize: 21.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: "primaryFont",
                      color: shadowColor),
                  displayMedium: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: "primaryFont",
                      color: textSecondary),
                  displaySmall: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: "primaryFont",
                      color: textWhiteColor),
                  headlineMedium: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: "welcomeFont",
                      color: textWhiteColor)),
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              appBarTheme: const AppBarTheme(color: secondaryBackgroundColorII),
              scaffoldBackgroundColor: firstPrimaryBg,
              useMaterial3: true,
            ),
            debugShowCheckedModeBanner: false,
            builder: EasyLoading.init(),
            home: FutureBuilder(
                future: Future.delayed(const Duration(seconds: 1)),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    final FirebaseAuth auth = FirebaseAuth.instance;
                    final User? user = auth.currentUser;
                    if (user != null) {
                      return const AuthenticationScreen();
                    } else {
                      return const AuthenticationScreen();
                    }
                  }
                  return const AuthenticationScreen();
                })));
  }
}

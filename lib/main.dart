import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rk_learning/Constants/colors.dart';
import 'package:rk_learning/Screens/Authentication%20Screen/auth/authentication_screen.dart';
import 'package:rk_learning/Screens/Splash%20Screen/splash_screen.dart';
import 'package:rk_learning/Screens/Welcome%20Screen/welcome_screen.dart';
import 'package:rk_learning/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

bool _initialized = false;

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 640),
      builder: (context, child) => MaterialApp(
        title: 'RK Learning',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          appBarTheme: const AppBarTheme(color: firstPrimaryBg),
          scaffoldBackgroundColor: firstPrimaryBg,
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        builder: EasyLoading.init(),
        home: FutureBuilder(
          future: Future.delayed(const Duration(seconds: 1), () {
            return FirebaseAuth.instance.authStateChanges().first;
          }),
          builder: (context, AsyncSnapshot<User?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              if (!_initialized) {
                _initialized = true;
                return const SplashScreen();
              } else {
                return const WelcomeScreen(); // or AuthenticationScreen
              }
            } else {
              if (snapshot.hasError) {
                // Handle error case
                return const SplashScreen(); // or error screen
              } else {
                final user = snapshot.data;
                if (user != null) {
                  return const WelcomeScreen();
                } else {
                  return const AuthenticationScreen();
                }
              }
            }
          },
        ),
      ),
    );
  }
}

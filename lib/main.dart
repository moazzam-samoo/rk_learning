import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rk_learning/Constants/colors.dart';
import 'package:rk_learning/Screens/Authentication%20Screen/auth/authentication_screen.dart';
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
          future: Future.delayed(const Duration(seconds: 1)),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final FirebaseAuth auth = FirebaseAuth.instance;
              final User? user = auth.currentUser;
              if (user != null) {
                return const WelcomeScreen();
              } else {
                return const AuthenticationScreen();
              }
            }
            return const WelcomeScreen();
          },
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rk_learning/Constants/colors.dart';
import 'package:rk_learning/Constants/responsive_screen.dart';
import 'package:rk_learning/Screens/Welcome%20Screen/Conopnents%20Of%20WelcomeScreen/components_of_welcomescreen.dart';
import 'package:rk_learning/Widgets/custom_drawer.dart';
import 'package:rk_learning/Widgets/reuseable_widgets.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  TextEditingController textEditingControllerSearch = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int index = 0;
  @override
  Widget build(BuildContext context) {
    double height = (MediaQuery.of(context).size.height);
    double width = (MediaQuery.of(context).size.width);
    return Scaffold(
      appBar: buildAppbar(() => scaffoldKey.currentState?.openDrawer()),
      key: scaffoldKey,
      drawer: const CustomDrawer(),
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: ResponsiveScreen.width(context) * 0.04,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildName(context),
              SizedBox(height: height * 0.01),
            ],
          ),
        ),
      ),
    );
  }
}
//TODO For Latter
// SizedBox(height: height * 0.02),
// SizedBox(
//   height: 40,
//   child: ListView(
//     scrollDirection: Axis.horizontal,
//     children: [
//       buildCourseButton(
//           width - 100,
//           index,
//           () => setState(() {
//                 index = 0;
//               })),
//       buildTestButton(
//           width - 100,
//           index,
//           () => setState(() {
//                 index = 1;
//               })),
//       buildCommButton(
//           width - 100,
//           index,
//           () => setState(() {
//                 index = 2;
//               })),
//       buildWhatsAppButton(width - 100, index, () async {
//         await whatsAppLaunchUrl();
//       })
//     ],
//   ),
// ),
// SizedBox(height: height * 0.02),
// Text(
//     index == 0
//         ? " Choose Your Courses"
//         : (index == 1 ? " Available MCQs" : "Updates"),
//     maxLines: 1,
//     style: Theme.of(context).textTheme.displayLarge),
// SizedBox(height: height * 0.02),
// index == 0
//     ? buildCourseData(height)
//     : (index == 1 ? buildTestData() : buildCommunityData(height)),
// buildCourseData(),
// SizedBox(height: height * 0.02),
// Text(
//   index == 0
//       ? " Choose Your Courses"
//       : (index == 1 ? " Available MCQs" : "E_Updates"),
//   maxLines: 1,
//   style: TextStyle(
//       fontWeight: FontWeight.bold,
//       fontSize: ResponsiveFlutter.of(context).fontSize(2.5),
//       color: prymeryColor1),
// ),
// SizedBox(height: height * 0.02),
// index == 0
//     ? buildCouse(height)
//     : (index == 1 ? buildMCQ(height) : buildCom(height)),

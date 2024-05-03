import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:rk_learning/Constants/capitalize.dart';
import 'package:rk_learning/Constants/colors.dart';
import 'package:rk_learning/Database/firebase_handler.dart';
import 'package:rk_learning/Widgets/custom_course_data.dart';
import 'package:rk_learning/Widgets/reuseable_widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Models/course_model.dart';

buildProfilePicAndName(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              reuseText("Hi,  ", 22, FontWeight.bold, buttonFirstColor,
                  textAlign: TextAlign.center),
              Text(
                  FirebaseAuth.instance.currentUser!.displayName
                      .toString()
                      .split(" ")[0]
                      .capitalize(),
                  style: Theme.of(context).textTheme.displayLarge),
            ],
          ),
          reuseText(" Welcome Back!", 24, FontWeight.w400, secondaryTextColor)
        ],
      ),
      buildProfileAvatar(),
    ],
  );
}

buildAppbar() {
  return AppBar(
    leading: Builder(builder: (context) {
      return IconButton(
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
        icon: const Icon(
          FontAwesomeIcons.bars,
          color: textWhiteColor,
        ),
      );
    }),
    elevation: 0,
    backgroundColor: firstPrimaryBg,
    actions: [buildProfileAvatar()],
  );
}

buildProfileAvatar() {
  // ConnectivityResult connectivityResult =
  //     await Connectivity().checkConnectivity();
  // bool isConnected = connectivityResult != ConnectivityResult.none;
  return Builder(builder: (context) {
    return GestureDetector(
      onTap: () {
        Scaffold.of(context).openDrawer();
      },
      child: CircleAvatar(
        backgroundColor: textWhiteColor,
        radius: 27.3,
        child: CircleAvatar(
          radius: 27,
          backgroundImage: NetworkImage(
              FirebaseAuth.instance.currentUser!.photoURL.toString()),
        ),
      ),
    );
  });
}

//Design it Latter <Reminder>
buildCourseButton(double width, int index, Function() onTab) {
  return InkWell(
    onTap: onTab,
    child: SizedBox(
      width: width * 0.35,
      height: 43,
      child: Card(
          margin: const EdgeInsets.all(0),
          elevation: 0,
          color: index == 0 ? shadowColor : primaryBackgroundColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(180),
                bottomRight: Radius.circular(250)),
          ),
          child: Center(
            child: Text(
              "Course",
              style: TextStyle(
                  color: index == 0 ? Colors.white : shadowColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          )),
    ),
  );
}

buildTestButton(double width, int index, Function() onTab) {
  return InkWell(
    onTap: onTab,
    child: SizedBox(
      width: width * 0.35.w,
      height: 43.h,
      child: Card(
          margin: const EdgeInsets.all(0),
          elevation: 0,
          color: index == 1 ? shadowColor : primaryBackgroundColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(180),
                bottomRight: Radius.circular(250)),
          ),
          child: Center(
            child: Text(
              "Test",
              style: TextStyle(
                  color: index == 1 ? Colors.white : shadowColor,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold),
            ),
          )),
    ),
  );
}

buildCommButton(double width, int index, Function() onTab) {
  return InkWell(
    onTap: onTab,
    child: SizedBox(
      width: width * 0.39.w,
      height: 43.h,
      child: Card(
          margin: const EdgeInsets.all(0),
          elevation: 0,
          color: index == 2 ? shadowColor : primaryBackgroundColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(180),
                bottomRight: Radius.circular(250)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Center(
              child: Text(
                "Community",
                style: TextStyle(
                    color: index == 2 ? Colors.white : shadowColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )),
    ),
  );
}

buildWhatsAppButton(double width, int index, Function() onTab) {
  return InkWell(
    onTap: onTab,
    child: Padding(
      padding: const EdgeInsets.only(left: 6),
      child: SizedBox(
        width: width * 0.37.w,
        height: 43.h,
        child: const Card(
            margin: EdgeInsets.all(0),
            elevation: 0,
            color: primaryBackgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(180),
                  bottomRight: Radius.circular(250)),
            ),
            child: Center(
              child: Text(
                "WhatsApp Us",
                maxLines: 1,
                style: TextStyle(
                    color: shadowColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            )),
      ),
    ),
  );
}


buildCourseData(double height) {
  return SizedBox(
    height: height * 0.64,
    child: GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 0.7),
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        return CustomCourse(
            text: list[index]['name'].toString(),
            img: const AssetImage("assets/icons/app_logo.png"),
            onTap: () {});
      },
    ),
  );
}

buildTestData() {
  return Container();
}

Widget buildCommunityData(double height) {
  return StreamBuilder(
    stream: CommunityHandler.getCommunity(),
    builder: (context, AsyncSnapshot<List<CommunityModel>> snapshot) {
      if (snapshot.hasData) {
        return SizedBox(
          height: height * 0.64,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              CommunityModel data = snapshot.data![index];
              DateTime date = data.time!.toDate();
              String formattedDate = DateFormat('dd-MMMM-yyyy hh:mm a')
                  .format(date); // Format the date
              return Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.green,
                        blurRadius: 5,
                        spreadRadius: 0.5,
                      )
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          data.title!,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w800),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Text(
                        data.text!,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.timelapse,
                            color: Colors.grey,
                            size: 16,
                          ),
                          Text(
                            "  $formattedDate", // Use the formatted date string
                            style: const TextStyle(
                                fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return const Center(
          child: Text(
            "You Don't added Any Communities yet",
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
        );
      } else {
        return const CircularProgressIndicator();
      }
    },
  );
}

// dummy data
List<Map<String, String>> list = [
  {
    'image': "assets/images/sign.jpg",
    'name': "Sindh University",
  },
];

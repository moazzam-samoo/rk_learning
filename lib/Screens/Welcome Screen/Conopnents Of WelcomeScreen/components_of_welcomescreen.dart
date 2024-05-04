import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rk_learning/Constants/capitalize.dart';
import 'package:rk_learning/Constants/colors.dart';
import 'package:rk_learning/Database/firebase_handler.dart';
import 'package:rk_learning/Widgets/reuseable_widgets.dart';
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

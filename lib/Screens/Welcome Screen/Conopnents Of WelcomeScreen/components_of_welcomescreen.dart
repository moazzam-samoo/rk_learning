import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rk_learning/Constants/capitalize.dart';
import 'package:rk_learning/Constants/colors.dart';
import 'package:rk_learning/Widgets/reuseable_widgets.dart';

buildProfilePicAndName(BuildContext context) {
  String? displayName = FirebaseAuth.instance.currentUser?.displayName;
  String firstName = displayName != null && displayName.isNotEmpty
      ? displayName.split(" ")[0].capitalize()
      : "Guest";
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
              reuseText(firstName, 28, FontWeight.normal, primaryTextColor)
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
  return Builder(builder: (context) {
    return GestureDetector(
      onTap: () {
        Scaffold.of(context).openDrawer();
      },
      child: CircleAvatar(
        backgroundColor: primaryTextColor,
        radius: 27.3,
        child: CircleAvatar(
          radius: 27,
          backgroundColor: Colors.transparent,
          child: FirebaseAuth.instance.currentUser?.photoURL != null
              ? ClipOval(
                  child: Image.network(
                    FirebaseAuth.instance.currentUser!.photoURL!,
                    fit: BoxFit.cover,
                    width: 54,
                    height: 54,
                    errorBuilder: (context, error, stackTrace) {
                      return const Image(
                        image: AssetImage('assets/icons/user.png'),
                        fit: BoxFit.cover,
                        width: 54,
                        height: 54,
                      );
                    },
                  ),
                )
              : const Image(
                  image: AssetImage('assets/icons/user.png'),
                  fit: BoxFit.cover,
                  width: 54,
                  height: 54,
                ),
        ),
      ),
    );
  });
}

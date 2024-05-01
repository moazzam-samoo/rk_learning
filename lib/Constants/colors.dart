// For App UI
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

//For App Buttons

//Background Gradient Color
const firstPrimaryBg = Color(0xff0A0121);
const secondPrimaryBg = Color(0xff05052B);

//Button Gradient Colors
const buttonFirstColor = Color(0xff7A119F);
const buttonSecondColor = Color(0xff2010A1);
const buttonThirdColor = Color(0xff0E10A1);

//Container and shadow/border color
const containerColor = Color(0xff251255);
const shadowColor = Color(0xff7A119F);

//Defined Text Colors
const primaryTextColor = Color(0xffFFFFFF);
const secondaryTextColor = Color(0xff5F6079);
const thirdTextColor = Color(0xff4d4e66);

//TODO Defined Gradient Colors for Application
Gradient backgroundGradientColor() {
  return const LinearGradient(colors: [firstPrimaryBg, secondPrimaryBg]);
}

Gradient buttonGradientColor() {
  return const LinearGradient(colors: [
    buttonFirstColor,
    buttonSecondColor
  ]);
}

const double kPadding = 18.0;

final loading = EasyLoading.instance;
easyLoadingStyle() {
  EasyLoadingStyle.light;
}

//App Basic Colors
const primaryBackgroundColor = Color(0xff383f3f);
const secondaryBackgroundColor = Color(0xff232F34);
const secondaryBackgroundColorII = Color(0xff4A6572);
const primaryContainerColor = Color(0xff97a8b2);

//Button Colors
const primaryButtonColor = Color(0xffF9AA33);
const primaryShadowColor = Color(0xffF9AA83);

//Text Colors
const textWhiteColor = Color(0xffFFFFFF);
Color textSecondary = const Color(0xffF9AA33);
// For Text

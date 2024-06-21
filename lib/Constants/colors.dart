library;

/// These colors are defined for the UI and are used throughout the interface.

import 'package:flutter/material.dart';

///Defined App Colors For Text, Background, Containers etc...

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

/// Defined Gradient Colors for Application
Gradient backgroundGradientColor() {
  return const LinearGradient(colors: [firstPrimaryBg, secondPrimaryBg]);
}

///Defined Gradient color for Button
Gradient buttonGradientColor() {
  return const LinearGradient(colors: [buttonFirstColor, buttonSecondColor]);
}

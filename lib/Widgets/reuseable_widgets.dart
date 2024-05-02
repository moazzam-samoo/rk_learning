import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget reuseText(
    String text, double fontSize, FontWeight? fontWeight, Color color,
    {int maxWords = -1}) {
  List<String> words = text.split(' ');
  String displayText = text;
  if (maxWords > 0 && words.length > maxWords) {
    displayText = words.sublist(0, maxWords).join(' ');
  }
  return Text(
    displayText,
    textAlign: TextAlign.center,
    style: TextStyle(
      color: color,
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
    ),
  );
}

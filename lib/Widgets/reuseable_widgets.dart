import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

reuseText(String text, double fontSize, FontWeight? fontWeight, Color color) {
  return Text(
    textAlign: TextAlign.center,
    text,
    style: TextStyle(
      color: color,
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
    ),
  );
}

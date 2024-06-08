import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//This Reuseable Text used every where in app. For showing the text.
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget reuseText(
    String text,
    double fontSize,
    FontWeight? fontWeight,
    Color color, {
      int maxWords = -1,
      int? maxLines, // Added nullable maxLines parameter
      TextAlign? textAlign,
    }) {
  List<String> words = text.split(' ');
  String displayText = text;
  if (maxWords > 0 && words.length > maxWords) {
    displayText = words.sublist(0, maxWords).join(' ');
  }
  return Text(
    displayText,
    maxLines: maxLines, // Apply maxLines to the Text widget
    textAlign: textAlign,
    overflow: maxLines != null ? TextOverflow.ellipsis : null, // Handle overflow if maxLines is set
    style: TextStyle(
      color: color,
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCourse extends StatelessWidget {
  final String text;
  final AssetImage img;
  final Function() onTap;

  const CustomCourse(
      {super.key, required this.text, required this.img, required this.onTap});

  @override
  Widget build(BuildContext context) {
    double width = (((MediaQuery.of(context).size.width) - 69) / 2);
    double height = (((MediaQuery.of(context).size.height) - 320) / 2);
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: height,
          width: width,
          alignment: Alignment.bottomLeft,
          padding: EdgeInsets.only(bottom: 32.h, left: 16.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              image: DecorationImage(image: img, fit: BoxFit.cover)),
          child: Text(
            text,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 17.sp),
          ),
        ),
      ),
    );
  }
}

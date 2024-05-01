import 'package:flutter/cupertino.dart';

buildImage(BuildContext context) {
  double height = (((MediaQuery.of(context).size.height) - 70) / 2);
  double width = (((MediaQuery.of(context).size.width) - 2));
  return Container(
      height: height,
      width: width,
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/icons/app_logo.png'),
        fit: BoxFit.fill,
      )));
}


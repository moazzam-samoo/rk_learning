import 'package:flutter/widgets.dart';

///Defined Responsive class to make UI responsive to adjust its size on any Device
class ResponsiveScreen {
  static double height(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double width(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
}

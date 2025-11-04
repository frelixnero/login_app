import 'package:flutter/material.dart';

class Responsive extends ChangeNotifier {
  bool isLongerThanNormal(BuildContext context) {
    return MediaQuery.of(context).size.height > 910;
  }

  bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width >= 600 &&
        MediaQuery.of(context).size.width < 1000;
  }

  bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1000;
  }
}

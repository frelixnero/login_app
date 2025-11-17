import 'package:flutter/material.dart';

class Responsive extends ChangeNotifier {
  bool isTextEnormousAndLarge(BuildContext context) {
    return MediaQuery.of(context).textScaleFactor > 1.30;
  }

  bool isTextEnormous(BuildContext context) {
    return MediaQuery.of(context).textScaleFactor > 1.80;
  }

  bool isTextLarge(BuildContext context) {
    return MediaQuery.of(context).textScaleFactor > 1.20 &&
        MediaQuery.of(context).textScaleFactor <= 1.80;
  }

  bool isTextMedium(BuildContext context) {
    return MediaQuery.of(context).textScaleFactor > 0.85 &&
        MediaQuery.of(context).textScaleFactor < 1.20;
  }

  bool isTextSmall(BuildContext context) {
    return MediaQuery.of(context).textScaleFactor <= 0.85;
  }

  bool isShorterThanNormal(BuildContext context) {
    return MediaQuery.of(context).size.height <= 730;
  }

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

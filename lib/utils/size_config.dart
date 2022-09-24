import 'package:flutter/material.dart';

double screenWidth({required BuildContext context}) {
  final _mediaQueryData = MediaQuery.of(context);
  return _mediaQueryData.size.width;
}

double screenHeight({required BuildContext context}) {
  final _mediaQueryData = MediaQuery.of(context);
  return _mediaQueryData.size.height;
}

double blockSizeHorizontal({required BuildContext context}) {
  final width = screenWidth(context: context);
  return (width / 100);
}

double blockSizeVertical({required BuildContext context}) {
  final height = screenHeight(context: context);
  return (height / 100);
}

double safeAreaHorizontal({required BuildContext context}) {
  final _mediaQueryData = MediaQuery.of(context);
  final _safeAreaHorizontal =
      _mediaQueryData.padding.left + _mediaQueryData.padding.right;
  return _safeAreaHorizontal;
}

double safeAreaVertical({required BuildContext context}) {
  final _mediaQueryData = MediaQuery.of(context);
  final _safeAreaVertical =
      _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
  return _safeAreaVertical;
}

double safeBlockHorizontal({required BuildContext context}) {
  final _safeAreaHorizontal = safeAreaHorizontal(context: context);
  final _screenWidth = screenWidth(context: context);
  return (_screenWidth - _safeAreaHorizontal) / 100;
}

double safeBlockVertical({required BuildContext context}) {
  final _safeAreaVertical = safeAreaVertical(context: context);
  final _screenHeight = screenHeight(context: context);
  return (_screenHeight - _safeAreaVertical) / 100;
}

double font12Px({required BuildContext context}) {
  return safeBlockVertical(context: context) / 0.75;
}

double font15Px({required BuildContext context}) {
  return safeBlockVertical(context: context) / 0.60;
}

double font18Px({required BuildContext context}) {
  return safeBlockVertical(context: context) / 0.5;
}

double font22Px({required BuildContext context}) {
  return safeBlockVertical(context: context) / 0.35;
}

double font25Px({required BuildContext context}) {
  return safeBlockVertical(context: context) / 0.3;
}

double font32Px({required BuildContext context}) {
  return safeBlockVertical(context: context) * 6;
}

double getScreenPercentSize(BuildContext context, double percent) {
  return (screenHeight(context: context) * percent) / 100;
}

double getWidthPercentSize(BuildContext context, double percent) {
  return (screenWidth(context: context) * percent) / 100;
}

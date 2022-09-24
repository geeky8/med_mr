import 'package:flutter/material.dart';

class ConstantData {
  // static Color primaryColor = ("#1399C6".toColor() as Color);
  // static Color cellColor = "#E4E6ED".toColor();
  static String fontFamily = "Manrope";
  static String assetsPath = "assets/images/";
  static String imagePath = 'https://superadmintest.medrpha.com/allimage/';

  static String dateFormat = "EEE ,MMM dd,yyyy";

  static String poolId = 'ap-south-1_5psREt0yj';
  static String poolClientId = '5j4he35aqisfnmg1dfk1bbqtep';

  static const double avatarRadius = 40;
  static Color mainTextColor = "#030303".toColor();
  static LinearGradient primaryGradient = LinearGradient(colors: [
    '#972F98'.toColor(),
    '#983098'.toColor(),
  ]);
  static Color primaryColor = '#37B9C5'.toColor();
  static Color secondaryColor = '#FF5A5A'.toColor();
  static Color thridColor = '#55D6BE'.toColor();
  static Color textFieldColor = '#EEEEEE'.toColor();
  static Color bgColor = "#ffffff".toColor();
  static Color cardColor = '#FDA055'.toColor();
  static Color clrBorder = const Color(0xffBABABA);
  // static Color mainTextColor = "#084043".toColor();
  static Color textColor = "#4E4E4E".toColor();
  static Color tileColor = "#E1EBEC".toColor();

  static BorderRadius borderRadius = BorderRadius.circular(20);

  static String privacyPolicy = "https://google.com";

  static String timeFormat = "hh:mm aa";

  static RegExp passValidate =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  static RegExp gstValidate =
      RegExp(r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$');

  static RegExp emailValidate = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  bool validateStructure({required String value, required String pattern}) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    final regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }


  static TextStyle customTextStyle({
    required double fontSize,
    required Color color,
    required FontWeight fontWeight,
    TextOverflow? overflow,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      overflow: overflow,
    );
  }
}

extension ColorExtension on String {
  toColor() {
    var hexColor = replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:medrpha_trial/utils/constant_data.dart';
import 'package:medrpha_trial/utils/size_config.dart';

class ConstantWidgets {
  Widget headerText({
    required BuildContext context,
    required String value,
  }) {
    return Text(
      value,
      style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: font32Px(context: context),
        fontWeight: FontWeight.w500,
        letterSpacing: 0.4,
        color: ConstantData.mainTextColor,
      ),
    );
  }

  Widget customBigButton({
    required BuildContext context,
    required String text,
    required Color color,
    required double radius,
    required VoidCallback onPressed,
    required FontWeight fontWeight,
  }) {
    final fontSize = getWidthPercentSize(context, 5);
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: blockSizeVertical(context: context) * 2,
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          // color: color,
          borderRadius: BorderRadius.circular(radius),
          gradient: ConstantData.primaryGradient,
        ),
        child: customText(
          value: text,
          fontSize: fontSize,
          color: ConstantData.bgColor,
          fontWeight: fontWeight,
        ),
      ),
    );
  }

  PreferredSizeWidget customAppBar({
    required String title,
    required BuildContext context,
    List<Widget>? widgetList,
    Color? color,
    Widget? leading,
    bool? centerTitle,
  }) {
    return AppBar(
      title: customText(
        value: title,
        fontSize: font18Px(context: context),
        color: ConstantData.mainTextColor,
        fontWeight: FontWeight.w600,
      ),
      elevation: 0,
      backgroundColor: color ?? ConstantData.bgColor,
      centerTitle: centerTitle ?? true,
      leading: leading ??
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: ConstantData.mainTextColor,
              size: font18Px(context: context) * 1.1,
            ),
          ),
      actions: widgetList,
    );
  }

  SnackBar customSnackBar(
      {required String text, required BuildContext context}) {
    return SnackBar(
      content: customText(
        value: text,
        fontSize: font15Px(context: context),
        alignment: TextAlign.left,
        color: ConstantData.bgColor,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget customButton({
    required BuildContext context,
    required VoidCallback onPressed,
    required double radius,
    required String text,
    required double fontSize,
    required FontWeight fontWeight,
    required EdgeInsets padding,
    LinearGradient? gradient,
    Color? color,
    required Color textColor,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: blockSizeVertical(context: context) * 2,
      ),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          padding: padding,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radius),
            gradient: gradient,
          ),
          child: customText(
            value: text,
            fontSize: fontSize,
            color: textColor,
            fontWeight: fontWeight,
          ),
        ),
      ),
    );
  }

  Widget customDialog({
    required BuildContext context,
    // required String text,
    required VoidCallback onTap,
    required bool isSuccess,
  }) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        height: getScreenPercentSize(context, 70),
        width: getWidthPercentSize(context, 90),
        decoration: const BoxDecoration(shape: BoxShape.rectangle),
        padding: EdgeInsets.symmetric(
            vertical: blockSizeVertical(context: context) * 3),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              ConstantData.assetsPath +
                  ((isSuccess) ? 'success.png' : 'failure.png'),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: blockSizeHorizontal(context: context) * 3,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: ConstantWidgets().customText(
                      value: (isSuccess)
                          ? 'Thank you so much for your order'
                          : '\t\tOops ... something went wrong',
                      fontSize: font18Px(context: context),
                      color: ConstantData.mainTextColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: blockSizeHorizontal(context: context) * 3,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: ConstantWidgets().customButton(
                      context: context,
                      onPressed: onTap,
                      radius: 12,
                      text: 'Check Status',
                      fontSize: font15Px(context: context),
                      fontWeight: FontWeight.w500,
                      padding: EdgeInsets.symmetric(
                          vertical: blockSizeVertical(context: context) * 2.5),
                      textColor: ConstantData.bgColor,
                      color: ConstantData.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget customText({
    required String value,
    required double fontSize,
    required Color color,
    required FontWeight fontWeight,
    int? maxLines,
    TextAlign? alignment,
    TextDecoration? textDecoration,
    Color? textDecorationColor,
    TextDecorationStyle? textDecorationStyle,
  }) {
    return Text(
      value,
      maxLines: maxLines,
      textAlign: alignment,
      style: TextStyle(
        fontFamily: ConstantData.fontFamily,
        fontSize: fontSize,
        fontWeight: fontWeight,
        decoration: textDecoration,
        decorationColor: textDecorationColor,
        decorationStyle: textDecorationStyle,
        color: color,
      ),
    );
  }
}

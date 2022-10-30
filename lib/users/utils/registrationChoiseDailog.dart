import 'package:flutter/material.dart';
import 'package:medrpha_trial/utils/constant_data.dart';
import 'package:medrpha_trial/utils/size_config.dart';

Widget registrationChoiseDailog(BuildContext context) {
  return SimpleDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
    title: const Center(child: Text("Choose to Proceed Further")),
    children: [
      registrationButton(context, "OTP", () {}),
      registrationButton(context, "Link", () {}),
    ],
  );
}

TextButton registrationButton(
    BuildContext context, String title, Function() onTap) {
  return TextButton(
    onPressed: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(
        horizontal: blockSizeHorizontal(context: context) * 15,
        vertical: blockSizeVertical(context: context) * 2,
      ),
      decoration: BoxDecoration(
          color: ConstantData.primaryColor,
          borderRadius: BorderRadius.circular(12)),
      child: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
    ),
  );
}

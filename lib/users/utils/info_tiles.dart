import 'package:flutter/material.dart';
import 'package:medrpha_trial/utils/constant_data.dart';
import 'package:medrpha_trial/utils/size_config.dart';
import 'package:medrpha_trial/utils/wigets.dart';

class InfoTiles extends StatelessWidget {
  const InfoTiles({
    Key? key,
    required this.label,
    required this.crossAxisAlignment,
    required this.text,
  }) : super(key: key);

  final String label;
  final String text;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        ConstantWidgets().customText(
          value: label,
          fontSize: font15Px(context: context),
          color: ConstantData.primaryColor,
          fontWeight: FontWeight.w700,
        ),
        ConstantWidgets().customText(
          value: text,
          fontSize: font18Px(context: context),
          color: ConstantData.mainTextColor,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }
}

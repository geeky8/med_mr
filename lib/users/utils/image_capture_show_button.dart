import 'package:flutter/material.dart';
import 'package:medrpha_trial/utils/constant_data.dart';
import 'package:medrpha_trial/utils/size_config.dart';
import 'package:medrpha_trial/utils/wigets.dart';

class ImageCaptureShow extends StatelessWidget {
  const ImageCaptureShow({
    Key? key,
    required this.func,
    required this.label,
  }) : super(key: key);

  final VoidCallback func;
  final String label;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: func,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: blockSizeHorizontal(context: context),
          horizontal: blockSizeHorizontal(context: context) * 3,
        ),
        decoration: BoxDecoration(
          color: ConstantData.thridColor,
          borderRadius: BorderRadius.circular(
            font22Px(context: context),
          ),
          border: Border.all(
            color: ConstantData.clrBorder.withOpacity(0.6),
          ),
        ),
        child: ConstantWidgets().customText(
          value: label,
          fontSize: font12Px(context: context) * 1.17,
          color: ConstantData.bgColor,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

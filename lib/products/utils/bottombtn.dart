import 'package:flutter/material.dart';

import '../../utils/constant_data.dart';
import '../../utils/size_config.dart';
import '../../utils/wigets.dart';

class BottomButton extends StatelessWidget {
  const BottomButton({Key? key, required this.onTap, required this.text})
      : super(key: key);
  final String text;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: blockSizeHorizontal(context: context) * 4,
      ),
      child: ConstantWidgets().customButton(
        context: context,
        onPressed: () {
          onTap();
        },
        radius: 30,
        text: text,
        fontSize: font18Px(context: context),
        fontWeight: FontWeight.w500,
        padding: EdgeInsets.all(blockSizeHorizontal(context: context) * 4),
        color: ConstantData.primaryColor,
        textColor: Colors.white,
      ),
    );
  }
}

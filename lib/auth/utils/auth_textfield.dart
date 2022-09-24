import 'package:flutter/material.dart';
import 'package:medrpha_trial/utils/constant_data.dart';
import 'package:medrpha_trial/utils/size_config.dart';

typedef ValidatorCallBack = String? Function(String?);

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    Key? key,
    required this.controller,
    required this.label,
    this.onTap,
    required this.prefixIcon,
    this.suffixIcon,
    this.validator,
    required this.keyboardType,
  }) : super(key: key);

  final TextEditingController controller;
  final String label;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onTap;
  final ValidatorCallBack? validator;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: blockSizeHorizontal(context: context) * 3,
      ),
      child: TextFormField(
        controller: controller,
        onTap: onTap,
        style: TextStyle(
          fontFamily: ConstantData.fontFamily,
          fontSize: font18Px(context: context),
          color: ConstantData.mainTextColor,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: label,
          hintStyle: TextStyle(
            fontFamily: ConstantData.fontFamily,
            fontSize: font18Px(context: context),
            color: ConstantData.clrBorder,
            fontWeight: FontWeight.w500,
          ),
          suffixIcon: Icon(
            suffixIcon,
            size: font25Px(context: context),
            color: ConstantData.mainTextColor,
          ),
          prefixIcon: Icon(
            prefixIcon,
            size: font25Px(context: context),
            color: Colors.black54,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              font15Px(context: context),
            ),
            borderSide: BorderSide(
              color: ConstantData.clrBorder,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              font15Px(context: context),
            ),
            borderSide: BorderSide(
              color: ConstantData.mainTextColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              font15Px(context: context),
            ),
            borderSide: BorderSide(
              color: ConstantData.clrBorder,
            ),
          ),
        ),
      ),
    );
  }
}

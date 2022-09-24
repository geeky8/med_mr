import 'package:flutter/material.dart';
import 'package:medrpha_trial/users/models/address_model.dart';
import 'package:medrpha_trial/utils/constant_data.dart';
import 'package:medrpha_trial/utils/size_config.dart';
import 'package:medrpha_trial/utils/wigets.dart';

typedef ValidatorCallBack = String? Function(String?);

class RegsiterEditTiles extends StatelessWidget {
  const RegsiterEditTiles({
    Key? key,
    required this.label,
    required this.crossAxisAlignment,
    this.validatorCallBack,
    required this.controller,
    required this.keyboardType,
    required this.padding,
    this.isEnabled,
    this.func,
  }) : super(key: key);

  final String label;

  final CrossAxisAlignment crossAxisAlignment;
  final TextEditingController controller;
  final ValidatorCallBack? validatorCallBack;
  final EdgeInsets padding;
  final TextInputType keyboardType;
  final VoidCallback? func;
  final bool? isEnabled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenWidth(context: context),
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        children: [
          ConstantWidgets().customText(
            value: label,
            fontSize: font15Px(context: context),
            color: ConstantData.primaryColor,
            fontWeight: FontWeight.w700,
          ),
          Padding(
            padding: padding,
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller,
                    enabled: isEnabled,
                    onTap: func,
                    style: TextStyle(
                      fontFamily: ConstantData.fontFamily,
                      color: ConstantData.mainTextColor,
                      fontSize: font18Px(context: context),
                      fontWeight: FontWeight.w500,
                    ),
                    validator: validatorCallBack ??
                        (value) {
                          if (value != null) {
                            if (value.isEmpty) {
                              return 'Required';
                            } else {
                              return null;
                            }
                          }
                          return null;
                        },
                    keyboardType: keyboardType,
                    autovalidateMode: AutovalidateMode.always,
                    decoration: InputDecoration(
                      hintText: label,
                      hintStyle: TextStyle(
                        fontFamily: ConstantData.fontFamily,
                        fontSize: font15Px(context: context),
                        fontWeight: FontWeight.w500,
                        color: ConstantData.clrBorder,
                      ),
                      errorStyle: TextStyle(
                        fontFamily: ConstantData.fontFamily,
                        fontSize: font12Px(context: context) * 1.1,
                        fontWeight: FontWeight.w500,
                        color: ConstantData.secondaryColor,
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: ConstantData.secondaryColor,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: ConstantData.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

typedef OnChangedCallBack = void Function(String?);

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({
    required this.list,
    required this.onChanged,
    this.value,
    required this.label,
    required this.crossAxisAlignment,
    required this.validator,
    super.key,
  });

  final List<AddressModel> list;
  final OnChangedCallBack onChanged;
  final String? value;
  final String label;
  final CrossAxisAlignment crossAxisAlignment;
  final ValidatorCallBack validator;

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
        DropdownButtonFormField<String>(
          value: value,
          isExpanded: true,
          elevation: 0,
          alignment: AlignmentDirectional.bottomStart,
          decoration: InputDecoration(
            errorStyle: TextStyle(
              fontFamily: ConstantData.fontFamily,
              fontSize: font12Px(context: context) * 1.1,
              fontWeight: FontWeight.w500,
              color: ConstantData.secondaryColor,
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: ConstantData.secondaryColor,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: ConstantData.primaryColor,
              ),
            ),
          ),
          icon: Icon(
            Icons.arrow_drop_down,
            color: ConstantData.primaryColor,
            size: font22Px(context: context),
          ),
          // underline: Container(
          //   height: blockSizeHorizontal(context: context) / 4,
          //   decoration: BoxDecoration(color: ConstantData.primaryColor),
          // ),
          validator: validator,
          items: list.map<DropdownMenuItem<String>>((e) {
            return DropdownMenuItem<String>(
              value: e.name,
              child: Align(
                alignment: Alignment.centerLeft,
                child: ConstantWidgets().customText(
                  value: e.name,
                  fontSize: font15Px(context: context) * 1.1,
                  color: ConstantData.mainTextColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }).toList(),
          hint: Align(
            alignment: Alignment.centerLeft,
            child: ConstantWidgets().customText(
              value: label,
              fontSize: font15Px(context: context),
              color: ConstantData.clrBorder,
              fontWeight: FontWeight.w600,
            ),
          ),
          onChanged: onChanged,
          selectedItemBuilder: (context) => list
              .map<Widget>(
                (e) => Align(
                  alignment: Alignment.centerLeft,
                  child: ConstantWidgets().customText(
                    value: e.name,
                    fontSize: font15Px(context: context) * 1.1,
                    color: ConstantData.mainTextColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

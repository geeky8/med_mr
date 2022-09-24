// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:medrpha_trial/bottom_navigation/screens/landing_screen.dart';
import 'package:medrpha_trial/users/controller/users_mr_controller.dart';
import 'package:medrpha_trial/users/models/user_model.dart';
import 'package:medrpha_trial/users/screens/create_account_screen.dart';
import 'package:medrpha_trial/users/screens/register_edit_info_screen.dart';
import 'package:medrpha_trial/utils/constant_data.dart';
import 'package:medrpha_trial/utils/size_config.dart';
import 'package:medrpha_trial/utils/wigets.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({
    Key? key,
    required this.success,
    this.userModel,
  }) : super(key: key);

  final bool success;
  final UserModel? userModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: blockSizeHorizontal(context: context) * 5,
        ),
        child: SizedBox(
          height: getScreenPercentSize(context, 14),
          child: Column(
            children: [
              if (success)
                ConstantWidgets().customButton(
                  context: context,
                  onPressed: () async {
                    final controller = Get.find<UserMRController>();
                    await controller.getCountry();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RegisterEditInfoScreen(
                          userModel: userModel,
                        ),
                      ),
                    );
                  },
                  radius: font25Px(context: context),
                  text: 'Proceed to registration',
                  fontSize: font18Px(context: context),
                  fontWeight: FontWeight.w700,
                  padding: EdgeInsets.symmetric(
                    vertical: blockSizeVertical(context: context) * 2,
                  ),
                  textColor: ConstantData.bgColor,
                  color: ConstantData.primaryColor,
                ),

              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => LandingScreen(),
                    ),
                  );
                },
                child: ConstantWidgets().customText(
                  value: (success) ? 'Not now' : 'Try again',
                  fontSize: font18Px(context: context),
                  color: ConstantData.mainTextColor,
                  fontWeight: FontWeight.w600,
                  alignment: TextAlign.center,
                ),
              ),
              // ConstantWidgets().customButton(
              //   context: context,
              //   onPressed: () async {},
              //   radius: font25Px(context: context),
              //   text: (success) ? 'Not now' : 'Try again',
              //   fontSize: font18Px(context: context),
              //   fontWeight: FontWeight.w700,
              //   padding: EdgeInsets.symmetric(
              //     vertical: blockSizeVertical(context: context) * 2,
              //   ),
              //   textColor: ConstantData.mainTextColor,
              //   color: ConstantData.clrBorder,
              // ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: blockSizeHorizontal(context: context) * 4,
          // vertical: blockSizeVertical(context: context) * 4,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(ConstantData.assetsPath +
                ((success) ? 'success.png' : 'error.png')),
            SizedBox(
              height: blockSizeVertical(context: context) * 3,
            ),
            ConstantWidgets().customText(
              value: (success) ? 'Phone Number Verified' : 'Failed to verify',
              fontSize: font22Px(context: context),
              color: ConstantData.mainTextColor,
              fontWeight: FontWeight.w700,
            ),
            SizedBox(
              height: blockSizeVertical(context: context),
            ),
            ConstantWidgets().customText(
              value: (success)
                  ? 'Congratulations, your phone number has been verified. You can start using the app'
                  : 'Sorry, could not verify your number. Please try again',
              fontSize: font18Px(context: context),
              color: ConstantData.clrBorder,
              fontWeight: FontWeight.w600,
              alignment: TextAlign.center,
              maxLines: 4,
            ),
          ],
        ),
      ),
    );
  }
}

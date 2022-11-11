import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:medrpha_trial/enums/mr_type.dart';
import 'package:medrpha_trial/profile/controller/profile_controller.dart';
import 'package:medrpha_trial/utils/constant_data.dart';
import 'package:medrpha_trial/utils/size_config.dart';
import 'package:medrpha_trial/utils/wigets.dart';

class ProfileInfoScreen extends StatelessWidget {
  const ProfileInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<ProfileController>();

    return Scaffold(
      appBar: ConstantWidgets().customAppBar(
        title: 'Profile',
        leading: Container(),
        context: context,
      ),
      body: Obx(
        () => Padding(
          padding: EdgeInsets.symmetric(
            horizontal: blockSizeHorizontal(context: context) * 4,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xffCBDFE1),
                    width: blockSizeHorizontal(context: context) * 1.5,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: ConstantData.primaryColor,
                      width: blockSizeHorizontal(context: context) * 2,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    '${ConstantData.assetsPath}med_logo.png',
                    height: getScreenPercentSize(context, 12),
                    width: getWidthPercentSize(context, 24),
                  ),
                ),
              ),
              SizedBox(
                height: blockSizeVertical(context: context) * 3,
              ),
              ConstantWidgets().customText(
                value: profileController.profileModel.value.name,
                fontSize: font22Px(context: context),
                color: ConstantData.secondaryColor,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(
                height: blockSizeVertical(context: context) * 1.5,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: blockSizeHorizontal(context: context) * 2,
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: blockSizeVertical(context: context) * 2,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: ConstantData.clrBorder,
                    ),
                    borderRadius: BorderRadius.circular(
                      font22Px(context: context),
                    ),
                  ),
                  child: Column(
                    children: [
                      UserInfoTiles(
                        label: 'Username',
                        value: profileController.profileModel.value.name,
                      ),
                      UserInfoTiles(
                        label: 'Mobile',
                        value: profileController.profileModel.value.mobileNo,
                      ),
                      UserInfoTiles(
                        label: 'Address',
                        value: profileController.profileModel.value.mrAddress,
                      ),
                      UserInfoTiles(
                        label: 'Position',
                        value:
                            (profileController.profileModel.value.designation)
                                .toText(),
                        isEnd: true,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserInfoTiles extends StatelessWidget {
  const UserInfoTiles({
    Key? key,
    required this.label,
    required this.value,
    this.isEnd,
  }) : super(key: key);

  final String label;
  final String value;
  final bool? isEnd;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ConstantWidgets().customText(
          value: label,
          fontSize: font15Px(context: context),
          color: ConstantData.primaryColor,
          fontWeight: FontWeight.w600,
        ),
        ConstantWidgets().customText(
          value: value,
          fontSize: font18Px(context: context),
          color: ConstantData.mainTextColor,
          fontWeight: FontWeight.w500,
        ),
        if (isEnd == null)
          Divider(
            color: ConstantData.clrBorder,
            thickness: 1.1,
          ),
      ],
    );
  }
}

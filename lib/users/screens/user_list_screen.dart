// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medrpha_trial/enums/inital_registeration.dart';
import 'package:medrpha_trial/enums/mr_type.dart';
import 'package:medrpha_trial/enums/user_status.dart';
import 'package:medrpha_trial/products/controller/product_controller.dart';
import 'package:medrpha_trial/products/enums/home_state.dart';
import 'package:medrpha_trial/products/screens/product_screen.dart';
import 'package:medrpha_trial/products/screens/product_screenA.dart';
import 'package:medrpha_trial/users/controller/users_mr_controller.dart';
import 'package:medrpha_trial/users/models/mr_model.dart';
import 'package:medrpha_trial/users/models/user_model.dart';
import 'package:medrpha_trial/users/screens/create_account_screen.dart';
import 'package:medrpha_trial/users/screens/register_edit_info_screen.dart';
import 'package:medrpha_trial/users/screens/user_info_screen.dart';
import 'package:medrpha_trial/users/screens/verify_otp_screen.dart';
import 'package:medrpha_trial/utils/constant_data.dart';
import 'package:medrpha_trial/utils/size_config.dart';
import 'package:medrpha_trial/utils/storage.dart';
import 'package:medrpha_trial/utils/wigets.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({Key? key}) : super(key: key);

  List<UserModel> getTileList({
    required List<UserModel> list,
    required UserStatus status,
  }) {
    final returnList = <UserModel>[];
    for (final model in list) {
      if (status == UserStatus.APPROVED) {
        if (model.status == 'Approved') {
          returnList.add(model);
        }
      } else if (status == UserStatus.NOT_APPROVED) {
        if (model.status == 'Not Approved') {
          returnList.add(model);
        }
      }
    }
    return returnList;
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UserMRController>();
    final productController = Get.put(ProductController());
    final mrType = mrTypefromValue(type: DataStorage().reademrType() ?? '2');
    return Scaffold(
      appBar: ConstantWidgets().customAppBar(
        title: 'User List',
        context: context,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateAccount(),
            ),
          );
        },
        backgroundColor: ConstantData.primaryColor,
        child: Icon(
          Icons.add,
          size: font25Px(context: context),
          color: ConstantData.bgColor,
        ),
      ),
      body: Obx(
        () => Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: blockSizeHorizontal(context: context) * 4,
                vertical: blockSizeVertical(context: context) * 2,
              ),
              child: Obx(() {
                List<UserModel> usersList = <UserModel>[];
                switch (controller.usersStatus.value) {
                  case RegisterationStatus.INITAL:
                    usersList
                      ..clear()
                      ..addAll(controller.initalUsersList);
                    break;
                  case RegisterationStatus.NON:
                    usersList
                      ..clear()
                      ..addAll(controller.nonRegUsersList);
                    break;
                  case RegisterationStatus.COMPLETE:
                    usersList
                      ..clear()
                      ..addAll(controller.usersList);
                    break;
                  case RegisterationStatus.LINK:
                    break;
                }
                return Column(
                  children: [
                    if (mrTypefromValue(type: DataStorage().mrtype) ==
                        MRType.EXECUTIVE)
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: ChipTile(
                              label: 'Non-Registred',
                              func: () {
                                controller.usersStatus.value =
                                    RegisterationStatus.NON;
                              },
                              color: (controller.usersStatus.value ==
                                      RegisterationStatus.NON
                                  ? ConstantData.primaryColor
                                  : null),
                            ),
                          ),
                          SizedBox(
                            width: blockSizeHorizontal(context: context) * 4,
                          ),
                          Expanded(
                            flex: 2,
                            child: ChipTile(
                              label: 'Step-1 Completed',
                              func: () {
                                controller.usersStatus.value =
                                    RegisterationStatus.INITAL;
                              },
                              color: (controller.usersStatus.value ==
                                      RegisterationStatus.INITAL
                                  ? ConstantData.primaryColor
                                  : null),
                            ),
                          ),
                          SizedBox(
                            width: blockSizeHorizontal(context: context) * 4,
                          ),
                          Expanded(
                            flex: 2,
                            child: ChipTile(
                              label: 'Completed',
                              func: () {
                                controller.usersStatus.value =
                                    RegisterationStatus.COMPLETE;
                              },
                              color: (controller.usersStatus.value ==
                                      RegisterationStatus.COMPLETE
                                  ? ConstantData.primaryColor
                                  : null),
                            ),
                          ),
                          // const Spacer(),
                        ],
                      ),
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(
                          horizontal: blockSizeHorizontal(context: context) * 2,
                          vertical: blockSizeVertical(context: context) * 3,
                        ),
                        itemCount: (mrType == MRType.EXECUTIVE)
                            ? usersList.length
                            : controller.mrList.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (mrType == MRType.EXECUTIVE)
                            ? (_, index) {
                                // return FirmInfoTile(
                                //   userModel: usersList[index],
                                // );
                                return AmanFirmInfoTile(
                                  userModel: usersList[index],
                                );
                              }
                            : (_, index) {
                                return MRInfoTile(
                                  mrModel: controller.mrList[index],
                                );
                              },
                      ),
                    )
                  ],
                );
              }),
            ),
            if (productController.homeState.value == HomeState.LOADING)
              Container(
                decoration: BoxDecoration(
                    color: ConstantData.clrBorder.withOpacity(0.5)),
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              )
          ],
        ),
      ),
    );
  }
}

class MRInfoTile extends StatelessWidget {
  const MRInfoTile({
    Key? key,
    required this.mrModel,
  }) : super(key: key);

  final MRModel mrModel;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UserMRController>();
    return InkWell(
      onTap: () async {
        // await controller.getUserDetails(model: model)
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          // horizontal: blockSizeHorizontal(context: context) * 2,
          vertical: blockSizeVertical(context: context),
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: ConstantData.clrBorder,
              width: 1.2,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ConstantWidgets().customText(
                  value: mrModel.mrId,
                  fontSize: font18Px(context: context),
                  color: ConstantData.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(
                  height: blockSizeVertical(context: context) * 2,
                ),
                ConstantWidgets().customText(
                  value:
                      'Installs : ${mrModel.monthInstall}/${mrModel.monthInstallTarget}',
                  fontSize: font15Px(context: context),
                  color: ConstantData.mainTextColor,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(
                  height: blockSizeVertical(context: context),
                ),
                ConstantWidgets().customText(
                  value:
                      'Sales : ${mrModel.monthSale}/${mrModel.monthSaleTarget}',
                  fontSize: font15Px(context: context),
                  color: ConstantData.mainTextColor,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                  color: ConstantData.primaryColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: ConstantData.clrBorder,
                      offset: const Offset(2, 2),
                      spreadRadius: 4,
                      blurRadius: 4,
                    )
                  ]),
              padding: EdgeInsets.all(
                blockSizeHorizontal(context: context) * 2,
              ),
              child: Icon(
                Icons.check,
                color: ConstantData.bgColor,
                size: font25Px(context: context) * 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FirmInfoTile extends StatelessWidget {
  const FirmInfoTile({
    Key? key,
    required this.userModel,
  }) : super(key: key);

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UserMRController>();
    return InkWell(
      onTap: () async {
        final model = await controller.getUserDetails(model: userModel);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => UserInfoScreen(userModel: model),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          // horizontal: blockSizeHorizontal(context: context) * 2,
          vertical: blockSizeVertical(context: context),
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: ConstantData.clrBorder,
              width: 1.2,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ConstantWidgets().customText(
                  value: userModel.firmName,
                  fontSize: font18Px(context: context),
                  color: ConstantData.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(
                  height: blockSizeVertical(context: context) * 2,
                ),
                ConstantWidgets().customText(
                  value: 'Contact : ${userModel.phoneNo}',
                  fontSize: font15Px(context: context),
                  color: ConstantData.mainTextColor,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(
                  height: blockSizeVertical(context: context),
                ),
                ConstantWidgets().customText(
                  value: 'Registration Date : ${userModel.regDate}',
                  fontSize: font15Px(context: context),
                  color: ConstantData.mainTextColor,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(
                  height: blockSizeVertical(context: context),
                ),
                ConstantWidgets().customText(
                  value: 'Registeration Status : ${userModel.status}',
                  fontSize: font15Px(context: context),
                  color: (userModel.status == 'Approved')
                      ? Colors.green[700]!
                      : ConstantData.secondaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                  color: (userModel.status == 'Approved')
                      ? ConstantData.primaryColor
                      : ConstantData.secondaryColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: ConstantData.clrBorder,
                      offset: const Offset(2, 2),
                      spreadRadius: 4,
                      blurRadius: 4,
                    )
                  ]),
              padding: EdgeInsets.all(
                blockSizeHorizontal(context: context) * 2,
              ),
              child: Icon(
                (userModel.status == 'Approved')
                    ? Icons.check_circle
                    : Icons.cancel_rounded,
                color: ConstantData.bgColor,
                size: font25Px(context: context) * 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Aman Firm info tile
class AmanFirmInfoTile extends StatelessWidget {
  const AmanFirmInfoTile({
    Key? key,
    required this.userModel,
  }) : super(key: key);

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UserMRController>();
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: blockSizeVertical(context: context),
        // horizontal: blockSizeHorizontal(context: context),
      ),
      child: InkWell(
        onTap: () async {
          final model = await controller.getUserDetails(model: userModel);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => UserInfoScreen(userModel: model),
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: blockSizeHorizontal(context: context) * 5,
            vertical: blockSizeVertical(context: context) * 2,
          ),
          decoration: BoxDecoration(
            borderRadius: ConstantData.borderRadius,
            color: ConstantData.tileColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ConstantWidgets().customText(
                    value: userModel.phoneNo,
                    fontSize: font18Px(context: context),
                    fontWeight: FontWeight.w500,
                    color: ConstantData.mainTextColor,
                  ),
                  if (userModel.registerationStatus ==
                      RegisterationStatus.COMPLETE)
                    ConstantWidgets().customText(
                      value: userModel.status,
                      fontSize: font15Px(context: context),
                      fontWeight: FontWeight.w600,
                      color: (userModel.status == 'Approved')
                          ? ConstantData.primaryColor
                          : Colors.red,
                    ),
                ],
              ),
              Offstage(
                offstage: (userModel.registerationStatus ==
                        RegisterationStatus.COMPLETE &&
                    userModel.status != 'Approved'),
                child: InkWell(
                  onTap: () async {
                    switch (userModel.registerationStatus) {
                      case RegisterationStatus.INITAL:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => RegisterEditInfoScreen(
                              userModel: userModel,
                            ),
                          ),
                        );

                        break;
                      case RegisterationStatus.COMPLETE:
                        final productController = Get.find<ProductController>();
                        productController.firmId.value = userModel.firmId;
                        await productController.init();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ProductScreenA(),
                          ),
                        );
                        break;
                      case RegisterationStatus.LINK:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => OTPScreen(
                              contact: userModel.phoneNo,
                            ),
                          ),
                        );
                        break;
                      case RegisterationStatus.NON:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => OTPScreen(
                              contact: userModel.phoneNo,
                            ),
                          ),
                        );
                        break;
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: blockSizeHorizontal(context: context) * 4,
                      vertical: blockSizeVertical(context: context),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: ConstantData.borderRadius,
                      color: ConstantData.primaryColor,
                    ),
                    child: Text(
                      userModel.status.getUser(userModel),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: font15Px(context: context),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
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

extension GetUserStatus on String {
  String getUser(UserModel model) {
    switch (model.registerationStatus) {
      case RegisterationStatus.INITAL:
        return 'Add Details';
      case RegisterationStatus.COMPLETE:
        return 'Order Now';
      case RegisterationStatus.LINK:
        return 'Register';
      case RegisterationStatus.NON:
        return 'Register';
    }
  }
}

class ChipTile extends StatelessWidget {
  const ChipTile({
    Key? key,
    required this.func,
    required this.label,
    this.color,
  }) : super(key: key);

  final String label;
  final VoidCallback func;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: func,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: blockSizeVertical(context: context) * 1.5,
        ),
        decoration: BoxDecoration(
          color: color ?? const Color(0xffCBDFE1),
          borderRadius: BorderRadius.circular(
            font25Px(context: context),
          ),
          border: Border.all(
            color: ConstantData.clrBorder,
            width: 1.5,
          ),
        ),
        child: ConstantWidgets().customText(
          value: label,
          fontSize: font15Px(context: context),
          color: (color != null)
              ? ConstantData.bgColor
              : ConstantData.mainTextColor,
          fontWeight: FontWeight.w600,
          alignment: TextAlign.center,
        ),
      ),
    );
  }
}

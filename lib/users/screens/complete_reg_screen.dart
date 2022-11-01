// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medrpha_trial/products/controller/product_controller.dart';
import 'package:medrpha_trial/products/screens/product_screenA.dart';
import 'package:medrpha_trial/users/screens/user_info_screen.dart';
import 'package:medrpha_trial/users/screens/user_list_screen.dart';

import '../../enums/mr_type.dart';
import '../../utils/constant_data.dart';
import '../../utils/size_config.dart';
import '../../utils/storage.dart';
import '../../utils/wigets.dart';
import '../controller/users_mr_controller.dart';
import '../models/user_model.dart';

class CompleteRegScreen extends StatelessWidget {
  const CompleteRegScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UserMRController>();
    final mrType = mrTypefromValue(type: DataStorage().reademrType() ?? '2');
    return Scaffold(
      appBar: ConstantWidgets().customAppBar(
        title: 'Home',
        context: context,
        leading: const SizedBox(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: blockSizeHorizontal(context: context) * 4,
          vertical: blockSizeVertical(context: context) * 2,
        ),
        child: Obx(() {
          List<UserModel> usersList = <UserModel>[];
          usersList
            ..clear()
            ..addAll(controller.usersList);
          return Column(
            children: [
              if (mrTypefromValue(type: DataStorage().mrtype) ==
                  MRType.EXECUTIVE)
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
                            return CompleteRegTile(
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
    );
  }
}

class CompleteRegTile extends StatelessWidget {
  const CompleteRegTile({
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
          // ignore: use_build_context_synchronously
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
              Text(
                userModel.phoneNo,
                style: TextStyle(
                  color: ConstantData.mainTextColor,
                  fontSize: font18Px(context: context) * 1.1,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  borderRadius: ConstantData.borderRadius,
                  color: ConstantData.primaryColor,
                ),
                child: TextButton(
                  onPressed: () async {
                    final productController = Get.put(ProductController());
                    productController.firmId.value = userModel.firmId;
                    await productController.init();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ProductScreenA(),
                      ),
                    );
                  },
                  child: Text(
                    "Order Now",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: font12Px(context: context) * 1.1,
                        fontWeight: FontWeight.w700),
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

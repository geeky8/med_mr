import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medrpha_trial/enums/store_state.dart';
import 'package:medrpha_trial/users/controller/users_mr_controller.dart';
import 'package:medrpha_trial/users/utils/register_edit_tiles.dart';
import 'package:medrpha_trial/utils/constant_data.dart';
import 'package:medrpha_trial/utils/size_config.dart';
import 'package:medrpha_trial/utils/wigets.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final phoneController = TextEditingController();

  int option = 1;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserMRController());

    return Scaffold(
      appBar: ConstantWidgets().customAppBar(
        title: 'Create Account',
        context: context,
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: blockSizeHorizontal(context: context) * 5,
        ),
        child: SizedBox(
          height: getScreenPercentSize(context, 11),
          child: ConstantWidgets().customButton(
            context: context,
            onPressed: () async {
              if (option == 2) {
                await controller.initiateRegsiteration(
                    contact: phoneController.text.trim(), context: context);
              } else {
                await controller.getOTP(
                    contact: phoneController.text.trim(), context: context);
              }
            },
            radius: font25Px(context: context),
            text: (option == 1) ? 'OTP' : 'Send link',
            fontSize: font18Px(context: context),
            fontWeight: FontWeight.w700,
            padding: EdgeInsets.symmetric(
              vertical: blockSizeVertical(context: context) * 2,
            ),
            textColor: ConstantData.bgColor,
            color: ConstantData.primaryColor,
          ),
        ),
      ),
      body: Obx(
        () => Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: blockSizeHorizontal(context: context) * 6,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RegsiterEditTiles(
                    label: 'Phone Number',
                    crossAxisAlignment: CrossAxisAlignment.start,
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    padding: EdgeInsets.zero,
                    validatorCallBack: (value) {
                      if (value != null) {
                        if (value.isEmpty) return 'Required';
                        if (value.length != 10) return 'Invalid number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: blockSizeVertical(context: context) * 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OptionsTile(
                        option: option,
                        onTap: () {
                          setState(() {
                            option = 1;
                          });
                        },
                        value: 1,
                        label: 'Get OTP',
                      ),
                      OptionsTile(
                        option: option,
                        onTap: () {
                          setState(() {
                            option = 2;
                          });
                        },
                        value: 2,
                        label: 'Send link',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (controller.state.value == StoreState.LOADING)
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

class OptionsTile extends StatelessWidget {
  const OptionsTile({
    Key? key,
    required this.option,
    required this.onTap,
    required this.value,
    required this.label,
  }) : super(key: key);

  final int option;
  final VoidCallback onTap;
  final int value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: ConstantData.mainTextColor),
              shape: BoxShape.circle,
            ),
            padding: EdgeInsets.all(blockSizeHorizontal(context: context) / 4),
            child: Icon(
              Icons.circle,
              color: (option == value)
                  ? ConstantData.primaryColor
                  : ConstantData.bgColor,
              size: font12Px(context: context) * 1.1,
            ),
          ),
        ),
        SizedBox(
          width: blockSizeHorizontal(context: context) * 2,
        ),
        ConstantWidgets().customText(
          value: label,
          fontSize: font15Px(context: context) * 1.1,
          color: ConstantData.mainTextColor,
          fontWeight: FontWeight.w600,
        ),
      ],
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medrpha_trial/enums/store_state.dart';
import 'package:medrpha_trial/users/controller/users_mr_controller.dart';
import 'package:medrpha_trial/utils/constant_data.dart';
import 'package:medrpha_trial/utils/size_config.dart';
import 'package:medrpha_trial/utils/wigets.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({required this.contact, super.key});

  final String contact;

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  int seconds = 60;
  late Timer _timer;
  String otpTimer = 'Resend OTP in 00:';
  String otp = '';

  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      print(timer.tick);
      if (mounted) {
        setState(() {
          seconds--;
          otpTimer = 'Resend OTP in 00:$seconds';
        });
      }
      if (seconds == 0) {
        otpTimer = 'Resend';
        _timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserMRController());

    return Scaffold(
      appBar:
          ConstantWidgets().customAppBar(title: 'Enter Code', context: context),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: blockSizeHorizontal(context: context) * 5,
        ),
        child: SizedBox(
          height: getScreenPercentSize(context, 14),
          child: Column(
            children: [
              ConstantWidgets().customButton(
                context: context,
                onPressed: () async {
                  await controller.verifyOTP(
                    contact: widget.contact,
                    otp: otp,
                    context: context,
                  );
                },
                radius: font25Px(context: context),
                text: 'Confirm',
                fontSize: font18Px(context: context),
                fontWeight: FontWeight.w700,
                padding: EdgeInsets.symmetric(
                  vertical: blockSizeVertical(context: context) * 2,
                ),
                textColor: ConstantData.bgColor,
                color: ConstantData.primaryColor,
              ),
              InkWell(
                onTap: () async {
                  if (seconds == 0) {
                    await controller.getOTP(
                      contact: widget.contact,
                      context: context,
                      resend: true,
                    );
                  }
                },
                child: ConstantWidgets().customText(
                  value: otpTimer,
                  fontSize: font15Px(context: context),
                  color: ConstantData.clrBorder,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
      ),
      body: Obx(
        () => Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: blockSizeHorizontal(context: context) * 4,
                vertical: blockSizeVertical(context: context) * 6,
              ),
              child: Column(
                children: [
                  ConstantWidgets().customText(
                    value:
                        'Enter verification code sent to the number +91********${widget.contact.substring(8)}',
                    fontSize: font18Px(context: context) * 1.1,
                    color: ConstantData.clrBorder,
                    fontWeight: FontWeight.w600,
                    maxLines: 2,
                    alignment: TextAlign.center,
                  ),
                  SizedBox(height: blockSizeVertical(context: context) * 3),
                  PinCodeTextField(
                    appContext: context,
                    length: 4,
                    keyboardType: TextInputType.number,
                    onCompleted: (value) {
                      setState(() {
                        otp = value;
                      });
                      FocusScope.of(context).unfocus();
                    },
                    onChanged: (value) {},
                    pinTheme: PinTheme(
                      activeColor: ConstantData.primaryColor,
                      inactiveColor: Colors.black54,
                      inactiveFillColor: Colors.grey,
                      activeFillColor: ConstantData.clrBorder,
                      selectedColor: ConstantData.primaryColor,
                      shape: PinCodeFieldShape.box,
                      errorBorderColor: ConstantData.mainTextColor,
                      borderRadius:
                          BorderRadius.circular(font15Px(context: context)),
                      fieldWidth: screenWidth(context: context) / 7,
                    ),
                  ),
                ],
              ),
            ),
            if (controller.state.value == StoreState.LOADING)
              Container(
                decoration: BoxDecoration(
                  color: ConstantData.clrBorder.withOpacity(0.5),
                ),
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              )
          ],
        ),
      ),
    );
  }
}

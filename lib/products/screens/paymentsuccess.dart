import 'package:flutter/material.dart';
import 'package:medrpha_trial/utils/constant_data.dart';
import 'package:medrpha_trial/utils/wigets.dart';

class PaymentSuccess extends StatelessWidget {
  const PaymentSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ConstantWidgets()
          .customAppBar(title: "Payment Success", context: context),
      body: Container(
        color: ConstantData.bgColor,
        child: Center(
          child: ConstantWidgets()
              .headerText(context: context, value: "Thank You"),
        ),
      ),
    );
  }
}

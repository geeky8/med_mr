import 'package:flutter/material.dart';
import 'package:medrpha_trial/products/utils/bottombtn.dart';
import 'package:medrpha_trial/utils/constant_data.dart';
import 'package:medrpha_trial/utils/size_config.dart';
import 'package:medrpha_trial/utils/wigets.dart';

class PaymentSuccess extends StatelessWidget {
  const PaymentSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ConstantWidgets()
          .customAppBar(title: "Payment Success", context: context),
      body: Container(
        padding: EdgeInsets.symmetric(
            horizontal: blockSizeHorizontal(context: context) * 3),
        color: ConstantData.bgColor,
        child: Column(
          children: [
            Expanded(
              child: Image.asset(
                '${ConstantData.assetsPath}thankyou.png',
                fit: BoxFit.fitWidth,
              ),
            ),
            ConstantWidgets().customText(
              value: "Thanks For the Order",
              fontSize: font22Px(context: context),
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: blockSizeVertical(context: context) * 2),
              child: ConstantWidgets().customText(
                value:
                    "We have already started collecting it.\nIt will be delivered soon.",
                fontSize: font18Px(context: context),
                fontWeight: FontWeight.w300,
                color: Colors.grey,
                alignment: TextAlign.center,
              ),
            ),
            SizedBox(
              height: blockSizeVertical(context: context) * 10,
            ),
            BottomButton(
              onTap: () {
                Navigator.of(context).pop();
              },
              text: "Back to Order",
            ),
          ],
        ),
      ),
    );
  }
}

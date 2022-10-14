import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medrpha_trial/products/controller/product_controller.dart';
import 'package:medrpha_trial/products/screens/paymentsuccess.dart';
import 'package:medrpha_trial/products/utils/bottombtn.dart';
import 'package:medrpha_trial/utils/size_config.dart';

import '../../utils/constant_data.dart';
import '../../utils/wigets.dart';

class PaymentSelection extends StatefulWidget {
  const PaymentSelection({Key? key}) : super(key: key);

  @override
  State<PaymentSelection> createState() => _PaymentSelectionState();
}

class _PaymentSelectionState extends State<PaymentSelection> {
  late String selectedPaymentOption;
  final ProductController pcontroller = Get.find();

  final List<String> paymentOptions = [
    "Online Payment",
    "Pay on Delivery",
    "Pay Later",
  ];

  @override
  void initState() {
    selectedPaymentOption = paymentOptions[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ConstantWidgets().customAppBar(
        title: "Payment",
        context: context,
        centerTitle: true,
      ),
      body: Container(
        color: ConstantData.bgColor,
        child: Column(
          children: [
            Padding(
              padding:
                  EdgeInsets.all(blockSizeHorizontal(context: context) * 7),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ConstantWidgets().customText(
                        value:
                            "${pcontroller.cartModel.value.productList.length} item in the cart",
                        fontSize: font18Px(context: context),
                        color: Colors.grey,
                        fontWeight: FontWeight.w300,
                      ),
                      Column(
                        children: [
                          ConstantWidgets().customText(
                            value: "Total",
                            fontSize: font18Px(context: context),
                            color: Colors.grey,
                            fontWeight: FontWeight.w300,
                          ),
                          ConstantWidgets().customText(
                            value:
                                "Rs ${pcontroller.cartModel.value.totalSalePrice}",
                            fontSize: font18Px(context: context) * 1.1,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: blockSizeHorizontal(context: context) * 5),
                    child: ConstantWidgets().customText(
                      value: "Payment Options",
                      fontSize: font18Px(context: context) * 1.2,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(color: Colors.black.withOpacity(0.3)),
                    ),
                    child: Column(
                      children: [
                        paymentOptionTile(
                            context, paymentOptions[0], "online_payment.png"),
                        paymentOptionTile(
                            context, paymentOptions[1], "pay_on_delivery.png"),
                        paymentOptionTile(
                            context, paymentOptions[2], "pay_later.png"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(child: SizedBox()),
            BottomButton(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const PaymentSuccess()));
              },
              text: "Proceed",
            ),
          ],
        ),
      ),
    );
  }

  ListTile paymentOptionTile(
      BuildContext context, String paymentType, String imgName) {
    return ListTile(
      onTap: (() {
        setState(() {
          selectedPaymentOption = paymentType;
        });
      }),
      leading: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Colors.black.withOpacity(0.3),
          ),
        ),
        width: 30,
        height: 30,
        child: Image.asset(
          '${ConstantData.assetsPath}$imgName',
          fit: BoxFit.contain,
        ),
      ),
      title: ConstantWidgets().customText(
        value: paymentType,
        fontSize: font18Px(context: context),
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
      trailing: Radio<String>(
        value: paymentType,
        groupValue: selectedPaymentOption,
        onChanged: (value) {
          setState(() {
            selectedPaymentOption = paymentType;
          });
        },
      ),
    );
  }
}

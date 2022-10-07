import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medrpha_trial/products/enums/category_type.dart';
import 'package:medrpha_trial/products/models/product_model.dart';
import 'package:medrpha_trial/products/screens/payment_selection.dart';
import 'package:medrpha_trial/products/utils/bottombtn.dart';
import 'package:medrpha_trial/products/utils/cartitem_buttons.dart';
import 'package:medrpha_trial/utils/constant_data.dart';
import 'package:medrpha_trial/utils/size_config.dart';
import 'package:medrpha_trial/utils/wigets.dart';

class CheckoutScreen extends StatelessWidget {
  CheckoutScreen({required this.checkoutList, Key? key}) : super(key: key);
  final List<ProductModel> checkoutList;
  final DELIVERY_CHARGES = 40;
  late int totalPrize;

  @override
  Widget build(BuildContext context) {
    totalPrize = checkoutList.fold(
      0,
      (previousValue, element) =>
          previousValue + element.cartQuantity! * int.parse(element.newMrp),
    );
    return Scaffold(
      appBar: ConstantWidgets().customAppBar(
        title: "Checkout",
        context: context,
        centerTitle: true,
      ),
      body: Container(
        color: ConstantData.bgColor,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: blockSizeHorizontal(context: context) * 4),
                child: ListView.separated(
                  itemCount: checkoutList.length + 1,
                  separatorBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              blockSizeHorizontal(context: context) * 4),
                      child: const Divider(
                        thickness: 2,
                      ),
                    );
                  },
                  itemBuilder: (BuildContext context, int index) {
                    if (index > checkoutList.length - 1) {
                      return Container();
                    }
                    return CheckoutItemTile(product: checkoutList[index]);
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: blockSizeHorizontal(context: context) * 4),
              child: Column(
                children: [
                  amountsTile(
                    context,
                    "Total",
                    totalPrize,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: blockSizeVertical(context: context) * 1.5,
                    ),
                    child: amountsTile(context, "Delivery", DELIVERY_CHARGES),
                  ),
                  const Divider(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: blockSizeVertical(context: context) * 2,
                    ),
                    child: amountsTile(
                      context,
                      "Amount to Pay",
                      totalPrize + DELIVERY_CHARGES,
                      isBold: true,
                    ),
                  ),
                ],
              ),
            ),
            BottomButton(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PaymentSelection(
                          amountToBePaid: totalPrize + DELIVERY_CHARGES,
                          itemInCart: checkoutList.length),
                    ),
                  );
                },
                text: "Confirm"),
          ],
        ),
      ),
    );
  }

  Row amountsTile(BuildContext context, String type, int amount,
      {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ConstantWidgets().customText(
          value: type,
          color: isBold ? Colors.black : Colors.grey,
          fontSize: isBold
              ? font18Px(context: context) * 1.1
              : font15Px(context: context),
          fontWeight: isBold ? FontWeight.w500 : FontWeight.w200,
        ),
        ConstantWidgets().customText(
          value: '\$${amount.toString()}',
          color: isBold ? Colors.black : Colors.grey,
          fontSize: isBold
              ? font18Px(context: context) * 1.1
              : font15Px(context: context),
          fontWeight: isBold ? FontWeight.w500 : FontWeight.w200,
        ),
      ],
    );
  }
}

class CheckoutItemTile extends StatefulWidget {
  final ProductModel product;
  const CheckoutItemTile({required this.product, Key? key}) : super(key: key);

  @override
  State<CheckoutItemTile> createState() => _CheckoutItemTileState();
}

class _CheckoutItemTileState extends State<CheckoutItemTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(blockSizeHorizontal(context: context) * 4),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Image.asset(
              "${ConstantData.assetsPath}${widget.product.productImg}",
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: screenWidth(context: context) / 2,
                  child: ConstantWidgets().customText(
                    value: widget.product.productName,
                    fontSize: font15Px(context: context),
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: blockSizeHorizontal(context: context) * 3,
                  ),
                  child: ConstantWidgets().customText(
                    value: 'Qty : ${widget.product.cartQuantity}',
                    fontSize: font15Px(context: context),
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          ConstantWidgets().customText(
            value:
                "\$${int.parse(widget.product.newMrp) * (widget.product.cartQuantity!)}",
            fontSize: font18Px(context: context) * 1.1,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }
}
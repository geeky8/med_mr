import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medrpha_trial/products/controller/product_controller.dart';
import 'package:medrpha_trial/products/models/cart_model.dart';
import 'package:medrpha_trial/products/models/product_model.dart';
import 'package:medrpha_trial/products/screens/checkout.dart';
import 'package:medrpha_trial/products/utils/bottombtn.dart';
import 'package:medrpha_trial/products/utils/cartitem_buttons.dart';
import 'package:medrpha_trial/utils/constant_data.dart';
import 'package:medrpha_trial/utils/size_config.dart';
import 'package:medrpha_trial/utils/wigets.dart';

class CartScreen extends StatelessWidget {
  CartScreen({Key? key}) : super(key: key);
  final ProductController pcontroller = Get.find();
  late CartModel cart;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: ConstantWidgets().customAppBar(
        title: "Cart",
        context: context,
        centerTitle: true,
      ),
      body: Container(
        color: ConstantData.bgColor,
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                cart = pcontroller.cartModel.value;
                if (cart.productList.isEmpty) {
                  return const Center(
                    child: Text("Cart is empty"),
                  );
                }
                return ListView.separated(
                  itemCount: pcontroller.cartModel.value.productList.length,
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
                    return CartItemTile(
                      product: pcontroller.cartModel.value.productList[index],
                    );
                  },
                );
              }),
            ),
            BottomButton(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CheckoutScreen(),
                  ),
                );
              },
              text: "Checkout",
            ),
          ],
        ),
      ),
    );
  }
}

class CartItemTile extends StatefulWidget {
  final ProductModel product;
  const CartItemTile({required this.product, Key? key}) : super(key: key);

  @override
  State<CartItemTile> createState() => _CartItemTileState();
}

class _CartItemTileState extends State<CartItemTile> {
  final ProductController pcontroller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        IconButton(
            onPressed: () {
              pcontroller.removeFromCart(
                  model: widget.product, context: context);
            },
            icon: const Icon(Icons.delete_outline_outlined)),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: blockSizeVertical(context: context) * 10),
                child: Image.network(
                  "${ConstantData.productUrl}${widget.product.productImg}",
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        right: blockSizeHorizontal(context: context) * 35),
                    child: ConstantWidgets().customText(
                      value: widget.product.productName,
                      fontSize: font15Px(context: context),
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      maxLines: 2,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: blockSizeHorizontal(context: context) * 3,
                    ),
                    child: ConstantWidgets().customText(
                      value: 'In Stock : ${widget.product.quantity}',
                      fontSize: font15Px(context: context),
                      color: ConstantData.primaryColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ConstantWidgets().customText(
                        value:
                            "Rs ${double.parse(widget.product.newMrp) * (widget.product.cartQuantity!)}",
                        fontSize: font18Px(context: context) * 1.1,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: blockSizeHorizontal(context: context) * 3,
                        ),
                        child: CartItemButtons(
                          maxQuantity: int.parse(widget.product.quantity),
                          itemquantity: widget.product.cartQuantity!,
                          callbackAdd: (() async {
                            await pcontroller.plusToCart(
                                model: widget.product, context: context);
                          }),
                          callbackSub: (() async {
                            await pcontroller.minusToCart(
                                model: widget.product, context: context);
                          }),
                          callbackVal: ((int n) async {
                            await pcontroller.updateCartQunatity(
                                model: widget.product,
                                value: n.toString(),
                                context: context);
                          }),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}

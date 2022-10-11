import 'package:flutter/material.dart';
import 'package:medrpha_trial/products/models/product_model.dart';
import 'package:medrpha_trial/products/screens/checkout.dart';
import 'package:medrpha_trial/products/utils/bottombtn.dart';
import 'package:medrpha_trial/products/utils/cartitem_buttons.dart';
import 'package:medrpha_trial/utils/constant_data.dart';
import 'package:medrpha_trial/utils/size_config.dart';
import 'package:medrpha_trial/utils/wigets.dart';

class CartScreen extends StatelessWidget {
  CartScreen({Key? key}) : super(key: key);
  List<ProductModel> cartList = [];

  @override
  Widget build(BuildContext context) {
    if (cartList.isEmpty) {
      for (var i = 0; i < 3; i++) {
        cartList.add(
          ProductModel(
            pid: i.toString(),
            wpid: i.toString(),
            priceId: i.toString(),
            salePrice: "500",
            productImg: "product.png",
            productName: "this is my product 200ml nice bottle",
            category: "Elopathy",
            company: "company",
            newMrp: "500",
            oldMrp: "600",
            percentDiscount: "40",
            saleQtyType: "saleQtyType",
            prodSaleTypeDetails: "prodSaleTypeDetails",
            quantity: "200",
            cartQuantity: 5,
            mrp: "500",
            subTotal: "subTotal",
            expiryDate: "expiryDate",
            description:
                "this is a nive des of the medicine this ia bery good medicine",
            totalQtyPrice: "totalQtyPrice",
          ),
        );
      }
    }
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
              child: ListView.separated(
                itemCount: cartList.length,
                separatorBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: blockSizeHorizontal(context: context) * 4),
                    child: const Divider(
                      thickness: 2,
                    ),
                  );
                },
                itemBuilder: (BuildContext context, int index) {
                  return CartItemTile(list: cartList, index: index);
                },
              ),
            ),
            BottomButton(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        CheckoutScreen(checkoutList: cartList),
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
  List<ProductModel> list;
  final int index;
  CartItemTile({required this.list, required this.index, Key? key})
      : super(key: key);

  @override
  State<CartItemTile> createState() => _CartItemTileState();
}

class _CartItemTileState extends State<CartItemTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        IconButton(
            onPressed: () {}, icon: const Icon(Icons.delete_outline_outlined)),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Image.asset(
                "${ConstantData.assetsPath}${widget.list[widget.index].productImg}",
                fit: BoxFit.cover,
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
                      value: widget.list[widget.index].productName,
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
                      value: 'In Stock : ${widget.list[widget.index].quantity}',
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
                            "\$${int.parse(widget.list[widget.index].newMrp) * (widget.list[widget.index].cartQuantity!)}",
                        fontSize: font18Px(context: context) * 1.1,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: blockSizeHorizontal(context: context) * 3,
                        ),
                        child: CartItemButtons(
                          maxQuantity: int.parse(widget.list[widget.index].quantity),
                          itemquantity: widget.list[widget.index].cartQuantity!,
                          callback: (int num) {
                            final temp = widget.list[widget.index];
                            widget.list[widget.index] =
                                temp.copyWith(cartQuantity: num);
                            setState(() {});
                          },
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

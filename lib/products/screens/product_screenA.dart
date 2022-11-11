import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:medrpha_trial/dashboard/screens/dashboardscreen.dart';
import 'package:medrpha_trial/products/enums/category_type.dart';
import 'package:medrpha_trial/products/models/category_model.dart';
import 'package:medrpha_trial/products/models/product_model.dart';
import 'package:medrpha_trial/products/screens/cart_screen.dart';
import 'package:medrpha_trial/products/screens/seach_screen.dart';
import 'package:medrpha_trial/products/utils/cartitem_buttons.dart';
import 'package:medrpha_trial/utils/constant_data.dart';
import 'package:medrpha_trial/utils/size_config.dart';
import 'package:medrpha_trial/utils/wigets.dart';

import '../controller/product_controller.dart';
import '../enums/home_state.dart';

class ProductScreenA extends StatefulWidget {
  const ProductScreenA({Key? key}) : super(key: key);

  @override
  State<ProductScreenA> createState() => _ProductScreenAState();
}

class _ProductScreenAState extends State<ProductScreenA> {
  // List of items in our dropdown menu
  @override
  void initState() {
    categoryList = pcontroller.categoryList;
    super.initState();
  }

  final ProductController pcontroller = Get.find();

  late List<ProductModel> productItem;

  late List<CategoryModel> categoryList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstantData.bgColor,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back,color: Colors.black,),
        ),
        centerTitle: true,
        title: SizedBox(
          height: getScreenPercentSize(context, 6),
          width: getWidthPercentSize(context, 35),
          child: Image.asset(
            '${ConstantData.assetsPath}med_logo_text.png',
            fit: BoxFit.fill,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: blockSizeHorizontal(context: context) * 4,
            ),
            child: InkWell(
              child: Stack(
                children: [
                  /// Cart-Icon
                  Align(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.shopping_cart,
                      color: ConstantData.mainTextColor,
                      size: font22Px(context: context),
                    ),
                  ),

                  /// No of items in cart
                  Padding(
                    padding: EdgeInsets.only(
                      left: blockSizeHorizontal(context: context) * 3,
                      top: blockSizeHorizontal(context: context),
                    ),
                    child: Obx(() {
                      return Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          // alignment: Alignment.center,
                          padding: EdgeInsets.all(
                              blockSizeVertical(context: context) / 1.5),
                          decoration: BoxDecoration(
                            color: ConstantData.primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: ConstantWidgets().customText(
                            value: pcontroller
                                .cartModel.value.productList.length
                                .toString(),
                            fontSize: font12Px(context: context),
                            color: ConstantData.bgColor,
                            fontWeight: FontWeight.w600,
                            alignment: TextAlign.center,
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => CartScreen()));
              },
            ),
          )
        ],
        backgroundColor: ConstantData.bgColor,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: blockSizeHorizontal(context: context) * 4,
          vertical: blockSizeVertical(context: context) * 2,
        ),
        child: Column(
          children: [
            SeachBar(
              onTap: () {
                pcontroller.searchList.clear();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SeachScreen(),
                  ),
                );
              },
            ),
            SizedBox(
              height: blockSizeVertical(context: context) * 2,
            ),
            Obx(() {
              return dropDownSelection(context);
            }),
            Obx(() {
              switch (pcontroller.currCategory.value) {
                case CategoriesType.ETHICAL:
                  productItem = pcontroller.ethicalProductList;
                  break;
                case CategoriesType.GENERIC:
                  productItem = pcontroller.genericProductList;
                  break;
                case CategoriesType.SURGICAL:
                  productItem = pcontroller.surgicalProductList;
                  break;
                case CategoriesType.VETERINARY:
                  productItem = pcontroller.veterinaryProductList;
                  break;
                case CategoriesType.AYURVEDIC:
                  productItem = pcontroller.ayurvedicProductList;
                  break;
                case CategoriesType.GENERAL:
                  productItem = pcontroller.generalProductList;
                  break;
              }
              switch (pcontroller.homeState.value) {
                //switch cases to add list

                case HomeState.LOADING:
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                case HomeState.SUCCESS:
                  return Flexible(
                    child: productItem.isEmpty
                        ? const Center(
                            child: Text("No items here"),
                          )
                        : GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio:
                                  (screenWidth(context: context) / 2.5) /
                                      (screenHeight(context: context) / 3.25),
                              crossAxisCount: 2,
                            ),
                            itemCount: productItem.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: EdgeInsets.all(
                                    blockSizeHorizontal(context: context) * 2),
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: kElevationToShadow[2],
                                    color: ConstantData.bgColor,
                                    borderRadius: ConstantData.borderRadius,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: ConstantData.borderRadius,
                                    child: ProductTile(
                                      product: productItem[index],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  );
              }
            }),
          ],
        ),
      ),
    );
  }

  Widget dropDownSelection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: blockSizeHorizontal(context: context) * 2,
        vertical: blockSizeVertical(context: context) * 2,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ConstantWidgets().customText(
            value: pcontroller.currCategory.value.categoryString(),
            fontSize: font18Px(context: context) * 1.1,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: blockSizeHorizontal(context: context) * 2,
              vertical: blockSizeVertical(context: context),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.withOpacity(0.6)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isDense: true,
                elevation: 2,
                borderRadius: BorderRadius.circular(12),
                style: TextStyle(
                  fontSize: font18Px(context: context),
                  fontFamily: ConstantData.fontFamily,
                  fontWeight: FontWeight.w500,
                ),
                value: pcontroller.currCategory.value.categoryString(),
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: ConstantData.secondaryColor,
                ),
                items: categoryList.map((CategoryModel items) {
                  return DropdownMenuItem(
                    value: items.categoryName,
                    child: ConstantWidgets().customText(
                      value: items.categoryName,
                      fontSize: font15Px(context: context),
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  );
                }).toList(),
                // After selecting the desired option,it will
                // change button value to selected value
                onChanged: (String? newValue) {
                  pcontroller.setCurrCategory(newValue!);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductTile extends StatelessWidget {
  final ProductModel product;
  final ProductController pcontroller = Get.find();
  ProductTile({required this.product, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //Image
        Expanded(
          child: Image.network(
            ConstantData.productUrl + product.productImg,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(blockSizeHorizontal(context: context) * 3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConstantWidgets().customText(
                value: product.productName,
                maxLines: 1,
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontSize: font12Px(context: context) * 1.1,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: ConstantWidgets().customText(
                  value: "Avl stock : ${product.quantity}",
                  color: ConstantData.textColor.withOpacity(0.9),
                  fontWeight: FontWeight.w400,
                  fontSize: font12Px(context: context),
                ),
              ),
              priceText(context),
              CartIcons(
                product: product,
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget priceText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Rs",
                      style: TextStyle(
                        fontSize: font12Px(context: context),
                        color: ConstantData.primaryColor,
                        fontFamily: ConstantData.fontFamily,
                      ),
                    ),
                    TextSpan(
                      text: product.newMrp,
                      style: TextStyle(
                          fontSize: font18Px(context: context) * 1.1,
                          color: ConstantData.primaryColor,
                          fontFamily: ConstantData.fontFamily,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 2.0,
              horizontal: 1,
            ),
            child: ConstantWidgets().customText(
              value: product.oldMrp,
              fontSize: font12Px(context: context) * 0.8,
              color: Colors.grey,
              textDecoration: TextDecoration.lineThrough,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

class CartIcons extends StatefulWidget {
  const CartIcons({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductModel product;

  @override
  State<CartIcons> createState() => _CartIconsState();
}

class _CartIconsState extends State<CartIcons> {
  bool cart = true;
  final ProductController pcontroller = Get.find();

  @override
  Widget build(BuildContext context) {
    cart = (widget.product.cartQuantity ?? 0) == 0;
    return cart
        ? addIcon(context)
        : CartItemButtons(
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
                  model: widget.product, value: n.toString(), context: context);
            }),
            maxQuantity: int.parse(widget.product.quantity),
            itemquantity: widget.product.cartQuantity ?? 0,
            trailing: Padding(
              padding: const EdgeInsets.only(left: 3),
              child: InkWell(
                onTap: () async {
                  setState(() {
                    cart = true;
                  });
                  await pcontroller.removeFromCart(
                      model: widget.product, context: context);
                },
                child: Container(
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red.withOpacity(0.2),
                  ),
                  child: const Icon(
                    Icons.close,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          );
  }

  Widget addIcon(BuildContext context) {
    return InkWell(
      onTap: () async {
        setState(() {
          cart = false;
        });
        if (pcontroller.cartModel.value.productList
                .indexWhere((element) => element.pid == widget.product.pid) ==
            -1) {
          await pcontroller.addToCart(model: widget.product, context: context);
        } else {
          Fluttertoast.showToast(msg: "Already in cart");
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: ConstantData.borderRadius,
          color: ConstantData.primaryColor,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: blockSizeHorizontal(context: context) * 4,
              vertical: 5),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.shopping_cart_outlined,
                color: Colors.white,
                size: font15Px(context: context) * 1.1,
              ),
              const SizedBox(width: 3),
              ConstantWidgets().customText(
                value: "Add",
                color: Colors.white,
                fontSize: font12Px(context: context) * 1.1,
                fontWeight: FontWeight.normal,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

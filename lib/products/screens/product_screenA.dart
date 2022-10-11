import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:medrpha_trial/dashboard/screens/dashboardscreen.dart';
import 'package:medrpha_trial/products/models/category_model.dart';
import 'package:medrpha_trial/products/models/product_model.dart';
import 'package:medrpha_trial/products/screens/cart_screen.dart';
import 'package:medrpha_trial/products/utils/cartitem_buttons.dart';
import 'package:medrpha_trial/products/utils/category_list.dart';
import 'package:medrpha_trial/utils/constant_data.dart';
import 'package:medrpha_trial/utils/size_config.dart';
import 'package:medrpha_trial/utils/wigets.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class ProductScreenA extends StatefulWidget {
  ProductScreenA({Key? key}) : super(key: key);

  @override
  State<ProductScreenA> createState() => _ProductScreenAState();
}

class _ProductScreenAState extends State<ProductScreenA> {
  // List of items in our dropdown menu
  late String selectedCategory;
  @override
  void initState() {
    selectedCategory = categoryList[0];
    for (var i = 0; i < 11; i++) {
      productItem.add(ProductModel(
          pid: i.toString(),
          wpid: i.toString(),
          priceId: i.toString(),
          salePrice: 200.toString(),
          productImg: "${ConstantData.assetsPath}product.png",
          productName:
              "This is my medicine this is pretty good get it for cheap prize",
          category: "Ethical",
          company: "Aman",
          newMrp: "500",
          oldMrp: "600",
          percentDiscount: "10",
          saleQtyType: "250",
          prodSaleTypeDetails: "prodSaleTypeDetails",
          quantity: "100",
          cartQuantity: 0,
          mrp: "500",
          subTotal: "900",
          expiryDate: "expiryDate",
          description:
              "this is a des in dont know what to write in here so thsi is iking of a randon string that im writing over here hope u have a good rest of the day or night",
          totalQtyPrice: "1000"));
    }
    super.initState();
  }

  List<ProductModel> productItem = [];

  var categoryList = [
    'Ethical',
    'Generic',
    'Elopathy',
    'Expensive',
    'Cheap',
  ];

  List<CategoryModel> list = List<CategoryModel>.generate(
    7,
    (index) => CategoryModel(
      categoryId: 1,
      categoryName: 'Ethical',
      categoryImgUrl:
          'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg',
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstantData.bgColor,
      appBar: AppBar(
        elevation: 0,
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
                    child: Align(
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
                          value: '2',
                          fontSize: font12Px(context: context),
                          color: ConstantData.bgColor,
                          fontWeight: FontWeight.w600,
                          alignment: TextAlign.center,
                        ),
                      ),
                    ),
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
            SeachBar(),
            dropDownSelection(context),
            Flexible(
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: (screenWidth(context: context) / 2.5) /
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
                        child: ProductTile(product: productItem[index]),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dropDownSelection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: blockSizeHorizontal(context: context) * 2,
          vertical: blockSizeHorizontal(context: context) * 3.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ConstantWidgets().customText(
            value: selectedCategory,
            fontSize: font18Px(context: context) * 1.2,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: blockSizeHorizontal(context: context)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.withOpacity(0.6)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isDense: true,
                elevation: 2,
                borderRadius: BorderRadius.circular(12),
                value: selectedCategory,
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: ConstantData.secondaryColor,
                ),
                items: categoryList.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: ConstantWidgets().customText(
                      value: items,
                      fontSize: font12Px(context: context),
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  );
                }).toList(),
                // After selecting the desired option,it will
                // change button value to selected value
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCategory = newValue!;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductTile extends StatefulWidget {
  final ProductModel product;
  const ProductTile({required this.product, Key? key}) : super(key: key);

  @override
  State<ProductTile> createState() => ProductTileState();
}

class ProductTileState extends State<ProductTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //Image
        Expanded(
          child: Image.asset(
            widget.product.productImg,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(blockSizeHorizontal(context: context) * 3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConstantWidgets().customText(
                value: widget.product.productName,
                maxLines: 1,
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontSize: font12Px(context: context) * 1.1,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: ConstantWidgets().customText(
                  value: "Avl stock : ${widget.product.quantity}",
                  color: ConstantData.textColor.withOpacity(0.9),
                  fontWeight: FontWeight.w400,
                  fontSize: font12Px(context: context),
                ),
              ),
              priceText(context),
              CartIcons(product: widget.product),
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
                      text: widget.product.newMrp,
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
              value: widget.product.oldMrp,
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
  int num = 0;
  bool cart = true;

  @override
  Widget build(BuildContext context) {
    return cart
        ? addIcon(context)
        : CartItemButtons(
          maxQuantity: int.parse(widget.product.quantity),
            itemquantity: 1,
            trailing: Padding(
              padding: const EdgeInsets.only(left: 3),
              child: InkWell(
                onTap: () {
                  setState(() {
                    cart = true;
                  });
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
      onTap: () {
        setState(() {
          cart = false;
          num = 1;
        });
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

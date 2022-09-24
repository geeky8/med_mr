import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:medrpha_trial/products/enums/category_type.dart';
import 'package:medrpha_trial/products/models/category_model.dart';
import 'package:medrpha_trial/utils/constant_data.dart';
import 'package:medrpha_trial/utils/size_config.dart';
import 'package:medrpha_trial/utils/wigets.dart';

class CategoryList extends StatelessWidget {
  /// List of all categories based on [CategoryModel]
  const CategoryList({
    Key? key,
    required this.list,
    required this.sideMargin,
  }) : super(key: key);

  final List<CategoryModel> list;
  final double sideMargin;

  // Color getShadow({required String categoryName}) {
  //   final categoryType = categoriesfromValue(categoryName);
  //   switch (categoryType) {
  //     case CategoriesType.ETHICAL:
  //       if (store.ethicalProductList.isEmpty) {
  //         return ConstantData.cartColor.withOpacity(0.6);
  //       }
  //       return Colors.transparent;
  //     case CategoriesType.GENERIC:
  //       if (store.genericProductList.isEmpty) {
  //         return ConstantData.cartColor.withOpacity(0.6);
  //       }
  //       return Colors.transparent;
  //     case CategoriesType.SURGICAL:
  //       if (store.surgicalProductList.isEmpty) {
  //         return ConstantData.cartColor.withOpacity(0.6);
  //       }
  //       return Colors.transparent;
  //     case CategoriesType.VETERINARY:
  //       if (store.veterinaryProductList.isEmpty) {
  //         return ConstantData.cartColor.withOpacity(0.6);
  //       }
  //       return Colors.transparent;
  //     case CategoriesType.AYURVEDIC:
  //       if (store.ayurvedicProductList.isEmpty) {
  //         return ConstantData.cartColor.withOpacity(0.6);
  //       }
  //       return Colors.transparent;
  //     case CategoriesType.GENERAL:
  //       if (store.generalProductList.isEmpty) {
  //         return ConstantData.cartColor.withOpacity(0.6);
  //       }
  //       return Colors.transparent;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: safeBlockHorizontal(context: context) * 20,
      // margin: EdgeInsets.only(bottom: margin),
      child: ListView.builder(
        // padding: EdgeInsets.only(right: sideMargin),
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: list.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          double height = safeBlockHorizontal(context: context) * 20;

          return InkWell(
            onTap: () {},
            child: SizedBox(
              width: height,
              child: Container(
                // margin: EdgeInsets.only(left: sideMargin),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.all(
                            blockSizeHorizontal(context: context) * 3,
                          ),
                          height: getScreenPercentSize(context, 4),
                          width: getWidthPercentSize(context, 4),
                          decoration: BoxDecoration(
                            // color: ConstantData.color1,
                            border: Border.all(
                              color: ConstantData.secondaryColor,
                              width: 4,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: CachedNetworkImage(
                            imageUrl: list[index].categoryImgUrl,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: blockSizeVertical(context: context) * 2,
                        ),
                        child: ConstantWidgets().customText(
                          value: list[index].categoryName,
                          fontSize: font15Px(context: context),
                          color: ConstantData.mainTextColor,
                          fontWeight: FontWeight.w600,
                          alignment: TextAlign.start,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

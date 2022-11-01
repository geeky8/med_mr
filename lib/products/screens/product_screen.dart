import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:medrpha_trial/products/models/category_model.dart';
import 'package:medrpha_trial/products/utils/category_list.dart';
import 'package:medrpha_trial/utils/constant_data.dart';
import 'package:medrpha_trial/utils/size_config.dart';
import 'package:medrpha_trial/utils/wigets.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

//TODO: Check all alignments of Logo
class ProductScreen extends StatelessWidget {
  ProductScreen({Key? key}) : super(key: key);

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
              onTap: () {},
            ),
          )
        ],
        backgroundColor: ConstantData.bgColor,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: blockSizeHorizontal(context: context) * 4,
          vertical: blockSizeVertical(context: context) * 2,
        ),
        children: [
          ///----------------------------------- Search bar --------------------------------------------

          InkWell(
            child: Padding(
              padding: EdgeInsets.symmetric(
                // horizontal: blockSizeHorizontal(context: context) * 4,
                vertical: blockSizeVertical(context: context) * 2,
              ),
              child: SizedBox(
                width: double.infinity,
                height: getScreenPercentSize(context, 5.8),
                child: InkWell(
                  onTap: () {},
                  child: TextFormField(
                    enabled: false,
                    style: TextStyle(
                      fontFamily: ConstantData.fontFamily,
                      fontWeight: FontWeight.w400,
                    ),
                    onChanged: (value) async {
                      // await store.getSearchedResults(term: value);
                    },
                    // onFieldSubmitted: (value) async {
                    //   await store.getSearchedResults(term: value);
                    // },
                    maxLines: 1,
                    // controller: store.searchController,
                    // enabled: false,
                    textAlignVertical: TextAlignVertical.center,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      hintText: 'Find Products',
                      // prefixIcon: Icon(Icons.search),

                      prefixIcon: Icon(
                        Icons.search,
                        color: ConstantData.secondaryColor,
                        size: font25Px(context: context),
                      ),
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontFamily: ConstantData.fontFamily,
                        fontWeight: FontWeight.w300,
                        fontSize: font15Px(context: context) * 1.1,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            font22Px(context: context),
                          ),
                        ),
                        borderSide:
                            BorderSide(color: ConstantData.clrBorder, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(font22Px(context: context))),
                        borderSide:
                            BorderSide(color: ConstantData.clrBorder, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(font22Px(context: context))),
                        borderSide:
                            BorderSide(color: ConstantData.clrBorder, width: 2),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            onTap: () {},
          ),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: blockSizeVertical(context: context) * 3,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ConstantWidgets().customText(
                  value: 'Categories',
                  fontSize: font18Px(context: context) * 1.1,
                  color: ConstantData.mainTextColor,
                  fontWeight: FontWeight.w600,
                ),
                const Spacer(),
                InkWell(
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: font18Px(context: context),
                    color: ConstantData.clrBorder,
                  ),
                  onTap: () {},
                )
              ],
            ),
          ),
          SizedBox(
            height: blockSizeVertical(context: context),
          ),
          CategoryList(
            list: list,
            sideMargin: 0,
          ),
          SizedBox(
            height: blockSizeVertical(context: context) * 2,
          ),
          StickyHeader(
            header: Container(
              padding: EdgeInsets.symmetric(
                vertical: blockSizeVertical(context: context) * 3,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ConstantWidgets().customText(
                    value: 'Ethical',
                    fontSize: font18Px(context: context),
                    color: ConstantData.mainTextColor,
                    fontWeight: FontWeight.w600,
                  ),
                  const Spacer(),
                  InkWell(
                    child: ConstantWidgets().customText(
                      value: 'Explore >',
                      fontSize: font15Px(context: context),
                      color: ConstantData.clrBorder,
                      fontWeight: FontWeight.w500,
                    ),
                    onTap: () {},
                  )
                ],
              ),
            ),
            content: Container(
              child: GridView.builder(
                  itemCount: 10,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: getWidthPercentSize(context, 30) /
                        getScreenPercentSize(context, 10),
                  ),
                  itemBuilder: (_, index) {
                    return Container(
                      child: Column(
                        children: [
                          Image.asset('${ConstantData.assetsPath}product.png'),
                          SizedBox(
                            height: blockSizeVertical(context: context),
                          ),
                          ConstantWidgets().customText(
                            value: 'Avl stock : 45',
                            fontSize: font12Px(context: context),
                            color: ConstantData.mainTextColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}

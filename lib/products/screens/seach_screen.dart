import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:medrpha_trial/dashboard/screens/dashboardscreen.dart';
import 'package:medrpha_trial/products/controller/product_controller.dart';
import 'package:medrpha_trial/products/screens/product_screenA.dart';
import 'package:medrpha_trial/utils/constant_data.dart';
import 'package:medrpha_trial/utils/wigets.dart';

import '../../utils/size_config.dart';
import '../enums/home_state.dart';
import '../models/product_model.dart';
import '../utils/cartitem_buttons.dart';

class SeachScreen extends StatelessWidget {
  SeachScreen({super.key});
  final ProductController pcontroller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstantData.bgColor,
      appBar:
          ConstantWidgets().customAppBar(title: "Products", context: context),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: blockSizeHorizontal(context: context) * 4,
          vertical: blockSizeVertical(context: context) * 2,
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  bottom: blockSizeVertical(context: context) * 2),
              child: SeachBar(
                autoFocus: true,
                onChange: (a) {
                  pcontroller.getSearchedResults(term: a, load: true);
                },
              ),
            ),
            Obx(() {
              switch (pcontroller.searchState.value) {
                //switch cases to add list

                case HomeState.LOADING:
                  return const Expanded(
                      child: Center(child: CircularProgressIndicator()));
                case HomeState.SUCCESS:
                  return Flexible(
                    child: pcontroller.searchList.isEmpty
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
                            itemCount: pcontroller.searchList.length,
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
                                      product: pcontroller.searchList[index],
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
}

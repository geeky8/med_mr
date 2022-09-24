import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medrpha_trial/dashboard/controller/dashboard_controller.dart';
import 'package:medrpha_trial/utils/constant_data.dart';
import 'package:medrpha_trial/utils/size_config.dart';
import 'package:medrpha_trial/utils/wigets.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dashboardController = Get.find<DashboardController>();

    return Scaffold(
      backgroundColor: ConstantData.bgColor,
      appBar: AppBar(
        backgroundColor: ConstantData.bgColor,
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.symmetric(
            vertical: blockSizeVertical(context: context) * 2,
          ),
          child: Image.asset(
            '${ConstantData.assetsPath}med_logo_text.png',
            // width: getWidthPercentSize(
            //   context,
            //   40,
            // ),
            height: getScreenPercentSize(
              context,
              7,
            ),
            fit: BoxFit.fitWidth,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: blockSizeHorizontal(context: context) * 4,
            vertical: blockSizeVertical(context: context) * 4,
          ),
          child: Obx(
            () => (dashboardController.model.value.monthSale != null)
                ? Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: blockSizeHorizontal(context: context) * 4,
                          vertical: blockSizeVertical(context: context) * 2,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: ConstantData.clrBorder),
                          borderRadius: BorderRadius.circular(
                            font22Px(context: context),
                          ),
                        ),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ConstantWidgets().customText(
                              value: 'Statistics',
                              fontSize: font18Px(context: context) * 1.1,
                              color: ConstantData.mainTextColor,
                              fontWeight: FontWeight.w700,
                            ),
                            SizedBox(
                              height: blockSizeVertical(context: context) * 2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                StatisticsTile(
                                  image: 'sale.png',
                                  text: 'Sales',
                                  number: dashboardController
                                          .model.value.monthSaleTarget ??
                                      '',
                                ),
                                StatisticsTile(
                                  image: 'Vector.png',
                                  text: 'Installations',
                                  number: dashboardController.model.value
                                          .monthlInstallationTagert ??
                                      '',
                                ),
                              ],
                            ),
                            SizedBox(
                              height: blockSizeVertical(context: context) * 1.4,
                            ),
                            ConstantWidgets().customText(
                              value: 'Today',
                              fontSize: font18Px(context: context),
                              color: ConstantData.mainTextColor,
                              fontWeight: FontWeight.w600,
                            ),
                            SizedBox(
                              height: blockSizeVertical(context: context),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ConstantWidgets().customText(
                                  value:
                                      'Installations - ${dashboardController.model.value.monthInstall}',
                                  fontSize: font15Px(context: context) * 1.1,
                                  color: ConstantData.mainTextColor,
                                  fontWeight: FontWeight.w500,
                                ),
                                ConstantWidgets().customText(
                                  value:
                                      'Sales - ${dashboardController.model.value.monthSale}',
                                  fontSize: font15Px(context: context) * 1.1,
                                  color: ConstantData.mainTextColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      // const Spacer(),
                      SizedBox(
                        height: getScreenPercentSize(context, 15),
                      ),
                      Row(
                        children: [
                          PercentageProgressBar(
                            label: 'Monthly\nSales Target',
                            target: dashboardController
                                    .model.value.monthlInstallationTagert ??
                                '0',
                            percent: dashboardController
                                    .model.value.monthinstallPercent ??
                                '0',
                          ),
                          Spacer(),
                          PercentageProgressBar(
                            label: 'Monthly\nInstallation Target',
                            target: dashboardController
                                    .model.value.monthSaleTarget ??
                                '0',
                            percent: dashboardController
                                    .model.value.monthSalePercent ??
                                '0',
                          ),
                        ],
                      ),
                    ],
                  )
                : Center(
                    child: Image.asset('${ConstantData.assetsPath}error.png'),
                  ),
          ),
        ),
      ),
    );
  }
}

class PercentageProgressBar extends StatelessWidget {
  const PercentageProgressBar({
    Key? key,
    required this.label,
    required this.percent,
    required this.target,
  }) : super(key: key);

  final String label;
  final String target;
  final String percent;

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: getWidthPercentSize(
        context,
        22,
      ),
      animation: true,
      circularStrokeCap: CircularStrokeCap.round,
      fillColor: ConstantData.bgColor,
      progressColor: ConstantData.primaryColor,
      percent: (int.parse(percent) < 100 ? int.parse(percent) : 100) / 100,
      lineWidth: blockSizeHorizontal(context: context) * 2.8,
      center: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ConstantWidgets().customText(
            value: label,
            fontSize: font18Px(context: context),
            color: ConstantData.secondaryColor,
            fontWeight: FontWeight.w800,
            alignment: TextAlign.center,
          ),
          SizedBox(
            height: blockSizeVertical(context: context),
          ),
          ConstantWidgets().customText(
            value: target,
            fontSize: font15Px(context: context),
            color: ConstantData.primaryColor,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(
            height: blockSizeVertical(context: context) / 2,
          ),
          ConstantWidgets().customText(
            value: '$percent% completed',
            fontSize: font12Px(context: context) * 1.1,
            color: ConstantData.primaryColor,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}

class StatisticsTile extends StatelessWidget {
  const StatisticsTile(
      {Key? key, required this.image, required this.number, required this.text})
      : super(key: key);

  final String image;
  final String text;
  final String number;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(font15Px(context: context)),
          decoration: BoxDecoration(
            color: ConstantData.primaryColor,
            shape: BoxShape.circle,
          ),
          child: Image.asset(ConstantData.assetsPath + image),
        ),
        SizedBox(
          width: blockSizeHorizontal(context: context) * 3,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConstantWidgets().customText(
              value: text,
              fontSize: font15Px(context: context),
              color: ConstantData.mainTextColor,
              fontWeight: FontWeight.w400,
            ),
            ConstantWidgets().customText(
              value: number,
              fontSize: font15Px(context: context) * 1.2,
              color: ConstantData.secondaryColor,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ],
    );
  }
}

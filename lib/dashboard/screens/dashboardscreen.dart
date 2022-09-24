import 'package:flutter/material.dart';
import 'package:medrpha_trial/utils/constant_data.dart';
import 'package:medrpha_trial/utils/size_config.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

//Aman DashBoardScreen
class DashBoardScreenA extends StatelessWidget {
  const DashBoardScreenA({super.key});

  @override
  Widget build(BuildContext context) {
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
          ),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              SeachBar(),
              space(context),
              const Performace(
                sales: 720,
                installation: 500,
              ),
              space(context),
              const Statictics(
                sales: 720,
                installation: 500,
              ),
              space(context),
              const MonthlyTarge(
                sales: 500,
                salesPercentage: 78,
                installationPercentage: 32,
                installation: 250,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget space(BuildContext context) {
    return SizedBox(
      height: blockSizeVertical(context: context) * 2.5,
    );
  }
}

class SeachBar extends StatelessWidget {
  SeachBar({super.key});
  final InputBorder myBorder = OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.grey.withOpacity(0.5),
    ),
    borderRadius: BorderRadius.circular(30),
  );

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        enabledBorder: myBorder,
        border: myBorder,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        prefixIcon: Icon(
          Icons.search,
          color: ConstantData.secondaryColor,
        ),
        suffixIcon: trailingBtn(context),
        hintText: "Search",
      ),
    );
  }

  Widget trailingBtn(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          visualDensity: VisualDensity.compact,
          onPressed: () {},
          icon: Icon(
            Icons.mic_none_outlined,
            color: ConstantData.secondaryColor,
          ),
        ),
        IconButton(
          visualDensity: VisualDensity.compact,
          onPressed: () {},
          icon: Icon(
            Icons.camera_alt_outlined,
            color: ConstantData.secondaryColor,
          ),
        ),
        SizedBox(
          width: blockSizeHorizontal(context: context) * 3,
        ),
      ],
    );
  }
}

class Performace extends StatelessWidget {
  final int sales;
  final int installation;
  const Performace({required this.sales, required this.installation, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: ConstantData.borderRadius,
        color: ConstantData.primaryColor.withOpacity(0.25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 18,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: blockSizeHorizontal(context: context) * 4),
            child: tileTitle(context),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                innerTile(context, sales, "Sales"),
                const SizedBox(
                  width: 10,
                ),
                innerTile(context, installation, "Installations")
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget tileTitle(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 25,
          width: 25,
          child: Image.asset(
            "${ConstantData.assetsPath}performance.png",
            fit: BoxFit.contain,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Performance",
                style: TextStyle(
                  fontSize: font18Px(context: context) * 1.1,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "Data of past 7 days",
                style: TextStyle(
                  fontSize: font12Px(context: context),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget innerTile(BuildContext context, int num, String type) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: blockSizeVertical(context: context) * 4.2),
        decoration: BoxDecoration(
            borderRadius: ConstantData.borderRadius, color: Colors.white),
        child: Column(
          children: [
            Text(
              num.toString(),
              style: TextStyle(
                  fontSize: font25Px(context: context),
                  color: ConstantData.primaryColor),
            ),
            Text(
              type,
              style: TextStyle(
                fontSize: font15Px(context: context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Statictics extends StatelessWidget {
  final int sales;
  final int installation;
  const Statictics({required this.sales, required this.installation, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: ConstantData.borderRadius,
        color: ConstantData.primaryColor.withOpacity(0.25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(blockSizeHorizontal(context: context) * 4),
            child: tileTitle(context),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: ConstantData.borderRadius,
              ),
              child: Column(
                children: [
                  innerTile(context, sales, "Sales"),
                  const Divider(
                    thickness: 1.5,
                  ),
                  innerTile(context, installation, "Installations"),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Column tileTitle(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 25,
          width: 25,
          child: Image.asset(
            "${ConstantData.assetsPath}statistics.png",
            fit: BoxFit.contain,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            "Statistics",
            style: TextStyle(
              fontSize: font18Px(context: context) * 1.1,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget innerTile(BuildContext context, int num, String type) {
    return Row(
      children: [
        Text(
          num.toString(),
          style: TextStyle(
              fontSize: font22Px(context: context),
              color: ConstantData.secondaryColor),
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          type,
          style: TextStyle(
            fontSize: font15Px(context: context),
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

class MonthlyTarge extends StatelessWidget {
  final int sales;
  final int installation;
  final double salesPercentage;
  final double installationPercentage;
  const MonthlyTarge(
      {required this.sales,
      required this.salesPercentage,
      required this.installationPercentage,
      required this.installation,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ConstantData.primaryColor.withOpacity(0.25),
        borderRadius: ConstantData.borderRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: tileTitle(context),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: ConstantData.borderRadius,
              ),
              child: Column(
                children: [
                  innerTile(context, sales, "Sales", salesPercentage),
                  const Divider(
                    thickness: 1.5,
                  ),
                  innerTile(context, installation, "Installations",
                      installationPercentage),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Column tileTitle(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 25,
          width: 25,
          child: Image.asset(
            "${ConstantData.assetsPath}monthlytarget.png",
            fit: BoxFit.contain,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            "Monthly Target",
            style: TextStyle(
              fontSize: font18Px(context: context) * 1.1,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget innerTile(
    BuildContext context,
    int num,
    String type,
    double percentage,
  ) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                type,
                style: TextStyle(
                    fontSize: font18Px(context: context), color: Colors.grey),
              ),
              Text(
                num.toString(),
                style: TextStyle(
                  fontSize: font22Px(context: context),
                ),
              ),
            ],
          ),
          CircularPercentIndicator(
            radius: 25,
            center: Text(
              "${percentage.toInt().toString()}%",
              style: TextStyle(
                fontSize: font12Px(context: context),
              ),
            ),
            percent: percentage / 100,
          )
        ],
      ),
    );
  }
}

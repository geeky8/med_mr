import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:medrpha_trial/utils/constant_data.dart';
import 'package:medrpha_trial/utils/size_config.dart';
import 'package:medrpha_trial/utils/wigets.dart';
import 'package:http/http.dart' as http;

class Question1 extends StatefulWidget {
  const Question1({
    Key? key,
  }) : super(key: key);

  @override
  State<Question1> createState() => _Question1State();
}

class _Question1State extends State<Question1> {
  int value = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ConstantWidgets().customText(
                value: value.toString(),
                fontSize: font22Px(context: context),
                color: ConstantData.mainTextColor,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(
                height: blockSizeVertical(context: context) * 2,
              ),
              GestureDetector(
                onTap: () {
                  if (value == 0) {
                    final snackBar = ConstantWidgets()
                        .customSnackBar(text: 'Clicked', context: context);
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    setState(() {
                      value += 1;
                    });
                  }
                },
                child: Container(
                  decoration: BoxDecoration(color: ConstantData.primaryColor),
                  padding: EdgeInsets.symmetric(
                    horizontal: blockSizeHorizontal(context: context) * 4,
                    vertical: blockSizeVertical(context: context) * 2,
                  ),
                  child: ConstantWidgets().customText(
                    value: 'Tap Me',
                    fontSize: font18Px(context: context),
                    color: ConstantData.bgColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Qu extends StatefulWidget {
  const Qu({super.key});

  @override
  State<Qu> createState() => _QuState();
}

class _QuState extends State<Qu> {
  bool isAlive = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: blockSizeHorizontal(context: context) * 4,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    isAlive = !isAlive;
                  });
                },
                child: ConstantWidgets().customText(
                  value: 'Qu one',
                  fontSize: font22Px(context: context),
                  color: (isAlive) ? Colors.green : Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
              ConstantWidgets().customText(
                value: 'Alive Status : ${(isAlive) ? 'Alive' : 'Dead'}',
                fontSize: font18Px(context: context),
                color: ConstantData.mainTextColor,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Question3 extends StatefulWidget {
  const Question3({super.key});

  @override
  State<Question3> createState() => _Question3State();
}

class _Question3State extends State<Question3> {
  List<TestModel> testList = <TestModel>[];

  fetchResults() async {
    const url = 'https://dummyjson.com/products';

    final resp = await http.get(Uri.parse(url));
    if (resp.statusCode == 200) {
      if (kDebugMode) {
        print(resp.body);
      }
      final respBody = jsonDecode(resp.body) as Map<String, dynamic>;
      final products = respBody['products'] as List<dynamic>;

      for (final i in products) {
        final model = TestModel.fromJson(json: i);
        testList.add(model);
      }
      if (kDebugMode) {
        print('products fetch-------- ${testList.length}');
      }
    }

    setState(() {});
  }

  @override
  void initState() {
    fetchResults();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: (testList.isNotEmpty)
            ? Container(
                child: ListView.builder(
                  itemCount: testList.length,
                  padding: EdgeInsets.symmetric(
                    horizontal: blockSizeHorizontal(context: context) * 4,
                  ),
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: blockSizeVertical(context: context) * 2,
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: blockSizeHorizontal(context: context) * 3,
                          vertical: blockSizeVertical(context: context) * 2,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(
                            font18Px(context: context),
                          ),
                        ),
                        child: Column(
                          children: [
                            Image.network(testList[index].images),
                            SizedBox(
                              height: blockSizeVertical(context: context),
                            ),
                            ConstantWidgets().customText(
                              value: testList[index].name,
                              fontSize: font18Px(context: context),
                              color: ConstantData.mainTextColor,
                              fontWeight: FontWeight.w600,
                            ),
                            SizedBox(
                              height: blockSizeVertical(context: context),
                            ),
                            ConstantWidgets().customText(
                              value: testList[index].price.toString(),
                              fontSize: font18Px(context: context),
                              color: ConstantData.mainTextColor,
                              fontWeight: FontWeight.w600,
                            ),
                            SizedBox(
                              height: blockSizeVertical(context: context),
                            ),
                            ConstantWidgets().customText(
                              value: testList[index].discount.toString(),
                              fontSize: font18Px(context: context),
                              color: ConstantData.mainTextColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class TestModel {
  TestModel({
    required this.images,
    required this.discount,
    required this.name,
    required this.price,
  });

  factory TestModel.fromJson({required Map<String, dynamic> json}) {
    return TestModel(
      images: (json['thumbnail'] ?? '') as String,
      discount: (json['discountPercentage'] ?? 0.0) as double,
      name: (json['title'] ?? '') as String,
      price: (json['price'] ?? 0) as int,
    );
  }

  final String name;
  final int price;
  final String images;
  final double discount;
}

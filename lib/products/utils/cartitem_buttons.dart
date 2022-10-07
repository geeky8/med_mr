import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medrpha_trial/utils/wigets.dart';

import '../../utils/constant_data.dart';
import '../../utils/size_config.dart';

class CartItemButtons extends StatefulWidget {
  int num;
  final Widget? trailing;
  Function(int n)? callback;
  CartItemButtons({this.callback, this.trailing, required this.num, Key? key})
      : super(key: key);

  @override
  State<CartItemButtons> createState() => _CartItemButtonsState();
}

class _CartItemButtonsState extends State<CartItemButtons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: ConstantData.primaryColor.withOpacity(0.2),
          ),
          child: Row(
            children: [
              subtractButton(),
              InkWell(
                onTap: () {
                  TextEditingController controller =
                      TextEditingController(text: widget.num.toString());
                  itemCountDialog(context, controller);
                },
                child: ConstantWidgets().customText(
                  value: widget.num >= 1000
                      ? '${(widget.num ~/ 1000)}k'
                      : widget.num.toString(),
                  fontSize: font15Px(context: context),
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
              ),
              addButton(),
            ],
          ),
        ),
        widget.trailing ?? const SizedBox(),
      ],
    );
  }

  Padding subtractButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: InkWell(
        onTap: () {
          setState(() {
            if (widget.num - 1 >= 0) widget.num--;
            if (widget.callback != null) widget.callback!(widget.num);
          });
        },
        child: Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[300],
          ),
          child: Icon(
            Icons.remove,
            color: ConstantData.primaryColor,
          ),
        ),
      ),
    );
  }

  Padding addButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: InkWell(
        onTap: () {
          setState(() {
            widget.num++;
            if (widget.callback != null) widget.callback!(widget.num);
          });
        },
        child: Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ConstantData.primaryColor,
          ),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Future<dynamic> itemCountDialog(
      BuildContext context, TextEditingController controller) {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: ConstantWidgets().customText(
            value: "Enter Item Count",
            fontSize: font18Px(context: context),
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: controller,
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      fontFamily: ConstantData.fontFamily,
                    ),
                  ),
                  TextButton(
                    style: const ButtonStyle(
                      visualDensity: VisualDensity.comfortable,
                    ),
                    onPressed: () {
                      int temp = int.parse(controller.text);
                      if (temp < 1000000) {
                        setState(() {
                          widget.num = temp;
                        });
                        if (widget.callback != null)
                          widget.callback!(widget.num);
                        Navigator.of(context).pop();
                      } else {
                        Fluttertoast.showToast(
                            msg: "Items can't be greater than 1000000");
                      }
                    },
                    child: ConstantWidgets().customText(
                      value: "OK",
                      fontSize: font18Px(context: context),
                      color: ConstantData.primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}

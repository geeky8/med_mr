import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medrpha_trial/utils/wigets.dart';

import '../../utils/constant_data.dart';
import '../../utils/size_config.dart';

class CartItemButtons extends StatefulWidget {
  int itemquantity;
  final Widget? trailing;
  final int maxQuantity;
  final Function()? callbackAdd;
  final Function()? callbackSub;
  final Function(int n)? callbackVal;
  CartItemButtons(
      {this.callbackAdd,
      this.callbackSub,
      this.callbackVal,
      this.trailing,
      required this.itemquantity,
      required this.maxQuantity,
      Key? key})
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
          height: 25,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: ConstantData.primaryColor.withOpacity(0.2),
          ),
          child: Row(
            children: [
              subtractButton(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: InkWell(
                  onTap: () {
                    TextEditingController controller = TextEditingController(
                        text: widget.itemquantity.toString());
                    itemCountDialog(context, controller);
                  },
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      minWidth: 10,
                    ),
                    child: Center(
                      child: ConstantWidgets().customText(
                        value: widget.itemquantity >= 1000
                            ? '${(widget.itemquantity ~/ 1000)}k'
                            : widget.itemquantity.toString(),
                        fontSize: font15Px(context: context),
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
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
            if (widget.itemquantity - 1 >= 0) widget.itemquantity--;
            if (widget.callbackSub != null) widget.callbackSub!();
          });
        },
        child: Container(
          // padding: const EdgeInsets.all(3),
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
            if (widget.itemquantity + 1 <= widget.maxQuantity) {
              widget.itemquantity++;
            } else {
              Fluttertoast.showToast(
                  msg: "Only ${widget.maxQuantity} items are available");
            }
            if (widget.callbackAdd != null) widget.callbackAdd!();
          });
        },
        child: Container(
          // padding: const EdgeInsets.all(3),
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
                    onPressed: () async {
                      int temp = int.parse(controller.text);
                      if (temp <= widget.maxQuantity) {
                        setState(() {
                          widget.itemquantity = temp;
                        });
                        if (widget.callbackVal != null) {
                          widget.callbackVal!(widget.itemquantity);
                        }
                      } else {
                        Fluttertoast.showToast(
                            msg:
                                "Only ${widget.maxQuantity} items are available");
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

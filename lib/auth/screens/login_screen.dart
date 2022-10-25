import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:medrpha_trial/auth/controller/auth_controller.dart';
import 'package:medrpha_trial/auth/utils/auth_textfield.dart';
import 'package:medrpha_trial/enums/mr_type.dart';
import 'package:medrpha_trial/enums/store_state.dart';
import 'package:medrpha_trial/utils/constant_data.dart';
import 'package:medrpha_trial/utils/size_config.dart';
import 'package:medrpha_trial/utils/wigets.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final typeController = TextEditingController();

  final usernameController = TextEditingController();

  final pinController = TextEditingController();

  final typesList = List<MRType>.unmodifiable([
    MRType.EXECUTIVE,
    MRType.LEADER,
  ]);

  MRType type = MRType.EXECUTIVE;

  @override
  Widget build(BuildContext context) {
    final loginController = Get.put(AuthController());
    return Scaffold(
      body: Scaffold(
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: blockSizeHorizontal(context: context) * 5,
          ),
          child: SizedBox(
            height: getScreenPercentSize(context, 11),
            child: ConstantWidgets().customButton(
              context: context,
              onPressed: () async {
                await loginController.login(
                  username: 'mr1',
                  pass: 'mr1',
                  mrType: MRType.EXECUTIVE,
                  context: context,
                );
                
              },
              radius: font25Px(context: context),
              text: 'Login',
              fontSize: font18Px(context: context),
              fontWeight: FontWeight.w700,
              padding: EdgeInsets.symmetric(
                vertical: blockSizeVertical(context: context) * 2,
              ),
              textColor: ConstantData.bgColor,
              color: ConstantData.primaryColor,
            ),
          ),
        ),
        body: Obx(
          () => Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: blockSizeHorizontal(context: context) * 4,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: getScreenPercentSize(context, 12),
                      ),
                      Image.asset(
                        '${ConstantData.assetsPath}med_logo_text_img.png',
                        height: getScreenPercentSize(context, 30),
                        width: getWidthPercentSize(context, 60),
                      ),
                      SizedBox(
                        height: getScreenPercentSize(context, 10),
                      ),
                      // AuthTextField(
                      //   controller: typeController,
                      //   label: 'Type',
                      //   prefixIcon: Icons.calendar_today,
                      //   onTap: () {},
                      //   suffixIcon: Icons.keyboard_arrow_down,
                      // ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: blockSizeHorizontal(context: context) * 3,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: ConstantData.clrBorder),
                                  borderRadius: BorderRadius.circular(
                                    font15Px(context: context),
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                      blockSizeHorizontal(context: context) * 4,
                                  vertical:
                                      blockSizeVertical(context: context) / 2,
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_today,
                                      size: font18Px(context: context) * 1.1,
                                      color: Colors.black54,
                                    ),
                                    SizedBox(
                                      width: blockSizeHorizontal(
                                              context: context) *
                                          4,
                                    ),
                                    Expanded(
                                      child: DropdownButton<MRType>(
                                        value: type,
                                        underline: Container(),
                                        alignment:
                                            AlignmentDirectional.bottomStart,
                                        icon: const SizedBox(),
                                        iconSize: font18Px(context: context),
                                        hint: ConstantWidgets().customText(
                                          value: 'Type',
                                          fontSize: font15Px(context: context),
                                          color: ConstantData.clrBorder,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        selectedItemBuilder: (_) => typesList
                                            .map<Widget>(
                                              (element) => Center(
                                                child: ConstantWidgets()
                                                    .customText(
                                                  value: element.toText(),
                                                  fontSize: font18Px(
                                                      context: context),
                                                  color: ConstantData
                                                      .mainTextColor,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            )
                                            .toList(),
                                        items: typesList
                                            .map<DropdownMenuItem<MRType>>((e) {
                                          return DropdownMenuItem<MRType>(
                                            value: e,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: blockSizeHorizontal(
                                                        context: context) *
                                                    2,
                                                vertical: blockSizeVertical(
                                                    context: context),
                                              ),
                                              child:
                                                  ConstantWidgets().customText(
                                                value: e.toText(),
                                                fontSize:
                                                    font18Px(context: context),
                                                color:
                                                    ConstantData.mainTextColor,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            type = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    Icon(
                                      Icons.keyboard_arrow_down,
                                      size: font18Px(context: context) * 1.1,
                                      color: Colors.black54,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: blockSizeVertical(context: context) * 2,
                      ),
                      AuthTextField(
                        controller: usernameController,
                        label: 'Username',
                        prefixIcon: Icons.person_outline,
                        keyboardType: TextInputType.name,
                      ),
                      SizedBox(
                        height: blockSizeVertical(context: context) * 2,
                      ),
                      AuthTextField(
                        controller: pinController,
                        label: 'Password',
                        prefixIcon: Icons.lock_outline,
                        keyboardType: TextInputType.visiblePassword,
                      ),
                    ],
                  ),
                ),
              ),
              if (loginController.state.value == StoreState.LOADING)
                Container(
                  decoration: BoxDecoration(
                      color: ConstantData.clrBorder.withOpacity(0.5)),
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                )
            ],
          ),
        ),
      ),
    );
  }
}

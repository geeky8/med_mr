// ignore_for_file: use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medrpha_trial/enums/inital_registeration.dart';
import 'package:medrpha_trial/enums/store_state.dart';
import 'package:medrpha_trial/users/controller/users_mr_controller.dart';
import 'package:medrpha_trial/users/models/address_model.dart';
import 'package:medrpha_trial/users/models/user_model.dart';
import 'package:medrpha_trial/users/utils/image_capture_show_button.dart';
import 'package:medrpha_trial/users/utils/register_edit_tiles.dart';
import 'package:medrpha_trial/utils/constant_data.dart';
import 'package:medrpha_trial/utils/size_config.dart';
import 'package:medrpha_trial/utils/wigets.dart';
import 'package:intl/intl.dart';

class RegisterEditInfoScreen extends StatefulWidget {
  const RegisterEditInfoScreen({
    Key? key,
    this.userModel,
  }) : super(key: key);

  final UserModel? userModel;

  @override
  State<RegisterEditInfoScreen> createState() => _RegisterEditInfoScreenState();
}

class _RegisterEditInfoScreenState extends State<RegisterEditInfoScreen> {
  TextEditingController firmNameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController gstNoController = TextEditingController();
  TextEditingController validityDateController = TextEditingController();
  TextEditingController drugLicenseNoController = TextEditingController();
  TextEditingController drugLicenseNameController = TextEditingController();
  TextEditingController fssaiLicenseNoController = TextEditingController();

  String? country;
  String? state;
  String? city;
  String? area;

  String? dlImage1;
  String? dlImage2;
  String? fssaiImg;

  @override
  void initState() {
    if (widget.userModel != null) {
      firmNameController =
          TextEditingController(text: widget.userModel!.firmName);
      contactController =
          TextEditingController(text: widget.userModel!.phoneNo);
      addressController =
          TextEditingController(text: widget.userModel!.address);
      emailController = TextEditingController(text: widget.userModel!.email);
      gstNoController = TextEditingController(text: widget.userModel!.gstNo);
      validityDateController =
          TextEditingController(text: widget.userModel!.dlValidity);
      drugLicenseNoController =
          TextEditingController(text: widget.userModel!.dlNumber);
      drugLicenseNameController =
          TextEditingController(text: widget.userModel!.dlNumber);

      country =
          (widget.userModel!.country != '') ? widget.userModel!.country : null;
      state = (widget.userModel!.state != '') ? widget.userModel!.state : null;
      city = (widget.userModel!.city != '') ? widget.userModel!.city : null;
      area = (widget.userModel!.area != '') ? widget.userModel!.area : null;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UserMRController>();

    return Scaffold(
      body: Scaffold(
        appBar: ConstantWidgets().customAppBar(
          title: 'User Info',
          context: context,
        ),
        bottomNavigationBar: Obx(
          () => Padding(
            padding: EdgeInsets.symmetric(
              horizontal: blockSizeHorizontal(context: context) * 5,
            ),
            child: SizedBox(
              height: getScreenPercentSize(context, 11.5),
              child: Column(
                children: [
                  if (controller.imageState.value == StoreState.LOADING)
                    const LinearProgressIndicator(),
                  ConstantWidgets().customButton(
                    context: context,
                    onPressed: () async {
                      if (firmNameController.text.trim().isNotEmpty &&
                          contactController.text.trim().isNotEmpty &&
                          // gstNoController.text.trim().isNotEmpty &&
                          addressController.text.trim().isNotEmpty &&
                          validityDateController.text.trim().isNotEmpty &&
                          drugLicenseNoController.text
                              .trim()
                              .trim()
                              .isNotEmpty &&
                          country != null &&
                          state != null &&
                          city != null &&
                          area != null) {
                        final model = UserModel(
                          firmId: widget.userModel!.firmId,
                          firmName: firmNameController.text.trim(),
                          gstNo: gstNoController.text.trim(),
                          phoneNo: contactController.text.trim(),
                          regDate: '',
                          status: '',
                          address: addressController.text.trim(),
                          country: country ?? 'India',
                          state: state ?? 'Uttar Pradesh',
                          city: city ?? 'Aligarh',
                          area: area ?? '202002',
                          dlNumber: drugLicenseNoController.text.trim(),
                          dlValidity: validityDateController.text.trim(),
                          dlImage1: '',
                          dlImage2: '',
                          email: emailController.text.trim(),
                          registerationStatus: RegisterationStatus.COMPLETE,
                        );

                        await controller.register(
                            model: model,
                            context: context,
                            fssaiNumber: (fssaiLicenseNoController.text
                                    .trim()
                                    .isNotEmpty)
                                ? fssaiLicenseNoController.text.trim()
                                : null);
                      }
                    },
                    radius: font25Px(context: context),
                    text: 'Regsiter',
                    fontSize: font18Px(context: context),
                    fontWeight: FontWeight.w700,
                    padding: EdgeInsets.symmetric(
                      vertical: blockSizeVertical(context: context) * 2,
                    ),
                    textColor: ConstantData.bgColor,
                    color: ConstantData.primaryColor,
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Obx(() {
          debugPrint('----countries --- ${controller.countryList}');
          debugPrint('----state --- ${controller.state.value}');
          return Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: blockSizeHorizontal(context: context) * 4,
                  vertical: blockSizeVertical(context: context) * 4,
                ),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          font22Px(context: context),
                        ),
                        border: Border.all(
                          color: ConstantData.clrBorder,
                          width: 1.3,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: blockSizeVertical(context: context) * 2,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: blockSizeHorizontal(context: context) * 4,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ConstantWidgets().customText(
                              value: 'Firm Name',
                              fontSize: font18Px(context: context),
                              color: ConstantData.primaryColor,
                              fontWeight: FontWeight.w700,
                              // alignment: TextAlign.left,
                            ),
                            TextFormField(
                              controller: firmNameController,
                              autovalidateMode: AutovalidateMode.always,
                              style: TextStyle(
                                fontFamily: ConstantData.fontFamily,
                                fontSize: font18Px(context: context) * 1.1,
                                fontWeight: FontWeight.w500,
                                color: ConstantData.mainTextColor,
                              ),
                              validator: (value) {
                                if (value != null) {
                                  if (value.isEmpty) {
                                    return 'Required';
                                  } else {
                                    return null;
                                  }
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: 'Name of the firm',
                                hintStyle: TextStyle(
                                  fontFamily: ConstantData.fontFamily,
                                  fontSize: font15Px(context: context),
                                  fontWeight: FontWeight.w500,
                                  color: ConstantData.clrBorder,
                                ),
                                errorStyle: TextStyle(
                                  fontFamily: ConstantData.fontFamily,
                                  fontSize: font12Px(context: context) * 1.1,
                                  fontWeight: FontWeight.w500,
                                  color: ConstantData.secondaryColor,
                                ),
                                errorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: ConstantData.secondaryColor,
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: ConstantData.primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: blockSizeVertical(context: context) * 3,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: blockSizeVertical(context: context) * 2,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          font22Px(context: context),
                        ),
                        border: Border.all(
                            color: ConstantData.clrBorder, width: 1.2),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal:
                                  blockSizeHorizontal(context: context) * 4,
                              vertical: blockSizeVertical(context: context) * 2,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      // child: RegsiterEditTiles(
                                      //   label: 'Area',
                                      //   crossAxisAlignment: CrossAxisAlignment.start,
                                      //   controller: areaController,
                                      //   padding: EdgeInsets.only(
                                      //     right:
                                      //         blockSizeHorizontal(context: context) * 3,
                                      //   ),
                                      //   keyboardType: TextInputType.number,
                                      // ),
                                      child: CustomDropDown(
                                        list: controller.countryList,
                                        onChanged: (value) async {
                                          setState(() {
                                            country = value;
                                          });
                                          final index = controller.countryList
                                              .indexWhere((element) =>
                                                  element.name == value);
                                          await controller.getState(
                                              id: controller
                                                  .countryList[index].id);
                                        },
                                        value: country,
                                        label: 'Country',
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        validator: (value) {
                                          if (value != null) {
                                            if (value.isEmpty) {
                                              return 'Required';
                                            } else {
                                              return null;
                                            }
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: blockSizeHorizontal(
                                              context: context) *
                                          8,
                                    ),
                                    Expanded(
                                      // child: RegsiterEditTiles(
                                      //   label: 'City',
                                      //   crossAxisAlignment:
                                      //       CrossAxisAlignment.end,
                                      //   controller: cityController,
                                      //   padding: EdgeInsets.only(
                                      //     left: blockSizeHorizontal(
                                      //             context: context) *
                                      //         3,
                                      //   ),
                                      //   keyboardType: TextInputType.text,
                                      // ),
                                      child: CustomDropDown(
                                        list: controller.stateList,
                                        onChanged: (value) async {
                                          setState(() {
                                            state = value;
                                            city = null;
                                            area = null;
                                          });
                                          final index = controller.stateList
                                              .indexWhere((element) =>
                                                  element.name == value);
                                          await controller.getCities(
                                              id: controller
                                                  .stateList[index].id);
                                        },
                                        value: state,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        label: 'State',
                                        validator: (value) {
                                          if (value != null) {
                                            if (value.isEmpty) {
                                              return 'Required';
                                            } else {
                                              return null;
                                            }
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height:
                                      blockSizeVertical(context: context) * 2,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: CustomDropDown(
                                        list: controller.cityList,
                                        onChanged: (value) async {
                                          setState(() {
                                            city = value;
                                            area = null;
                                          });
                                          final index = controller.cityList
                                              .indexWhere((element) =>
                                                  element.name == value);
                                          await controller.getArea(
                                              id: controller
                                                  .cityList[index].id);
                                        },
                                        value: city,
                                        label: 'City',
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        validator: (value) {
                                          if (value != null) {
                                            if (value.isEmpty) {
                                              return 'Required';
                                            } else {
                                              return null;
                                            }
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: blockSizeHorizontal(
                                              context: context) *
                                          8,
                                    ),
                                    Expanded(
                                      child: CustomDropDown(
                                        list: controller.areaList,
                                        onChanged: (value) async {
                                          setState(() {
                                            area = value;
                                          });
                                          // final index = controller.areaList
                                          //     .indexWhere((element) =>
                                          //         element.name == value);
                                          // await controller.getCities(
                                          //     id: controller.stateList[index].id);
                                        },
                                        value: area,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        label: 'Area',
                                        validator: (value) {
                                          // print('validator$value');
                                          if (value != null) {
                                            if (value.isEmpty || value == '') {
                                              return 'Required';
                                            } else {
                                              return null;
                                            }
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: ConstantData.clrBorder,
                            thickness:
                                blockSizeHorizontal(context: context) / 4,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: blockSizeVertical(context: context) * 2,
                            ),
                            child: Column(
                              children: [
                                RegsiterEditTiles(
                                  label: 'Phone No',
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  controller: contactController,
                                  padding: EdgeInsets.symmetric(
                                    horizontal:
                                        blockSizeHorizontal(context: context) *
                                            3,
                                  ),
                                  keyboardType: TextInputType.phone,
                                  validatorCallBack: (value) {
                                    if (value != null) {
                                      if (value.isEmpty) {
                                        return 'Required';
                                      } else if (value.length != 10) {
                                        return 'Incorrect number';
                                      } else {
                                        return null;
                                      }
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height:
                                      blockSizeVertical(context: context) * 2,
                                ),
                                RegsiterEditTiles(
                                  label: 'Address',
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  controller: addressController,
                                  padding: EdgeInsets.symmetric(
                                    horizontal:
                                        blockSizeHorizontal(context: context) *
                                            3,
                                  ),
                                  keyboardType: TextInputType.streetAddress,
                                ),
                                SizedBox(
                                  height:
                                      blockSizeVertical(context: context) * 2,
                                ),
                                RegsiterEditTiles(
                                  label: 'Email',
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  keyboardType: TextInputType.emailAddress,
                                  controller: emailController,
                                  padding: EdgeInsets.symmetric(
                                    horizontal:
                                        blockSizeHorizontal(context: context) *
                                            3,
                                  ),
                                  validatorCallBack: (value) {
                                    if (value != null) {
                                      if (value.isEmpty) {
                                        return 'Required';
                                      } else if (!ConstantData.emailValidate
                                          .hasMatch(value)) {
                                        return 'Incorrect email';
                                      } else {
                                        return null;
                                      }
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height:
                                      blockSizeVertical(context: context) * 2,
                                ),
                                RegsiterEditTiles(
                                  label: 'GST No',
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  keyboardType: TextInputType.text,
                                  controller: gstNoController,
                                  padding: EdgeInsets.symmetric(
                                    horizontal:
                                        blockSizeHorizontal(context: context) *
                                            3,
                                  ),
                                  validatorCallBack: (value) {
                                    if (value != null) {
                                      if (value.isNotEmpty) {
                                        if (!ConstantData.gstValidate
                                            .hasMatch(value)) {
                                          return 'Incorrect GST No';
                                        } else {
                                          return null;
                                        }
                                      }
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height:
                                      blockSizeVertical(context: context) * 2,
                                ),
                                RegsiterEditTiles(
                                  label: 'Drug License No',
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  keyboardType: TextInputType.text,
                                  controller: drugLicenseNoController,
                                  padding: EdgeInsets.symmetric(
                                    horizontal:
                                        blockSizeHorizontal(context: context) *
                                            3,
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      blockSizeVertical(context: context) * 2,
                                ),
                                RegsiterEditTiles(
                                  label: 'Drug License Name',
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  keyboardType: TextInputType.text,
                                  controller: drugLicenseNameController,
                                  padding: EdgeInsets.symmetric(
                                    horizontal:
                                        blockSizeHorizontal(context: context) *
                                            3,
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      blockSizeVertical(context: context) * 2,
                                ),
                                RegsiterEditTiles(
                                  label: 'Validity',
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  isEnabled: true,
                                  keyboardType: TextInputType.text,
                                  controller: validityDateController,
                                  func: () async {
                                    final pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2101),
                                    );
                                    if (pickedDate != null) {
                                      final formattedDate =
                                          DateFormat('dd/MM/yyyy')
                                              .format(pickedDate);
                                      validityDateController.text =
                                          formattedDate.toString();
                                    }
                                  },
                                  padding: EdgeInsets.symmetric(
                                    horizontal:
                                        blockSizeHorizontal(context: context) *
                                            3,
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      blockSizeVertical(context: context) * 2,
                                ),
                                RegsiterEditTiles(
                                  label: 'FSSAI License No',
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  keyboardType: TextInputType.text,
                                  controller: fssaiLicenseNoController,
                                  padding: EdgeInsets.symmetric(
                                    horizontal:
                                        blockSizeHorizontal(context: context) *
                                            3,
                                  ),
                                  validatorCallBack: (value) {
                                    if (value != null) {
                                      return null;
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height:
                                      blockSizeVertical(context: context) * 3,
                                ),
                                Column(
                                  children: [
                                    ConstantWidgets().customText(
                                      value: 'DL Images',
                                      fontSize: font15Px(context: context),
                                      color: ConstantData.primaryColor,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    SizedBox(
                                      height:
                                          blockSizeVertical(context: context),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ImageCaptureShow(
                                          func: () {
                                            showModalBottomSheet(
                                              context: context,
                                              builder: (_) =>
                                                  ImageSourceBottomSheet(
                                                licenseType: 1,
                                                firmId:
                                                    widget.userModel!.firmId,
                                              ),
                                            );
                                          },
                                          label: 'DL Image 1 +',
                                        ),
                                        SizedBox(
                                          width: blockSizeHorizontal(
                                                  context: context) *
                                              4,
                                        ),
                                        ImageCaptureShow(
                                          func: () {
                                            showModalBottomSheet(
                                              context: context,
                                              builder: (_) =>
                                                  ImageSourceBottomSheet(
                                                licenseType: 2,
                                                firmId:
                                                    widget.userModel!.firmId,
                                              ),
                                            );
                                          },
                                          label: 'DL Image 2 +',
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height:
                                      blockSizeVertical(context: context) * 2,
                                ),
                                Column(
                                  children: [
                                    ConstantWidgets().customText(
                                      value: 'FSSAI Images',
                                      fontSize: font15Px(context: context),
                                      color: ConstantData.primaryColor,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    SizedBox(
                                      height:
                                          blockSizeVertical(context: context),
                                    ),
                                    ImageCaptureShow(
                                      func: () {
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (_) =>
                                              ImageSourceBottomSheet(
                                            licenseType: 3,
                                            firmId: widget.userModel!.firmId,
                                          ),
                                        );
                                      },
                                      label: 'FSSAI Image +',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (controller.state.value == StoreState.LOADING)
                Container(
                  decoration: BoxDecoration(
                      color: ConstantData.clrBorder.withOpacity(0.5)),
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                )
            ],
          );
        }),
      ),
    );
  }
}

class ImageSourceBottomSheet extends StatelessWidget {
  const ImageSourceBottomSheet(
      {required this.licenseType, required this.firmId, super.key});

  final int licenseType;
  final String firmId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UserMRController>();
    return Container(
      height: getScreenPercentSize(context, 14),
      padding: EdgeInsets.symmetric(
        horizontal: blockSizeHorizontal(context: context) * 4,
        vertical: blockSizeVertical(context: context) * 2,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(font22Px(context: context)),
          topRight: Radius.circular(font22Px(context: context)),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () async {
              final image =
                  await ImagePicker().pickImage(source: ImageSource.camera);

              if (image != null) {
                final bytes = await image.readAsBytes();
                final path = image.path;
                String url = '';
                switch (licenseType) {
                  case 1:
                    url = 'https://test.medrpha.com/api/register/mrregisterdl1';
                    break;
                  case 2:
                    url = 'https://test.medrpha.com/api/register/mrregisterdl2';
                    break;
                  case 3:
                    url =
                        'https://test.medrpha.com/api/register/mrregisterfssaiimg';
                    break;
                }

                await controller.uploadLicenses(
                  url: url,
                  path: path,
                  bytes: bytes,
                  firmId: firmId,
                );
              }
              // FocusScope.of(context).unfocus();
              // Navigator.pop(context);
            },
            child: ConstantWidgets().customText(
              value: '📷 Camera',
              fontSize: font18Px(context: context),
              color: ConstantData.mainTextColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: blockSizeVertical(context: context) * 3,
          ),
          InkWell(
            onTap: () async {
              final image =
                  await ImagePicker().pickImage(source: ImageSource.gallery);

              if (image != null) {
                final bytes = await image.readAsBytes();
                final path = image.path;
                String url = '';
                switch (licenseType) {
                  case 1:
                    url = 'https://test.medrpha.com/api/register/mrregisterdl1';
                    break;
                  case 2:
                    url = 'https://test.medrpha.com/api/register/mrregisterdl2';
                    break;
                  case 3:
                    url =
                        'https://test.medrpha.com/api/register/mrregisterfssaiimg';
                    break;
                }

                await controller.uploadLicenses(
                  url: url,
                  path: path,
                  bytes: bytes,
                  firmId: firmId,
                );
              }
              // FocusScope.of(context).unfocus();
              // Navigator.pop(context);
            },
            child: ConstantWidgets().customText(
              value: '🖼️ Gallery',
              fontSize: font18Px(context: context),
              color: ConstantData.mainTextColor,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}

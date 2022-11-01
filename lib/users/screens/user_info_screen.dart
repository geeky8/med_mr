import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:medrpha_trial/users/models/user_model.dart';
import 'package:medrpha_trial/users/utils/image_capture_show_button.dart';
import 'package:medrpha_trial/users/utils/info_tiles.dart';
import 'package:medrpha_trial/utils/constant_data.dart';
import 'package:medrpha_trial/utils/size_config.dart';
import 'package:medrpha_trial/utils/wigets.dart';

class UserInfoScreen extends StatelessWidget {
  const UserInfoScreen({
    Key? key,
    required this.userModel,
  }) : super(key: key);

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ConstantWidgets().customAppBar(
        title: 'User Info',
        context: context,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: blockSizeHorizontal(context: context) * 4,
          vertical: blockSizeVertical(context: context) * 4,
        ),
        child: Column(
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(),
                  ConstantWidgets().customText(
                    value: userModel.firmName,
                    fontSize: font18Px(context: context),
                    color: ConstantData.primaryColor,
                    fontWeight: FontWeight.w700,
                    alignment: TextAlign.center,
                  ),
                  InkWell(
                    child: Image.asset(
                      '${ConstantData.assetsPath}edit.png',
                    ),
                  ),
                ],
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
                border: Border.all(color: ConstantData.clrBorder, width: 1.2),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: blockSizeHorizontal(context: context) * 4,
                      vertical: blockSizeVertical(context: context) * 2,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InfoTiles(
                              label: 'Area',
                              text: userModel.area,
                              crossAxisAlignment: CrossAxisAlignment.start,
                            ),
                            InfoTiles(
                              label: 'City',
                              text: userModel.city,
                              crossAxisAlignment: CrossAxisAlignment.end,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: blockSizeVertical(context: context) * 2,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InfoTiles(
                              label: 'State',
                              text: userModel.state,
                              crossAxisAlignment: CrossAxisAlignment.start,
                            ),
                            InfoTiles(
                              label: 'Country',
                              text: userModel.country,
                              crossAxisAlignment: CrossAxisAlignment.end,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: ConstantData.clrBorder,
                    thickness: blockSizeHorizontal(context: context) / 4,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: blockSizeVertical(context: context) * 2,
                    ),
                    child: Column(
                      children: [
                        InfoTiles(
                          label: 'Phone No',
                          crossAxisAlignment: CrossAxisAlignment.center,
                          text: userModel.phoneNo,
                        ),
                        SizedBox(
                          height: blockSizeVertical(context: context) * 2,
                        ),
                        InfoTiles(
                          label: 'Address',
                          crossAxisAlignment: CrossAxisAlignment.center,
                          text: userModel.address,
                        ),
                        SizedBox(
                          height: blockSizeVertical(context: context) * 2,
                        ),
                        InfoTiles(
                          label: 'Email',
                          crossAxisAlignment: CrossAxisAlignment.center,
                          text: userModel.email,
                        ),
                        SizedBox(
                          height: blockSizeVertical(context: context) * 2,
                        ),
                        InfoTiles(
                          label: 'GST No',
                          crossAxisAlignment: CrossAxisAlignment.center,
                          text: userModel.gstNo,
                        ),
                        SizedBox(
                          height: blockSizeVertical(context: context) * 2,
                        ),
                        InfoTiles(
                          label: 'Drug License Number',
                          crossAxisAlignment: CrossAxisAlignment.center,
                          text: userModel.dlNumber,
                        ),
                        SizedBox(
                          height: blockSizeVertical(context: context) * 2,
                        ),
                        SizedBox(
                          height: blockSizeVertical(context: context) * 2,
                        ),
                        InfoTiles(
                          label: 'Validity',
                          crossAxisAlignment: CrossAxisAlignment.center,
                          text: userModel.dlValidity,
                        ),
                        SizedBox(
                          height: blockSizeVertical(context: context) * 2,
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
                              height: blockSizeVertical(context: context),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ImageCaptureShow(
                                  func: () {
                                    showDialog(
                                      context: context,
                                      builder: (_) => ImageDialog(
                                        img: userModel.dlImage1,
                                      ),
                                    );
                                  },
                                  label: 'DL Image 1 👁',
                                ),
                                SizedBox(
                                  width:
                                      blockSizeHorizontal(context: context) * 4,
                                ),
                                ImageCaptureShow(
                                  func: () {
                                    showDialog(
                                      context: context,
                                      builder: (_) => ImageDialog(
                                        img: userModel.dlImage2,
                                      ),
                                    );
                                  },
                                  label: 'DL Image 2 👁',
                                ),
                              ],
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
    );
  }
}

class ImageDialog extends StatelessWidget {
  const ImageDialog({Key? key, required this.img}) : super(key: key);

  final String img;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: ConstantData.bgColor,
          borderRadius: BorderRadius.circular(
            font22Px(context: context),
          ),
        ),
        child: CachedNetworkImage(
          imageUrl: ConstantData.imagePath + img,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

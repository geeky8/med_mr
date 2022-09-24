// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:medrpha_trial/bottom_navigation/screens/landing_screen.dart';
import 'package:medrpha_trial/enums/inital_registeration.dart';
import 'package:medrpha_trial/enums/store_state.dart';
import 'package:medrpha_trial/enums/user_status.dart';
import 'package:medrpha_trial/users/models/address_model.dart';
import 'package:medrpha_trial/users/models/mr_model.dart';
import 'package:medrpha_trial/users/models/user_model.dart';
import 'package:medrpha_trial/users/repository/users_repository.dart';
import 'package:medrpha_trial/users/screens/register_edit_info_screen.dart';
import 'package:medrpha_trial/users/screens/verify_otp_screen.dart';
import 'package:medrpha_trial/users/utils/string_extension.dart';
import 'package:medrpha_trial/users/utils/success_failure_verification_screen.dart';

class UserMRController extends GetxController {
  final repository = UserRepository();

  final userModel = UserModel(
    firmId: '',
    firmName: '',
    gstNo: '',
    phoneNo: '',
    regDate: '',
    status: '',
    address: '',
    country: '',
    state: '',
    city: '',
    area: '',
    dlImage1: '',
    dlImage2: '',
    dlNumber: '',
    dlValidity: '',
    email: '',
    registerationStatus: RegisterationStatus.COMPLETE,
  ).obs;

  final mrModel = MRModel(
    mrId: '',
    monthInstall: '',
    monthSale: '',
    monthInstallTarget: '',
    monthSaleTarget: '',
    monthInstallPercent: '',
    monthSalepercent: '',
  ).obs;

  final state = (StoreState.SUCCESS).obs;
  final usersList = <UserModel>[].obs;
  final mrList = <MRModel>[].obs;
  final usersStatus = RegisterationStatus.INITAL.obs;
  final initalUsersList = <UserModel>[].obs;

  final countryList = <AddressModel>[].obs;
  final stateList = <AddressModel>[].obs;
  final cityList = <AddressModel>[].obs;
  final areaList = <AddressModel>[].obs;

  Future<void> getUsersList() async {
    state.value = StoreState.LOADING;

    final value = await repository.getUserList();
    if (value != null) {
      if (value.isNotEmpty) {
        usersList
          ..clear()
          ..addAll(value);
        state.value = StoreState.SUCCESS;
      } else {
        state.value = StoreState.EMPTY;
      }
    } else {
      state.value = StoreState.EMPTY;
    }
  }

  Future<void> getMRList() async {
    state.value = StoreState.LOADING;

    final value = await repository.getMRList();
    if (value != null) {
      if (value.isNotEmpty) {
        mrList
          ..clear()
          ..addAll(value);
        state.value = StoreState.SUCCESS;
      } else {
        state.value = StoreState.EMPTY;
      }
    } else {
      state.value = StoreState.EMPTY;
    }
  }

  Future<UserModel> getUserDetails({required UserModel model}) async {
    if (model.dlImage1 == '') {
      final value = await repository.getUserDetails(model: model);
      if (value.dlImage1 != '') {
        final index =
            usersList.indexWhere((element) => element.firmId == value.firmId);
        usersList
          ..removeAt(index)
          ..insert(index, value);
        return value;
      }
    }
    return model;
  }

  Future<void> getCountry() async {
    final value = await repository.getCountries();
    if (value != null) {
      countryList
        ..clear()
        ..addAll(value);
    } else {
      Fluttertoast.showToast(msg: 'No valid countries available');
    }
    if (kDebugMode) {
      print('countri ----$countryList');
    }
  }

  Future<void> getState({required int id}) async {
    state.value = StoreState.LOADING;

    final value = await repository.getState(id: id);
    if (value != null) {
      stateList
        ..clear()
        ..addAll(value);
    } else {
      Fluttertoast.showToast(msg: 'No valid state available');
    }

    state.value = StoreState.SUCCESS;
  }

  Future<void> getCities({required int id}) async {
    state.value = StoreState.LOADING;

    final value = await repository.getCity(id: id);
    if (value != null) {
      cityList
        ..clear()
        ..addAll(value);
      areaList.clear();
    } else {
      Fluttertoast.showToast(msg: 'No valid city available');
    }

    state.value = StoreState.SUCCESS;
  }

  Future<void> register({
    required UserModel model,
    String? fssaiNumber,
    required BuildContext context,
  }) async {
    state.value = StoreState.LOADING;
    final dl = await repository.uploadDLDetails(model: model);
    final firm = await repository.uploadFirmDetails(
      model: model,
      country: model.country.toIntVal(list: countryList),
      state: model.state.toIntVal(list: stateList),
      city: model.city.toIntVal(list: cityList),
      area: model.area.toIntVal(list: areaList),
    );
    if (fssaiNumber != null) {
      final fssai =
          await repository.uploadFssaiDetails(fssaiNumber: fssaiNumber);
      if (fssai) {
        Fluttertoast.showToast(msg: 'FSSAI details registered successfully');
      }
    }

    if (dl && firm) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => LandingScreen(),
        ),
      );
      Fluttertoast.showToast(msg: 'User details registered successfully');
    } else {
      Fluttertoast.showToast(msg: 'Failed to register the user');
    }
    state.value = StoreState.SUCCESS;
  }

  final imageState = (StoreState.SUCCESS).obs;

  Future<void> uploadLicenses({
    required String url,
    required String path,
    required List<int> bytes,
    required String firmId,
  }) async {
    imageState.value = StoreState.LOADING;
    final value = await repository.uploadLicenseImages(
      url: url,
      path: path,
      bytes: bytes,
      firmId: firmId,
    );
    if (value) {
      Fluttertoast.showToast(msg: 'Uploaded successfully');
    } else {
      Fluttertoast.showToast(msg: 'Failed to upload images');
    }
    imageState.value = StoreState.SUCCESS;
  }

  Future<void> getArea({required int id}) async {
    state.value = StoreState.LOADING;

    final value = await repository.getArea(id: id);
    if (value != null) {
      areaList
        ..clear()
        ..addAll(value);
    } else {
      Fluttertoast.showToast(msg: 'No valid areas available');
    }

    state.value = StoreState.SUCCESS;
  }

  Future<void> getOTP(
      {required String contact,
      required BuildContext context,
      bool? resend}) async {
    state.value = StoreState.LOADING;
    final value = await repository.getOTP(
        contact: contact, resend: (resend != null) ? true : null);
    if (value) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => OTPScreen(contact: contact),
        ),
      );
      Fluttertoast.showToast(msg: 'OTP send successfully');
    } else {
      Fluttertoast.showToast(msg: 'Failed to send OTP');
    }

    state.value = StoreState.SUCCESS;
  }

  Future<void> verifyOTP({
    required String contact,
    required String otp,
    required BuildContext context,
  }) async {
    state.value = StoreState.LOADING;
    final value = await repository.verifyOTP(contact: contact, otp: otp);
    if (value != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => VerificationScreen(
            success: true,
            userModel: value,
          ),
        ),
      );
      Fluttertoast.showToast(msg: 'OTP verified successfully');
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const VerificationScreen(
            success: false,
          ),
        ),
      );
      Fluttertoast.showToast(msg: 'Failed to verify the OTP');
    }
    state.value = StoreState.SUCCESS;
  }

  Future<void> initiateRegsiteration({
    required String contact,
    required BuildContext context,
  }) async {
    state.value = StoreState.LOADING;
    final value = await repository.initiateRegisteration(contact: contact);
    if (value != null) {
      switch (value) {
        case RegisterationStatus.INITAL:
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const RegisterEditInfoScreen(),
            ),
          );
          break;
        case RegisterationStatus.COMPLETE:
          Fluttertoast.showToast(msg: 'Registeration completed');
          break;
        case RegisterationStatus.LINK:
          Fluttertoast.showToast(msg: 'Link has been sent successfully');
          break;
      }
      state.value = StoreState.SUCCESS;
    } else {
      Fluttertoast.showToast(msg: 'Failed to regsiter the user');
      state.value = StoreState.EMPTY;
    }
  }

  Future<void> getIntialUsersList() async {
    state.value = StoreState.LOADING;
    final value = await repository.getInitalUsersList();
    if (value != null) {
      initalUsersList
        ..clear()
        ..addAll(value);
    } else {
      Fluttertoast.showToast(msg: 'Failed to get users');
    }
    state.value = StoreState.SUCCESS;
  }

  Future<void> checkStatus({required String contact}) async {
    state.value = StoreState.LOADING;
    final value = await repository.checkUserStatus(contact: contact);
    if (value != null) {
      if (value == RegisterationStatus.LINK) {
        Fluttertoast.showToast(msg: 'Inital Regsiteration pending');
      } else {
        Fluttertoast.showToast(msg: 'Regsiteration successful');
      }
    }
  }
}

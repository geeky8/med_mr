import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:medrpha_trial/enums/mr_type.dart';
import 'package:medrpha_trial/enums/store_state.dart';
import 'package:medrpha_trial/profile/models/profile_model.dart';
import 'package:medrpha_trial/profile/repository/profile_repository.dart';
import 'package:medrpha_trial/utils/storage.dart';

class ProfileController extends GetxController {
  final repository = ProfileRepository();

  final profileModel = ProfileModel(
    name: '',
    userName: '',
    pass: '',
    mobileNo: '',
    mrAddress: '',
    designation: MRType.EXECUTIVE,
  ).obs;
  final state = (StoreState.SUCCESS).obs;

  Future<void> getProfile() async {
    state.value = StoreState.LOADING;
    if (kDebugMode) {
      print('sess Id ------- ${DataStorage().readSessId()}');
    }
    final value =
        await repository.getProfile(sessId: DataStorage().readSessId());
    if (value != null) {
      profileModel.value = value;
      state.value = StoreState.SUCCESS;
    } else {
      state.value = StoreState.EMPTY;
    }
  }
}

// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:medrpha_trial/auth/models/auth_model.dart';
import 'package:medrpha_trial/auth/repository/auth_repository.dart';
import 'package:medrpha_trial/bottom_navigation/screens/landing_screen.dart';
import 'package:medrpha_trial/dashboard/controller/dashboard_controller.dart';
import 'package:medrpha_trial/enums/mr_type.dart';
import 'package:medrpha_trial/enums/store_state.dart';
import 'package:medrpha_trial/profile/controller/profile_controller.dart';
import 'package:medrpha_trial/users/controller/users_mr_controller.dart';
import 'package:medrpha_trial/utils/storage.dart';

import '../../products/controller/product_controller.dart';

class AuthController extends GetxController {
  final repository = AuthRepository();

  final authModel = AuthModel(
    sessId: '',
    mrType: MRType.LEADER,
  ).obs;
  final state = (StoreState.SUCCESS).obs;

  Future<void> login({
    required String username,
    required String pass,
    required MRType mrType,
    required BuildContext context,
  }) async {
    state.value = StoreState.LOADING;
    final stopWatch = Stopwatch()..start();

    final value = await repository.login(
      username: username,
      pass: pass,
      mrType: mrType,
    );
    if (value != null) {
      authModel.value = value;
      DataStorage().writeSessId(value: value.sessId);
      DataStorage().writeMrType(value: value.mrType.toValue());

      print('fetched sessId ---- ${value.sessId}');
      print('stored sessId ----- ${DataStorage().readSessId()}');

      final dashboardController = Get.put(DashboardController());
      final profileController = Get.put(ProfileController());
      final userMrController = Get.put(UserMRController());

      await dashboardController.getDashboard();
      await profileController.getProfile();
      if (authModel.value.mrType == MRType.EXECUTIVE) {
        userMrController
          ..getUsersList()
          ..getIntialUsersList();
      } else {
        userMrController.getMRList();
      }

      state.value = StoreState.SUCCESS;
    final pcontroller = Get.put(ProductController());
    pcontroller.init();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => LandingScreen(),
        ),
      );
      Fluttertoast.showToast(msg: 'Login Successful');
    } else {
      state.value = StoreState.EMPTY;
      Fluttertoast.showToast(msg: 'Login Unsuccessful');
    }
    stopWatch.stop();
    if (kDebugMode) {
      print('time ------${stopWatch.elapsedMilliseconds}');
    }
  }

  Future<void> logout() async {
    state.value = StoreState.LOADING;

    final value = await repository.logout();
    if (value) {
      Fluttertoast.showToast(msg: 'Logout Successful');
    } else {
      Fluttertoast.showToast(msg: 'Logout Unsuccessful');
    }

    state.value = StoreState.SUCCESS;
  }
}

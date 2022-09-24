import 'package:get/get.dart';
import 'package:medrpha_trial/dashboard/models/dashboard_model.dart';
import 'package:medrpha_trial/dashboard/repository/dashobard_repository.dart';
import 'package:medrpha_trial/enums/store_state.dart';

class DashboardController extends GetxController {
  final repository = DashboardRepository();

  final model = DashboardModel().obs;
  final state = (StoreState.SUCCESS).obs;

  Future<void> getDashboard() async {
    state.value = StoreState.LOADING;

    final value = await repository.getDashboardDetails();
    if (value != null) {
      model.value = value;
      state.value = StoreState.EMPTY;
    } else {
      state.value = StoreState.SUCCESS;
    }
  }
}

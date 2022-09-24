import 'package:medrpha_trial/users/models/address_model.dart';

extension NumberString on String {
  int toIntVal({
    required List<AddressModel> list,
  }) {
    final index = list.indexWhere((element) => element.name == this);
    return list[index].id;
  }
}

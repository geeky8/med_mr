import 'package:get_storage/get_storage.dart';

class DataStorage {
  final store = GetStorage();
  final isFirstTime = 'isFirstTime';
  final sessId = 'sessId';
  final mrtype = 'mrtype';

  bool? readIsFirstTime() {
    return store.read(isFirstTime);
  }

  void wirteIsFirstTime({required bool value}) {
    store.write(isFirstTime, value);
  }

  String? readSessId() {
    return store.read(sessId);
  }

  void writeSessId({required String value}) {
    store.write(sessId, value);
  }

  String? reademrType() {
    return store.read(sessId);
  }

  void writeMrType({required String value}) {
    store.write(mrtype, value);
  }
}

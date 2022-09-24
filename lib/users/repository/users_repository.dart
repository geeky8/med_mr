import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medrpha_trial/enums/inital_registeration.dart';
import 'package:medrpha_trial/users/models/address_model.dart';
import 'package:medrpha_trial/users/models/mr_model.dart';
import 'package:medrpha_trial/users/models/user_model.dart';
import 'package:medrpha_trial/utils/storage.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  final userListUrl = 'https://mrtest.medrpha.com/api/user/userlist';
  final mrListUrl = 'https://mrtest.medrpha.com/api/dashboard/tlmrdetails';
  final intialUsersListUrl =
      'https://mrtest.medrpha.com/api/user/initialuserlist';

  final userDetailsUrl = 'https://mrtest.medrpha.com/api/user/viewuser';

  final countryUrl = 'https://mrtest.medrpha.com/api/user/getcountry';
  final stateUrl = 'https://mrtest.medrpha.com/api/user/getstate';
  final cityUrl = 'https://mrtest.medrpha.com/api/user/getcity';
  final areaUrl = 'https://mrtest.medrpha.com/api/user/getpincode';

  final uploadDLUrl = 'https://mrtest.medrpha.com/api/user/registerdlno';
  final uploadDLImage1 = 'https://test.medrpha.com/api/register/mrregisterdl1';
  final uploadDLImage2 = 'https://test.medrpha.com/api/register/mrregisterdl2';
  final uploadFirmDetailsUrl = 'https://mrtest.medrpha.com/api/user/register';
  final uploadFssaiDetailsUrl =
      'https://mrtest.medrpha.com/api/user/registerfssai';
  final uploadFssaiImg =
      'https://test.medrpha.com/api/register/mrregisterfssaiimg';
  final initalRegsiterationUrl =
      'https://mrtest.medrpha.com/api/user/initialregistation';

  final checkInitalStatus = 'https://mrtest.medrpha.com/api/user/checkinitial';

  final otpUrl = 'https://mrtest.medrpha.com/api/user/sendotp';
  final resendOtpUrl = 'https://mrtest.medrpha.com/api/user/resendotp';
  final verifyOtpUrl = 'https://mrtest.medrpha.com/api/user/otpverify';

  Future<List<UserModel>?> getUserList() async {
    final sessId = DataStorage().readSessId();
    if (sessId != null) {
      final body = {"sessid": sessId};

      final resp = await http.post(
        Uri.parse(userListUrl),
        body: body,
      );

      if (resp.statusCode == 200) {
        final respBody = jsonDecode(resp.body) as Map<String, dynamic>;
        if (respBody['status'] as String == '1') {
          final list = <UserModel>[];
          final data = respBody['data'] as List<dynamic>;
          for (final i in data) {
            final model = UserModel.fromJson(json: i);
            list.add(model);
          }
          return list;
        }
      }
    }
    return null;
  }

  Future<List<MRModel>?> getMRList() async {
    final sessId = DataStorage().readSessId();
    if (sessId != null) {
      // final body = {"sessid": sessId};
      final body = {"sessid": '91d876399f3f96b6'};

      final resp = await http.post(
        Uri.parse(mrListUrl),
        body: body,
      );

      if (resp.statusCode == 200) {
        final respBody = jsonDecode(resp.body) as Map<String, dynamic>;
        if (respBody['status'] as String == '1') {
          final list = <MRModel>[];
          final data = respBody['data'] as List<dynamic>;
          for (final i in data) {
            final model = MRModel.fromJson(json: i);
            list.add(model);
          }
          return list;
        }
      }
    }
    return null;
  }

  Future<UserModel> getUserDetails({
    required UserModel model,
  }) async {
    final sessId = DataStorage().readSessId();
    if (sessId != null) {
      final body = {"sessid": sessId, "firm_id": model.firmId};

      final resp = await http.post(
        Uri.parse(userDetailsUrl),
        body: body,
      );

      if (resp.statusCode == 200) {
        final respBody = jsonDecode(resp.body) as Map<String, dynamic>;
        if (respBody['status'] as String == '1') {
          final data = respBody['data'] as Map<String, dynamic>;
          return model.copyWith(
            country: (data['country'] ?? '') as String,
            state: (data['state'] ?? '') as String,
            city: (data['city'] ?? '') as String,
            area: (data['area'] ?? '') as String,
            address: (data['address'] ?? '') as String,
            email: (data['email'] ?? '') as String,
            dlNumber: (data['dlno'] ?? '') as String,
            dlValidity: (data['validdate'] ?? '') as String,
            dlImage1: (data['dl1'] ?? '') as String,
            dlImage2: (data['dl2'] ?? '') as String,
          );
        }
      }
    }
    return model;
  }

  Future<List<AddressModel>?> getCountries() async {
    final sessId = DataStorage().readSessId();

    final body = {"sessid": sessId};

    final resp = await http.post(Uri.parse(countryUrl), body: body);
    if (resp.statusCode == 200) {
      final respBody = jsonDecode(resp.body);
      if (respBody['status'] == '1') {
        final list = respBody['data'] as List<dynamic>;
        final returnList = <AddressModel>[];

        for (final i in list) {
          final data = i as Map<String, dynamic>;
          final model = AddressModel.fromJson(
            name: data['country_name'] as String,
            id: data['countryid'] as int,
          );
          returnList.add(model);
        }

        return returnList;
      }
    }
    return null;
  }

  Future<List<AddressModel>?> getState({required int id}) async {
    final sessId = DataStorage().readSessId();

    final body = {"sessid": sessId, "countid": id.toString()};

    final resp = await http.post(Uri.parse(stateUrl), body: body);
    if (resp.statusCode == 200) {
      final respBody = jsonDecode(resp.body);
      if (respBody['status'] == '1') {
        final list = respBody['data'] as List<dynamic>;
        final returnList = <AddressModel>[];

        for (final i in list) {
          final data = i as Map<String, dynamic>;
          final model = AddressModel.fromJson(
            name: data['state_name'] as String,
            id: data['stateid'] as int,
          );
          returnList.add(model);
        }

        return returnList;
      }
    }
    return null;
  }

  Future<List<AddressModel>?> getCity({required int id}) async {
    final sessId = DataStorage().readSessId();

    final body = {"sessid": sessId, "stateid": id.toString()};

    final resp = await http.post(Uri.parse(cityUrl), body: body);
    if (resp.statusCode == 200) {
      final respBody = jsonDecode(resp.body);
      if (respBody['status'] == '1') {
        final list = respBody['data'] as List<dynamic>;
        final returnList = <AddressModel>[];

        for (final i in list) {
          final data = i as Map<String, dynamic>;
          final model = AddressModel.fromJson(
            name: data['city_name'] as String,
            id: data['cityid'] as int,
          );
          returnList.add(model);
        }

        return returnList;
      }
    }
    return null;
  }

  Future<List<AddressModel>?> getArea({required int id}) async {
    final sessId = DataStorage().readSessId();

    final body = {"sessid": sessId, "cityid": id.toString()};

    final resp = await http.post(Uri.parse(areaUrl), body: body);
    if (resp.statusCode == 200) {
      final respBody = jsonDecode(resp.body);
      if (respBody['status'] == '1') {
        final list = respBody['data'] as List<dynamic>;
        final returnList = <AddressModel>[];

        for (final i in list) {
          final data = i as Map<String, dynamic>;
          final model = AddressModel.fromJson(
            name: data['area_name'] as String,
            id: data['areaid'] as int,
          );
          returnList.add(model);
        }

        return returnList;
      }
    }
    return null;
  }

  Future<bool> uploadDLDetails({required UserModel model}) async {
    final sessId = DataStorage().readSessId();
    if (sessId != null) {
      final body = {
        "sessid": sessId,
        "txtdlno": model.dlNumber,
        "valid": model.dlValidity,
        "txtdlname": model.dlNumber,
        "firm_id": model.firmId
      };

      final resp = await http.post(Uri.parse(uploadDLUrl), body: body);

      debugPrint('---- dl --${resp.body}');

      if (resp.statusCode == 200) {
        final respBody = jsonDecode(resp.body);
        if (respBody['status'] == '1') {
          return true;
        }
      }
    }

    return false;
  }

  Future<bool> uploadFirmDetails({
    required UserModel model,
    required int country,
    required int state,
    required int city,
    required int area,
  }) async {
    final sessId = DataStorage().readSessId();
    if (sessId != null) {
      final body = {
        "firm_id": model.firmId,
        "sessid": sessId,
        "firm_name": model.firmName,
        "phoneno": model.phoneNo,
        "txtemail": model.email,
        "countryid": country.toString(),
        "stateid": state.toString(),
        "cityid": city.toString(),
        "Areaid": area.toString(),
        "address": model.address,
        "PersonName": model.firmName,
        "PersonNumber": model.phoneNo,
        "AlternateNumber": model.phoneNo,
      };

      final resp = await http.post(Uri.parse(uploadFirmDetailsUrl), body: body);

      debugPrint('---- regsiter ---- ${resp.body}');

      if (resp.statusCode == 200) {
        final respBody = jsonDecode(resp.body);
        if (respBody['status'] == '1') {
          return true;
        }
      }
    }
    return false;
  }

  Future<bool> uploadFssaiDetails({required String fssaiNumber}) async {
    final sessId = DataStorage().readSessId();

    if (sessId != null) {
      final body = {
        "firm_id": "22",
        "sessid": sessId,
        "fssaiNo": fssaiNumber,
      };

      final resp =
          await http.post(Uri.parse(uploadFssaiDetailsUrl), body: body);
      if (resp.statusCode == 200) {
        final respBody = jsonDecode(resp.body);
        if (respBody['status'] == '1') {
          return true;
        }
      }
    }
    return false;
  }

  Future<bool> uploadLicenseImages({
    required String url,
    required String path,
    required List<int> bytes,
    required String firmId,
  }) async {
    final sessId = DataStorage().readSessId();
    if (sessId != null) {
      final body = {"sessid": sessId, "firm_id": firmId};
      final file = await http.MultipartFile.fromPath('image', path);
      final request = http.MultipartRequest('POST', Uri.parse(url))
        ..fields.addAll(body)
        ..files.add(file);
      // ..headers.addAll(headers);
      debugPrint('---image body ---${request..fields}');
      final respStream = await request.send();
      // print(object)
      final resp = await http.Response.fromStream(respStream);
      debugPrint('------images ${resp.body}');
      if (resp.statusCode == 200) {
        Fluttertoast.showToast(msg: 'Uploaded successfully');
        return true;
      }
    }
    return false;
  }

  Future<RegisterationStatus?> initiateRegisteration(
      {required String contact}) async {
    final sessId = DataStorage().readSessId();
    if (sessId != null) {
      final body = {"sessid": sessId, "contact": contact};

      final resp = await http.post(
        Uri.parse(initalRegsiterationUrl),
        body: body,
      );

      if (resp.statusCode == 200) {
        final respBody = jsonDecode(resp.body) as Map<String, dynamic>;
        if (respBody['status'] as String == '1') {
          return RegisterationStatus.LINK;
        } else if (respBody['status'] as String == '2') {
          return RegisterationStatus.INITAL;
        } else {
          return RegisterationStatus.COMPLETE;
        }
      }
    }

    return null;
  }

  Future<List<UserModel>?> getInitalUsersList({String? search}) async {
    final sessId = DataStorage().readSessId();
    if (sessId != null) {
      final body = {"sessid": sessId};

      final resp = await http.post(
        Uri.parse(intialUsersListUrl),
        body: body,
      );

      if (resp.statusCode == 200) {
        final respBody = jsonDecode(resp.body) as Map<String, dynamic>;
        if (respBody['status'] as String == '1') {
          final data = respBody['data'] as List<dynamic>;
          final list = <UserModel>[];
          for (final i in data) {
            final model =
                UserModel.initalUsers(json: i as Map<String, dynamic>);
            list.add(model);
          }
          return list;
        }
      }
    }
    return null;
  }

  Future<RegisterationStatus?> checkUserStatus(
      {required String contact}) async {
    final sessId = DataStorage().readSessId();
    if (sessId != null) {
      final body = {"sessid": sessId, "contact": contact};

      final resp = await http.post(
        Uri.parse(intialUsersListUrl),
        body: body,
      );

      if (resp.statusCode == 200) {
        final respBody = jsonDecode(resp.body) as Map<String, dynamic>;
        if (respBody['status'] as String == '1') {
          return RegisterationStatus.COMPLETE;
        } else {
          return RegisterationStatus.LINK;
        }
      }
    }
    return null;
  }

  Future<bool> getOTP({required String contact, bool? resend}) async {
    final sessId = DataStorage().readSessId();
    if (sessId != null) {
      final body = {"sessid": sessId, "contact": contact};

      final resp = await http.post(
        Uri.parse((resend != null) ? resendOtpUrl : otpUrl),
        body: body,
      );

      if (resp.statusCode == 200) {
        final respBody = jsonDecode(resp.body) as Map<String, dynamic>;
        if (respBody['status'] == '1') return true;
      }
    }
    return false;
  }

  Future<UserModel?> verifyOTP(
      {required String contact, required String otp}) async {
    final sessId = DataStorage().readSessId();
    if (sessId != null) {
      final body = {"sessid": sessId, "contact": contact, "otp": otp};

      final resp = await http.post(
        Uri.parse(verifyOtpUrl),
        body: body,
      );

      if (resp.statusCode == 200) {
        final respBody = jsonDecode(resp.body) as Map<String, dynamic>;
        if (respBody['status'] == '1') {
          final data = respBody['data'] as Map<String, dynamic>;
          return UserModel.initalUsers(json: data);
        }
      }
    }
    return null;
  }
}

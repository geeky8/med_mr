import 'dart:convert';

import 'package:medrpha_trial/auth/models/auth_model.dart';
import 'package:medrpha_trial/enums/mr_type.dart';
import 'package:http/http.dart' as http;
import 'package:medrpha_trial/utils/storage.dart';

class AuthRepository {
  final loginUrl = 'https://mrtest.medrpha.com/api/login/login';
  final logoutUrl = 'https://mrtest.medrpha.com/api/login/logout';

  Future<AuthModel?> login({
    required String username,
    required String pass,
    required MRType mrType,
  }) async {
    final body = {
      "mrtype": mrType.toValue(),
      "username": username,
      "password": pass
    };

    final resp = await http.post(
      Uri.parse(loginUrl),
      body: body,
    );
    print("login ${resp.body}");
    if (resp.statusCode == 200) {
      final respBody = jsonDecode(resp.body);
      if (respBody['status'] as String == '1') {
        final data = respBody['data'] as Map<String, dynamic>;
        return AuthModel(
          sessId: data['sessID'] as String,
          mrType: (mrTypefromValue(type: data['mrtype'] as String)),
        );
      }
    }
    return null;
  }

  Future<bool> logout() async {
    final sessId = DataStorage().readSessId();
    if (sessId != null) {
      final body = {"sessid": sessId};

      final resp = await http.post(
        Uri.parse(logoutUrl),
        body: body,
      );

      if (resp.statusCode == 200) {
        final respBody = jsonDecode(resp.body);
        if (respBody['status'] as String == '1') {
          return true;
        }
      }
    }
    return false;
  }
}

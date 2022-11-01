import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:medrpha_trial/profile/models/profile_model.dart';
import 'package:medrpha_trial/utils/storage.dart';
import 'package:http/http.dart' as http;

class ProfileRepository {
  final profileUrl = 'https://mrtest.medrpha.com/api/profile/profile';

  Future<ProfileModel?> getProfile() async {
    final sessId = DataStorage().readSessId();
    if (sessId != null) {
      final body = {"sessid": sessId};

      final resp = await http.post(
        Uri.parse(profileUrl),
        body: body,
      );

      if (kDebugMode) {
        print('profile -----------${resp.body}');
      }

      if (resp.statusCode == 200) {
        final respBody = jsonDecode(resp.body) as Map<String, dynamic>;
        if (respBody['status'] as String == '1') {
          final data = respBody['data'] as Map<String, dynamic>;
          return ProfileModel.fromJson(json: data);
        }
      }
    }

    return null;
  }
}

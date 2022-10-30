import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:medrpha_trial/dashboard/models/dashboard_model.dart';
import 'package:medrpha_trial/utils/storage.dart';
import 'package:http/http.dart' as http;

class DashboardRepository {
  final dashboardUrl = 'https://mrtest.medrpha.com/api/dashboard/mrdashboard';

  Future<DashboardModel?> getDashboardDetails() async {
    final sessId = DataStorage().readSessId();
    if (sessId != null) {
      final body = {"sessid": sessId};

      final resp = await http.post(
        Uri.parse(dashboardUrl),
        body: body,
      );

      debugPrint('------ dashboard-----${resp.body}');

      if (resp.statusCode == 200) {
        final respBody = jsonDecode(resp.body);
        if (respBody['status'] as String == '1') {
          final data = respBody['data'] as Map<String, dynamic>;
          final model = DashboardModel.fromJson(json: data);
          return model;
        }
      }
    }
    return null;
  }
}

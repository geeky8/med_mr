import 'package:medrpha_trial/enums/mr_type.dart';

class AuthModel {
  AuthModel({
    required this.sessId,
    required this.mrType,
  });

  copyWith({String? sessId, MRType? mrType}) {
    return AuthModel(
      sessId: sessId ?? this.sessId,
      mrType: mrType ?? this.mrType,
    );
  }

  final String sessId;
  final MRType mrType;
}

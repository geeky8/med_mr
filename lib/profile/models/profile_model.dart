import 'package:medrpha_trial/enums/mr_type.dart';

class ProfileModel {
  ProfileModel({
    required this.name,
    required this.userName,
    required this.pass,
    required this.mobileNo,
    required this.mrAddress,
    required this.designation,
  });

  factory ProfileModel.fromJson({required Map<String, dynamic> json}) {
    return ProfileModel(
      name: (json['mr_nm'] ?? '') as String,
      userName: (json['mr_unm'] ?? '') as String,
      pass: (json['mr_ps'] ?? '') as String,
      mobileNo: (json['mrmobile'] ?? '') as String,
      mrAddress: (json['mrAddress'] ?? '') as String,
      designation:
          mrTypefromValue(type: (json['strhdnDes_id'] ?? '2') as String),
    );
  }

  final String name;
  final String userName;
  final String pass;
  final String mobileNo;
  final String mrAddress;
  final MRType designation;
}

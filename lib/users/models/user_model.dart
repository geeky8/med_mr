import 'package:medrpha_trial/enums/inital_registeration.dart';
import 'package:medrpha_trial/enums/user_status.dart';

class UserModel {
  UserModel({
    required this.firmId,
    required this.firmName,
    required this.gstNo,
    required this.phoneNo,
    required this.regDate,
    required this.status,
    required this.address,
    required this.country,
    required this.state,
    required this.city,
    required this.area,
    required this.dlNumber,
    required this.dlValidity,
    required this.dlImage1,
    required this.dlImage2,
    required this.email,
    required this.registerationStatus,
  });

  factory UserModel.fromJson({required Map<String, dynamic> json}) {
    return UserModel(
      firmId: (json['firm_id'] ?? '') as String,
      firmName: (json['firm_name'] ?? '') as String,
      gstNo: (json['gstno'] ?? 'NA') as String,
      phoneNo: (json['phoneno'] ?? '') as String,
      regDate: (json['registration_date'] ?? '') as String,
      status: (json['status'] ?? '') as String,
      address: '',
      country: '',
      state: '',
      city: '',
      area: '',
      dlNumber: '',
      dlValidity: '',
      dlImage1: '',
      dlImage2: '',
      email: '',
      registerationStatus: RegisterationStatus.COMPLETE,
    );
  }

  factory UserModel.initalUsers({required Map<String, dynamic> json}) {
    return UserModel(
      firmId: (json['firm_id'] ?? '0') as String,
      firmName: '',
      gstNo: '',
      phoneNo: (json['phoneno'] ?? '') as String,
      regDate: '',
      status: '',
      address: '',
      country: '',
      state: '',
      city: '',
      area: '',
      dlNumber: '',
      dlValidity: '',
      dlImage1: '',
      dlImage2: '',
      email: '',
      registerationStatus: getRegisterationStatusFromValue(
          status: (json['contactstatus'] ?? '') as String),
    );
  }

  UserModel copyWith({
    String? country,
    String? state,
    String? city,
    String? area,
    String? address,
    String? dlNumber,
    String? dlValidity,
    String? dlImage1,
    String? dlImage2,
    String? firmName,
    String? gstNo,
    String? phoneNo,
    String? status,
    String? email,
    RegisterationStatus? registerationStatus,
  }) {
    return UserModel(
      firmId: firmId,
      firmName: firmName ?? this.firmName,
      gstNo: gstNo ?? this.gstNo,
      phoneNo: phoneNo ?? this.phoneNo,
      regDate: regDate,
      status: status ?? this.status,
      country: country ?? this.country,
      state: state ?? this.state,
      city: city ?? this.city,
      area: area ?? this.area,
      address: address ?? this.address,
      dlNumber: dlNumber ?? this.dlNumber,
      dlValidity: dlValidity ?? this.dlValidity,
      dlImage1: dlImage1 ?? this.dlImage1,
      dlImage2: dlImage2 ?? this.dlImage2,
      email: email ?? this.email,
      registerationStatus: registerationStatus ?? this.registerationStatus,
    );
  }

  final String firmId;
  final String firmName;
  final String gstNo;
  final String phoneNo;
  final String regDate;
  final String status;
  final String country;
  final String state;
  final String city;
  final String area;
  final String address;
  final String dlNumber;
  final String dlValidity;
  final String dlImage1;
  final String dlImage2;
  final String email;
  final RegisterationStatus registerationStatus;
  // final String fssaiNumber;
  // final String fssaiImg;
}

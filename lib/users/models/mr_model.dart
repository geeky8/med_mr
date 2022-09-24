class MRModel {
  MRModel({
    required this.mrId,
    required this.monthInstall,
    required this.monthSale,
    required this.monthInstallTarget,
    required this.monthSaleTarget,
    required this.monthInstallPercent,
    required this.monthSalepercent,
  });

  factory MRModel.fromJson({required Map<String, dynamic> json}) {
    return MRModel(
      mrId: (json['mr_unmall'] ?? '') as String,
      monthInstall: (json['monthinstalall'] ?? '') as String,
      monthSale: (json['monthsaleall'] ?? '') as String,
      monthInstallTarget: (json['monthinstaltargall'] ?? '') as String,
      monthSaleTarget: (json['monthsaletargall'] ?? '') as String,
      monthInstallPercent: (json['monthinstaltpercentall'] ?? '') as String,
      monthSalepercent: (json['monthsalepercentall'] ?? '') as String,
    );
  }

  final String mrId;
  final String monthInstall;
  final String monthSale;
  final String monthInstallTarget;
  final String monthSaleTarget;
  final String monthInstallPercent;
  final String monthSalepercent;
}

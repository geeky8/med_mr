class DashboardModel {
  DashboardModel({
    this.monthlInstallationTagert,
    this.monthSaleTarget,
    this.totalInstallTarget,
    this.totalSaleTarget,
    this.monthInstall,
    this.monthSale,
    this.monthinstallPercent,
    this.monthSalePercent,
  });

  factory DashboardModel.fromJson({required Map<String, dynamic> json}) {
    return DashboardModel(
      monthlInstallationTagert: (json['monthinstaltarg'] ?? '') as String,
      monthSaleTarget: (json['monthsaletarg'] ?? '') as String,
      totalInstallTarget: (json['totaltnstallation'] ?? '') as String,
      totalSaleTarget: (json['totalsale'] ?? '') as String,
      monthInstall: (json['monthinstal'] ?? '') as String,
      monthSale: (json['monthsale'] ?? '') as String,
      monthinstallPercent: (json['monthinstaltpercent'] ?? '') as String,
      monthSalePercent: (json['monthsalepercent'] ?? '') as String,
    );
  }

  final String? monthlInstallationTagert;
  final String? monthSaleTarget;
  final String? totalInstallTarget;
  final String? totalSaleTarget;
  final String? monthInstall;
  final String? monthSale;
  final String? monthinstallPercent;
  final String? monthSalePercent;
}

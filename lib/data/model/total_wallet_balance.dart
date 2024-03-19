class TotalWalletBalance {
  Data? data;

  TotalWalletBalance({this.data});

  TotalWalletBalance.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? walletBalance;

  Data({this.walletBalance});

  Data.fromJson(Map<String, dynamic> json) {
    walletBalance = json['wallet_balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wallet_balance'] = this.walletBalance;
    return data;
  }
}
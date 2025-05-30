import 'package:quomia/models/crypto/item.dart';

class Balance {
  String walletBalance;
  String priceBalance;
  String nftsAmount;
  String estimatedValue;
  Item percentage;
  Item lossProfit;

  Balance(
      {required this.walletBalance,
      required this.priceBalance,
      required this.nftsAmount,
      required this.estimatedValue,
      required this.percentage,
      required this.lossProfit});

  factory Balance.fromJson(Map<String, dynamic> json) {
    return Balance(
        walletBalance: json['walletBalance'],
        priceBalance: json['priceBalance'],
        nftsAmount: json['nftsAmount'],
        estimatedValue: json['estimatedValue'],
        percentage: Item.fromJson(json['percentage']),
        lossProfit: Item.fromJson(json['lossProfit']));
  }
}

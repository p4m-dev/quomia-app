class Balance {
  String walletBalance;
  String priceBalance;
  String nftsAmount;
  String estimatedValue;
  String percentage;
  String lossProfit;

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
        percentage: json['percentage'],
        lossProfit: json['lossProfit']);
  }
}

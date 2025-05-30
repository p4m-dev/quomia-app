class Item {
  String symbol;
  String value;

  Item({
    required this.symbol,
    required this.value,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      symbol: json['symbol'],
      value: json['value'],
    );
  }
}

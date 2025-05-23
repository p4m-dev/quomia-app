class NFT {
  String boxId;
  String name;
  String uri;
  String mintAddress;
  DateTime startDate;
  DateTime endDate;
  double initialPrice;

  NFT(
      {required this.boxId,
      required this.name,
      required this.uri,
      required this.mintAddress,
      required this.startDate,
      required this.endDate,
      required this.initialPrice});

  factory NFT.fromJson(Map<String, dynamic> json) {
    return NFT(
        boxId: json['boxId'],
        name: json['name'],
        uri: json['uri'],
        mintAddress: json['mintAddress'],
        startDate: DateTime.parse(json['startDate']),
        endDate: DateTime.parse(json['endDate']),
        initialPrice: (json['initialPrice'] as num).toDouble());
  }
}

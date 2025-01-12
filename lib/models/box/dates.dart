class Dates {
  DateTime startDate;
  DateTime endDate;
  DateTime? deliveryDate;

  Dates({required this.startDate, required this.endDate, this.deliveryDate});

  factory Dates.fromJson(Map<String, dynamic> json) {
    return Dates(
        startDate: DateTime.parse(json['startDate']),
        endDate: DateTime.parse(json['endDate']),
        deliveryDate: DateTime.parse(json['deliveryDate']));
  }
}

class Dates {
  DateTime startDate;
  DateTime endDate;

  Dates({required this.startDate, required this.endDate});

  factory Dates.fromJson(Map<String, dynamic> json) {
    return Dates(
        startDate: DateTime.parse(json['startDate']),
        endDate: DateTime.parse(json['endDate']));
  }
}

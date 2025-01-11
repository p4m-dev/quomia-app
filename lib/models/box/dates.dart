import 'package:quomia/utils/date_utils.dart';

class Dates {
  DateTime startDate;
  DateTime endDate;
  DateTime? deliveryDate;

  Dates({required this.startDate, required this.endDate, this.deliveryDate});

  factory Dates.fromJson(Map<String, dynamic> json) {
    return Dates(
        startDate: CustomDateUtils.timestampToDateTime(json['startDate']),
        endDate: CustomDateUtils.timestampToDateTime(json['endDate']));
  }
}

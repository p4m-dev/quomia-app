import 'package:quomia/models/box/request/range.dart';
import 'package:quomia/utils/date_utils.dart';

class Dates {
  final Range range;
  final DateTime? deliveryDate;
  final List<DateTime>? future;

  const Dates({required this.range, this.deliveryDate, this.future});

  Map<String, dynamic> toJson() {
    return {
      'range': range.toJson(),
      if (deliveryDate != null)
        'deliveryDate': CustomDateUtils.parseDate(deliveryDate!),
      if (future != null && future!.isNotEmpty)
        'future':
            future!.map((date) => CustomDateUtils.parseDate(date)).toList(),
    };
  }
}

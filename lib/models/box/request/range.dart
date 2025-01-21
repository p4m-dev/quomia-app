import 'package:quomia/utils/date_utils.dart';

class Range {
  final DateTime start;
  final DateTime end;

  const Range({required this.start, required this.end});

  Map<String, dynamic> toJson() {
    return {
      'start': CustomDateUtils.parseDate(start),
      'end': CustomDateUtils.parseDate(end)
    };
  }
}

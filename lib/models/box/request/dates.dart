import 'package:quomia/models/box/request/range.dart';

class Dates {
  final Range range;

  const Dates({required this.range});

  Map<String, dynamic> toJson() {
    return {
      'range': range.toJson(),
    };
  }
}

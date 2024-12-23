import 'package:quomia/models/box/box_type.dart';
import 'package:quomia/models/box/category.dart';

class Info {
  String title;
  BoxType type;
  Category category;
  bool? isAnonymous;
  String accessCode;

  Info(
      {required this.title,
      required this.type,
      required this.category,
      this.isAnonymous,
      required this.accessCode});
}

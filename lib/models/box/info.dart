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

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
      title: json['title'],
      type: BoxTypeExtension.fromString(json['type']),
      category: CategoryExtension.fromString(json['category']),
      isAnonymous: json['isAnonymous'],
      accessCode: json['accessCode'],
    );
  }
}

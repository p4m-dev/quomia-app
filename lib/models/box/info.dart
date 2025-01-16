import 'package:quomia/models/box/box_type.dart';
import 'package:quomia/models/box/category.dart';
import 'package:quomia/models/box/comments.dart';

class Info {
  String title;
  BoxType type;
  Category category;
  bool? isAnonymous;
  String accessCode;
  int likes;
  Comments comments;

  Info(
      {required this.title,
      required this.type,
      required this.category,
      this.isAnonymous,
      required this.accessCode,
      required this.likes,
      required this.comments});

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
        title: json['title'],
        type: BoxTypeExtension.fromString(json['type']),
        category: CategoryExtension.fromString(json['category']),
        isAnonymous: json['isAnonymous'],
        accessCode: json['accessCode'],
        likes: json['likes'],
        comments: Comments.fromJson(json['comments']));
  }
}

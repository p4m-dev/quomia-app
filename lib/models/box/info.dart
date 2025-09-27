import 'package:quomia/models/box/category.dart';
import 'package:quomia/models/box/comments.dart';

class Info {
  String title;
  Category category;
  String accessCode;
  int likes;
  Comments comments;

  Info(
      {required this.title,
      required this.category,
      required this.accessCode,
      required this.likes,
      required this.comments});

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'category': category,
      'accessCode': accessCode,
      'likes': likes,
      'comments': comments,
    };
  }

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
        title: json['title'],
        category: CategoryExtension.fromString(json['category']),
        accessCode: json['accessCode'],
        likes: json['likes'],
        comments: Comments.fromJson(json['comments']));
  }
}

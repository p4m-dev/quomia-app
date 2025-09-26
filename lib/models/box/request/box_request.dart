import 'package:quomia/models/box/box_type.dart';
import 'package:quomia/models/box/category.dart';
import 'package:quomia/models/box/location.dart';
import 'package:quomia/models/box/request/dates.dart';
import 'package:quomia/models/box/request/file_item.dart';

class BoxRequest {
  final String sender;
  final String? receiver;
  final String title;
  final Category category;
  final FileItem? file;
  final Location? location;
  final String? message;
  final bool? isAnonymous;
  final Dates dates;

  const BoxRequest(
      {required this.sender,
      this.receiver,
      required this.title,
      required this.category,
      this.file,
      this.location,
      this.message,
      this.isAnonymous,
      required this.dates});

  Map<String, dynamic> toJson() {
    return {
      'sender': sender,
      'receiver': receiver,
      'title': title,
      'category': category.name,
      'file': file?.toJson(),
      'location': location,
      'message': message,
      'isAnonymous': isAnonymous,
      'dates': dates.toJson(),
    };
  }
}

import 'package:quomia/models/box/box_type.dart';
import 'package:quomia/models/box/category.dart';
import 'package:quomia/models/box/request/dates.dart';
import 'package:quomia/models/box/request/file.dart';

class BoxRequest {
  final String sender;
  final String? receiver;
  final String title;
  final BoxType type;
  final Category category;
  final File? file;
  final String? message;
  final bool? isAnonymous;
  final Dates dates;

  const BoxRequest(
      {required this.sender,
      this.receiver,
      required this.title,
      required this.type,
      required this.category,
      this.file,
      this.message,
      this.isAnonymous,
      required this.dates});
}

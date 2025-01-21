import 'package:quomia/models/box/file_type.dart';

class Content {
  String? message;
  String? filePath;
  FileType? fileType;

  Content({this.message, this.filePath, this.fileType});

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
        message: json['message'] as String?,
        filePath: json['filePath'] as String?,
        fileType: FileTypeExtension.fromString(json['fileType']));
  }
}

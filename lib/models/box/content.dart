import 'package:file_picker/file_picker.dart';
import 'package:quomia/models/box/file_type.dart';

class Content {
  String? message;
  String? downloadUrl;
  FileType? fileType;
  String? imageBlurhash;
  String? videoThumbnailUrl;

  Content(
      {this.message,
      this.downloadUrl,
      this.fileType,
      this.imageBlurhash,
      this.videoThumbnailUrl});

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
        message: json['message'] as String?,
        downloadUrl: json['downloadUrl'] as String?,
        fileType: FileTypeExtension.fromString(json['fileType']),
        imageBlurhash: json['imageBlurhash'] as String?,
        videoThumbnailUrl: json['videoThumbnailUrl'] as String?);
  }
}

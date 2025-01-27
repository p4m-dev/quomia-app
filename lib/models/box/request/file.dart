import 'package:quomia/models/box/file_type.dart';

class File {
  final FileType fileType;
  final String downloadUrl;

  const File({required this.fileType, required this.downloadUrl});

  Map<String, dynamic> toJson() {
    return {
      'fileType': fileType.name,
      'downloadUrl': downloadUrl,
    };
  }
}

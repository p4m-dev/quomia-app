import 'package:quomia/models/box/file_type.dart';

class FileUtils {
  static FileType convertExtensionToFileType(String fileExtension) {
    switch (fileExtension) {
      case 'jpg':
        return FileType.image;
      case 'png':
        return FileType.image;
      case 'mp4':
        return FileType.video;
      case 'mp3':
        return FileType.audio;
      case 'wav':
        return FileType.audio;
      default:
        return FileType.text;
    }
  }
}

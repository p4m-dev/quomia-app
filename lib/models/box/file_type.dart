import 'package:file_picker/file_picker.dart';

extension FileTypeExtension on FileType {
  static FileType? fromString(String type) {
    switch (type) {
      case 'image':
        return FileType.image;
      case 'video':
        return FileType.video;
      case 'audio':
        return FileType.audio;
      default:
        return FileType.any;
    }
  }

  bool get isImage => this == FileType.image;
}

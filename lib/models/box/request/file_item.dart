import 'package:file_picker/file_picker.dart';

class FileItem {
  final FileType fileType;
  final String downloadUrl;
  final String? videoThumbnailUrl;
  final String? imageBlurhash;

  const FileItem(
      {required this.fileType,
      required this.downloadUrl,
      this.videoThumbnailUrl,
      this.imageBlurhash});

  Map<String, dynamic> toJson() {
    return {
      'fileType': fileType.name,
      'downloadUrl': downloadUrl,
      if (videoThumbnailUrl != null) 'videoThumbnailUrl': videoThumbnailUrl,
      if (imageBlurhash != null) 'imageBlurhash': imageBlurhash
    };
  }
}

import 'package:file_picker/file_picker.dart';

class File {
  final FileType fileType;
  final String downloadUrl;
  final String? imageBlurhash;
  final String? videoThumbnailUrl;

  const File(
      {required this.fileType,
      required this.downloadUrl,
      this.imageBlurhash,
      this.videoThumbnailUrl});

  Map<String, dynamic> toJson() {
    return {
      'fileType': fileType.name,
      'downloadUrl': downloadUrl,
      if (imageBlurhash != null) 'imageBlurhash': imageBlurhash,
      if (videoThumbnailUrl != null) 'videoThumbnailUrl': videoThumbnailUrl
    };
  }
}

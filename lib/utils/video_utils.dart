import 'dart:io';

import 'package:video_thumbnail/video_thumbnail.dart';

class VideoUtils {
  static Future<File?> generateThumbnail(String videoPath) async {
    try {
      final thumbnailPath = await VideoThumbnail.thumbnailFile(
        video: videoPath,
        imageFormat: ImageFormat.JPEG,
        maxHeight: 200,
        quality: 75,
      );

      return thumbnailPath != null ? File(thumbnailPath) : null;
    } catch (e) {
      print("Errore nella generazione della thumbnail: $e");
      return null;
    }
  }
}

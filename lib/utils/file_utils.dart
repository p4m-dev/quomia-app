import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:video_compress/video_compress.dart';

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
        return FileType.any;
    }
  }

  static Future<Map<String, dynamic>> selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'mp4', 'mp3', 'wav'],
      withData: true,
    );

    if (result == null) {
      print('Nessun file selezionato.');
      return Map.identity();
    }

    final filePath = result.files.single.path;
    final fileName = result.files.single.name;
    final fileExtension = fileName.split('.').last.toLowerCase();
    final fileBytes = result.files.first.bytes;

    return {
      'filePath': filePath,
      'fileName': fileName,
      'fileBytes': fileBytes,
      'fileExtension': fileExtension
    };
  }

  static String retrieveContentType(String fileExtension) {
    switch (fileExtension) {
      case 'jpg':
        return 'image/jpg';
      case 'png':
        return 'image/png';
      case 'mp4':
        return "video/mp4";
      case 'mp3':
        return "audio/mp3";
      case 'wav':
        return "audio/wav";
      default:
        return "";
    }
  }

  static String buildFilePath(String fileExtension, String sender) {
    String basePath = "files/$sender";

    late String contentPath;

    switch (fileExtension) {
      case 'png':
        contentPath = "image";
        break;
      case 'jpg':
        contentPath = "image";
        break;
      case 'wav':
        contentPath = "audio";
        break;
      case 'mp3':
        contentPath = "audio";
        break;
      case 'mp4':
        contentPath = "video";
        break;
    }

    return "$basePath/$contentPath";
  }

  static Future<File?> optimizeFile(String filePath) async {
    final info = await VideoCompress.compressVideo(
      filePath,
      quality: VideoQuality.DefaultQuality,
      deleteOrigin: false,
    );

    return info?.file;
  }
}
